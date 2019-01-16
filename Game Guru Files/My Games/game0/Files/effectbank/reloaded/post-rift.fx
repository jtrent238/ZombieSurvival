//This shader provides an automatic adaptive bloom effect based on screen brightness to scale the bloom effect
//Shader code by Mark Blosser
//email: mjblosser@gmail.com
//website: www.mjblosser.com
//released under creative commons license by attribution: http://creativecommons.org/licenses/by-sa/3.0/
string Description = "Adaptive Bloom by bond1";
string Thumbnail = "Blur.png";

// from DBP
float4x4 World : World;
float2 ViewSize : ViewSize;

// from ENGINE
float2 LensCenter;
float2 ScreenCenter;
float2 Scale;
float2 ScaleIn;
float4 HmdWarpParam;


//-----TWEAKABLES--------------------------------------------------------------------------------------//

float PreBloomBoost 
<
	string UIWidget = "slider";
	float UIMax = 4.0;
	float UIMin = 0.0;
	float UIStep = 0.1;
> = 2.0f;

float BloomThreshold 
<
	string UIWidget = "slider";
	float UIMax = 1.0;
	float UIMin = 0.0;
	float UIStep = 0.05;
> = 0.4;

float PostBloomBoost 
<
	string UIWidget = "slider";
	float UIMax = 4.0;
	float UIMin = 0.0;
	float UIStep = 0.1;
> = 4.0f;

float Brightness
<
	string UIWidget = "slider";
	float UIMax = 1.0;
	float UIMin = 0.0;
	float UIStep = 0.001;
> = 1.0f;

float4 ScreenColor
<   string UIType = "Screen Color Effect";
> = {0.0f, 0.0f, 0.0f, 0.0f};


/*float width 
<
	string UIWidget = "slider";
	float UIMax = 10.0;
	float UIMin = 1;
	float UIStep = 0.01;
> = 2.5;*/

//9 sample gauss filter, declare in pixel offsets convert to texel offsets in PS
float4 GaussFilter[9] =
{
    { -1,  -1, 0,  0.0625 },
    { -1,   1, 0,  0.0625 },
    {  1,  -1, 0,  0.0625 },
    {  1,   1, 0,  0.0625 },
    { -1,   0, 0,  0.125  },
    {  1,   0, 0,  0.125  },
    {  0,  -1, 0,  0.125 },
    {  0,   1, 0,  0.125 },
    {  0,   0, 0,  0.25 },
};



//---------------RENDER TARGET TEXTURES-------------------------------------------------------------------//

//starting scene image
texture frame : RENDERCOLORTARGET
< 
	string ResourceName = "";
	float2 ViewportRatio = {1.0,1.0 };
	
>;

sampler2D frameSamp = sampler_state {
    Texture = < frame >;
    MinFilter = Linear; MagFilter = Linear; MipFilter = Linear;
    AddressU = Clamp; AddressV = Clamp;
};

//2x2 average luminosity texture using point sampling
texture AvgLum2x2Img : RENDERCOLORTARGET 
< 
	string ResourceName = ""; 
	//float2 ViewportRatio = { 0.5, 0.5 };
	int width = 2;
	int height = 2;
>;

sampler2D AvgLum2x2ImgSamp = sampler_state {
    Texture = < AvgLum2x2Img >;
    MinFilter = Point; MagFilter = Point; MipFilter = Point;
    AddressU = Clamp; AddressV = Clamp;
};

//Average scene luminosity stored in 1x1 texture 
texture AvgLumFinal : RENDERCOLORTARGET 
< 
	string ResourceName = ""; 
	//float2 ViewportRatio = { 0.5, 0.5 };
	int width = 1;
	int height = 1;
>;

sampler2D AvgLumFinalSamp = sampler_state {
    Texture = < AvgLumFinal >;
    MinFilter = Point; MagFilter = Point; MipFilter = Point;
    AddressU = Clamp; AddressV = Clamp;
};

