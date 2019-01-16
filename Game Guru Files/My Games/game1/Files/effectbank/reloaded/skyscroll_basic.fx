/*******************************************************************************************
Shader Model 3 Rendering System for FPS Creator
by Mark Blosser  
email: mjblosser@gmail.com
website: www.mjblosser.com
-------------------------------------------------------------------

/**************MATRICES & UNTWEAKABLES *****************************************************/

// standard constants
float4x4 World : World;
float4x4 WorldInverse : WorldInverse;
float4x4 WorldIT : WorldInverseTranspose;
float4x4 WorldView : WorldView;
float4x4 WorldViewProjection : WorldViewProjection;
float4x4 View : View;
float4x4 ViewInverse : ViewInverse;
float4x4 ViewIT : ViewInverseTranspose;
float4x4 ViewProjection : ViewProjection;
float4x4 Projection : Projection;

float4 eyePos : CameraPosition;
float time : Time;
float sintime : SinTime;
float alphaoverride  : alphaoverride;

/**************VALUES PROVIDED FROM FPSC - NON TWEAKABLE**************************************/

float4 clipPlane : ClipPlane;  //cliplane for water plane

//HUD Fog Color
float4 HudFogColor : Diffuse
<   string UIName =  "Hud Fog Color";    
> = {0.0f, 0.0f, 0.0f, 0.0000001f};

//HUD Fog Distances (near,far,0,0)
float4 HudFogDist : Diffuse
<   string UIName =  "Hud Fog Dist";    
> = {1.0f, 0.0f, 0.0f, 0.0000001f};

float4 AmbiColorOverride
<    string UIName =  "AmbiColorOverride";    
> = {1.0f, 1.0f, 1.0f, 1.0f};

float4 AmbiColor : Ambient
<    string UIName =  "AmbiColor";    
> = {0.1f, 0.1f, 0.1f, 1.0f};

float4 SurfColor : Diffuse
<    string UIName =  "SurfColor";    
> = {1.0f, 1.0f, 1.0f, 1.0f};

float4 SkyScrollValues : Diffuse
<    string UIName =  "SkyScrollValues";    
> = {0.0f, 0.0f, 0.0f, 0.0f};

/***************TEXTURES AND SAMPLERS***************************************************/

texture DiffuseMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;

texture PortalMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;

sampler2D DiffuseSampler = sampler_state
{
    Texture   = <DiffuseMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
};

sampler2D PortalSampler = sampler_state
{
    Texture   = <PortalMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
};

/************* DATA STRUCTS **************/

struct appdata 
{
    float4 Position	: POSITION;
    float2 UV0		: TEXCOORD0;
    float2 UV1		: TEXCOORD1;
};

struct vertexOutput
{
    float4 Position     : POSITION;
    float2 TexCoord0    : TEXCOORD0;
    float2 TexCoord1    : TEXCOORD1;
    float clip          : TEXCOORD2;
	float4 WPos			: TEXCOORD3;
};

/*******Main Vertex Shader***************************/

vertexOutput mainVS(appdata IN)   
{
    vertexOutput OUT;
    float4 worldSpacePos = mul(IN.Position, World);
    OUT.Position = mul(IN.Position, WorldViewProjection);
    OUT.TexCoord0  = IN.UV0; 
    OUT.TexCoord1  = IN.UV1; 
    OUT.clip = dot(worldSpacePos, clipPlane);                                                                      
	OUT.WPos = worldSpacePos;
    return OUT;
}

/****************Framgent Shader*****************/

float4 mainPS(vertexOutput IN) : COLOR
{
    float4 finalcolor;
	
	// advanced portal effect (alpha is static mask to fade out extreme edges)
    float portalalpha = tex2D(PortalSampler,IN.TexCoord0.xy).a;
	
	// legacy effect with no cloud portal
	finalcolor = tex2D(DiffuseSampler,IN.TexCoord0.xy+float2(SkyScrollValues.x,SkyScrollValues.y));
	
	// SK: Adding in fog
	float3 eyePosFlat = eyePos.xyz; eyePosFlat.y *= 0.1f;
	float3 wPosFlat = IN.WPos.xyz; wPosFlat.y *= 0.1f;
    float distance = distance(eyePosFlat,wPosFlat) / 500.0f; // Skybox smaller than landscape size
    float hudfogfactor = saturate((distance - HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
    float3 hudfogresult = lerp(finalcolor.xyz,HudFogColor.xyz,hudfogfactor*HudFogColor.w);
	
	// cannot trust alpha of cloud scroll texture, so calc from RGB
	float fCloudAlpha = finalcolor.a;

	// final scrolling cloud pixel
    return float4(hudfogresult,fCloudAlpha*portalalpha);
}

/****** technique *****************************************************************************/

technique dx9textured
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_2_0 mainVS();
        PixelShader  = compile ps_2_0 mainPS();
        CullMode = none;
        AlphaBlendEnable = TRUE;
        AlphaTestEnable = false;
    }
}