//reduce image to 1/8 size for brightpass
texture BrightpassImg : RENDERCOLORTARGET
< 
	string ResourceName = "";
	//float2 ViewportRatio = {0.125,0.125 };
	int width = 512;
	int height = 384;
	
>;

sampler2D BrightpassImgSamp = sampler_state {
    Texture = < BrightpassImg >;
    MinFilter = Linear; MagFilter = Linear; MipFilter = Linear;
    AddressU = Clamp; AddressV = Clamp;
};

//blur texture 1
texture Blur1Img : RENDERCOLORTARGET
< 
	string ResourceName = "";
	//float2 ViewportRatio = {0.125,0.125 };
	int width = 512;
	int height = 384;
	
>;

sampler2D Blur1ImgSamp = sampler_state {
    Texture = < Blur1Img >;
    MinFilter = Anisotropic; MagFilter = Anisotropic; MipFilter = Anisotropic;
    AddressU = Clamp; AddressV = Clamp;
};

//blur texture 2
texture Blur2Img : RENDERCOLORTARGET
< 
	string ResourceName = "";
	//float2 ViewportRatio = {0.125,0.125 };
	int width = 512;
	int height = 384;
	
>;

sampler2D Blur2ImgSamp = sampler_state {
    Texture = < Blur2Img >;
    MinFilter = Linear; MagFilter = Linear; MipFilter = Linear;
    AddressU = Clamp; AddressV = Clamp;
};

//-------------STRUCTS-------------------------------------------------------------

struct input 
{
	float4 pos : POSITION;
	float2 uv : TEXCOORD0;
};
 
struct output {

	float4 pos: POSITION;
	float2 uv: TEXCOORD0;

};

//-----------VERTEX SHADER------------------------------------------------------------//
output VS( input IN ) 
{
	output OUT;

	//quad needs to be shifted by half a pixel.
	float4 oPos = float4( IN.pos.xy + float2( -1.0f/ViewSize.x, 1.0f/ViewSize.y ),0.0,1.0 );
	
	float2 uv = (IN.pos.xy + 1.0) / 2.0;
	uv.y = 1 - uv.y; 
	OUT.uv = uv;

	// split screen for Rift VR
	oPos.x = oPos.x / 2.0f;
	oPos.x = oPos.x + World[3].x;
	OUT.pos = oPos;
	
	return OUT;	
}

//---------PIXEL SHADERS--------------------------------------------------------------//

// Scales input texture coordinates for distortion.
// ScaleIn maps texture coordinates to Scales to ([-1, 1]), although top/bottom will be
// larger due to aspect ratio.
float2 HmdWarp(float2 in01)
{
   float2 theta = (in01 - LensCenter) * ScaleIn; // Scales to [-1, 1]
   float rSq = theta.x * theta.x + theta.y * theta.y;
   float2 theta1 = theta * (HmdWarpParam.x + HmdWarpParam.y * rSq + 
                   HmdWarpParam.z * rSq * rSq + HmdWarpParam.w * rSq * rSq * rSq);
   return LensCenter + Scale * theta1;
}

float4 PSPresentNoBloom( output IN, uniform sampler2D srcTex ) : COLOR
{
	// final color
	float4 color = float4(0.5, 0.5, 0.5, 0.5);
   	float2 tc = HmdWarp(IN.uv);
   	if(any(clamp(tc, ScreenCenter - float2(0.5, 0.5), ScreenCenter + float2(0.5, 0.5) ) - tc) )
    {       	
		// color = float4(0.0, 0.0, 0.0, 0.0);
	}
	else
	{
   		color = float4(tex2D(srcTex, tc).xyz,1);
	}   
 	color += ScreenColor;
	return color; 
}

//-------TECHNIQUE------------------------------------------------------------------

technique dx9textured
<
	//specify where we want the original image to be put
	string RenderColorTarget = "frame";
>
{
	//send the combined image to the screen
	pass Present
	<
		string RenderColorTarget = "";
	>
	{
		VertexShader = compile vs_2_0 VS();
		PixelShader = compile ps_2_0 PSPresentNoBloom( frameSamp );
	}
}
