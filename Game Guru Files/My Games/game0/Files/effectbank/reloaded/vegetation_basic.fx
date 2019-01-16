string Description = "Vegetation Shader by bond1-mjblosser.com";

// For Poisson Disk PCF sampling
static const float2 PoissonSamples[64] =
{
    float2(-0.5119625f, -0.4827938f),
    float2(-0.2171264f, -0.4768726f),
    float2(-0.7552931f, -0.2426507f),
    float2(-0.7136765f, -0.4496614f),
    float2(-0.5938849f, -0.6895654f),
    float2(-0.3148003f, -0.7047654f),
    float2(-0.42215f, -0.2024607f),
    float2(-0.9466816f, -0.2014508f),
    float2(-0.8409063f, -0.03465778f),
    float2(-0.6517572f, -0.07476326f),
    float2(-0.1041822f, -0.02521214f),
    float2(-0.3042712f, -0.02195431f),
    float2(-0.5082307f, 0.1079806f),
    float2(-0.08429877f, -0.2316298f),
    float2(-0.9879128f, 0.1113683f),
    float2(-0.3859636f, 0.3363545f),
    float2(-0.1925334f, 0.1787288f),
    float2(0.003256182f, 0.138135f),
    float2(-0.8706837f, 0.3010679f),
    float2(-0.6982038f, 0.1904326f),
    float2(0.1975043f, 0.2221317f),
    float2(0.1507788f, 0.4204168f),
    float2(0.3514056f, 0.09865579f),
    float2(0.1558783f, -0.08460935f),
    float2(-0.0684978f, 0.4461993f),
    float2(0.3780522f, 0.3478679f),
    float2(0.3956799f, -0.1469177f),
    float2(0.5838975f, 0.1054943f),
    float2(0.6155105f, 0.3245716f),
    float2(0.3928624f, -0.4417621f),
    float2(0.1749884f, -0.4202175f),
    float2(0.6813727f, -0.2424808f),
    float2(-0.6707711f, 0.4912741f),
    float2(0.0005130528f, -0.8058334f),
    float2(0.02703013f, -0.6010728f),
    float2(-0.1658188f, -0.9695674f),
    float2(0.4060591f, -0.7100726f),
    float2(0.7713396f, -0.4713659f),
    float2(0.573212f, -0.51544f),
    float2(-0.3448896f, -0.9046497f),
    float2(0.1268544f, -0.9874692f),
    float2(0.7418533f, -0.6667366f),
    float2(0.3492522f, 0.5924662f),
    float2(0.5679897f, 0.5343465f),
    float2(0.5663417f, 0.7708698f),
    float2(0.7375497f, 0.6691415f),
    float2(0.2271994f, -0.6163502f),
    float2(0.2312844f, 0.8725659f),
    float2(0.4216993f, 0.9002838f),
    float2(0.4262091f, -0.9013284f),
    float2(0.2001408f, -0.808381f),
    float2(0.149394f, 0.6650763f),
    float2(-0.09640376f, 0.9843736f),
    float2(0.7682328f, -0.07273844f),
    float2(0.04146584f, 0.8313184f),
    float2(0.9705266f, -0.1143304f),
    float2(0.9670017f, 0.1293385f),
    float2(0.9015037f, -0.3306949f),
    float2(-0.5085648f, 0.7534177f),
    float2(0.9055501f, 0.3758393f),
    float2(0.7599946f, 0.1809109f),
    float2(-0.2483695f, 0.7942952f),
    float2(-0.4241052f, 0.5581087f),
    float2(-0.1020106f, 0.6724468f),
};

// shadow mapping
matrix          m_mShadow;
float4          m_vCascadeOffset[8];
float4          m_vCascadeScale[8];
int             m_nCascadeLevels;
float           m_fMinBorderPadding;     
float           m_fMaxBorderPadding;
float           m_fShadowBiasFromGUI;  // A shadow map offset to deal with self shadow artifacts.  
float           m_fCascadeBlendArea; // Amount to overlap when blending between cascades.
float           m_fTexelSize; 
float           m_fCascadeFrustumsEyeSpaceDepths[8];
float3          m_vLightDir;

float ShadowStrength
<    string UIName =  "ShadowStrength";    
> = {1.0f};

float GrassFadeDistance
<    string UIName =  "GrassFadeDistance";    
> = {10000.0f};

float GlobalSpecular
<    string UIName =  "GlobalSpecular";    
> = {0.5f};

float GlobalSurfaceIntensity
<    string UIName =  "GlobalSurfaceIntensity";    
> = {1.0f};

// regular shader constants	
float4x4 WorldViewProjection : WorldViewProjection;
float4x4 ViewProjection : ViewProjection;
float4x4 WorldIT : WorldInverseTranspose;
float4x4 World : World;
float4x4 View : View;
float time: Time;
float4 eyePos : CameraPosition;
float4 clipPlane : ClipPlane;  //cliplane for water plane

/******VALUES PULLED FROM FPSC - NON TWEAKABLE**********/

float4 LightSource
<   string UIType = "Fixed Light Direction";
> = {0.0f, -1.0f, 0.0f, 1.0f};

//Supports dynamic lights (using CalcLightingNoNormal function)
float4 g_lights_pos0;
float4 g_lights_pos1;
float4 g_lights_pos2;
float4 g_lights_atten0;
float4 g_lights_atten1;
float4 g_lights_atten2;
float4 g_lights_diffuse0;
float4 g_lights_diffuse1;
float4 g_lights_diffuse2;

//SpotFlash Values
float4 SpotFlashPos;  //SpotFlashPos.w is carrying the spotflash fadeout value
float4 SpotFlashColor; //RGB of flash colour

///////////////////////////////////////////////////////////

//**TWEAKABLES********************************************************/

float SwayAmount
<
	string UIWidget = "slider";
	float UIMax = 0.3;
	float UIMin = 0.0;
	float UIStep = 0.01;
> = 0.05f;

float SwaySpeed
<
	string UIWidget = "slider";
	float UIMax = 10;
	float UIMin = 0.0;
	float UIStep = 0.1;
> = 1.0f;

float ScaleOverride
<
	string UIWidget = "slider";
	float UIMax = 3.0;
	float UIMin = 0.1;
	float UIStep = 0.1;
> = 2.5f;

float ColorVarAmount
<
	string UIWidget = "slider";
	float UIMax = 10.0;
	float UIMin = 0.0;
	float UIStep = 0.1;
> = 3.5f;

float ColorSpeed
<
	string UIWidget = "slider";
	float UIMax = 10.0;
	float UIMin = 0.1;
	float UIStep = 0.1;
> = 3.0f;

float RedTint
<
	string UIWidget = "slider";
	float UIMax = 0.1;
	float UIMin = 0.0;
	float UIStep = 0.01;
> = 0.01f;

float GreenTint
<
	string UIWidget = "slider";
	float UIMax = 0.1;
	float UIMin = 0.0;
	float UIStep = 0.01;
> = 0.01f;

float BlueTint
<
	string UIWidget = "slider";
	float UIMax = 0.1;
	float UIMin = 0.0;
	float UIStep = 0.01;
> = 0.00f;

//WATER Fog Color
float4 FogColor : Diffuse
<   string UIName =  "Fog Color";    
> = {0.0f, 0.0f, 0.0f, 0.0000001f};

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
<
    string UIName =  "Ambient Light Color";
> = {0.1f, 0.1f, 0.1f, 1.0f};

float4 SurfColor : Diffuse
<
    string UIName =  "Surface Color";
    string UIType = "Color";
> = {1.0f, 1.0f, 1.0f, 1.0f};

float4 SkyColor : Diffuse
<    string UIName =  "SkyColor";    
> = {1.0, 1.0, 1.0, 1.0f};

texture BaseTex : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture VegShadowTex : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DynTerShaMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DepthMapTX4 : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;

sampler BaseSamp = sampler_state
{
	Texture = <BaseTex>;
	MinFilter = Linear; 
	MagFilter = Linear; 
	MipFilter = Linear;
	AddressU = clamp; 
	AddressV = clamp;
};
sampler VegShadowSamp = sampler_state
{
	Texture = <VegShadowTex>;
	MinFilter = Linear; 
	MagFilter = Linear; 
	MipFilter = Linear;
	AddressU = clamp; 
	AddressV = clamp;
};
sampler2D DynTerShaSampler = sampler_state
{
    Texture   = <DynTerShaMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};
sampler2D DepthMap4 = sampler_state
{
	Texture = <DepthMapTX4>;	
    MinFilter = POINT;//LINEAR;
    MagFilter = POINT;//LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
    AddressU = Border;
    AddressV = Border;
	BorderColor = 0xFFFFFFFF;
};

struct app_in
{
	float4 pos : POSITION;
	float2 uv : TEXCOORD0;
	float4 Normal	: NORMAL;    
};

struct vs_out
{
	float4 pos : POSITION;
	float2 uv : TEXCOORD0;
	float4 coloroffset : TEXCOORD1;
	float2 vegshadowuv : TEXCOORD2;
	float clip : TEXCOORD3;
    float4 WPos         : TEXCOORD4;
    float  WaterFog     : TEXCOORD5; 
    float3 LightVec	    : TEXCOORD6;
    float3 WorldNormal	: TEXCOORD7; 
};

struct vs_out_lowest
{
	float4 pos : POSITION;
	float2 uv : TEXCOORD0;
	float2 vegshadowuv : TEXCOORD1;
    float4 WPos : TEXCOORD2;
	float DistAlpha : TEXCOORD3;
	float clip : TEXCOORD4;
	float4 cameraPos : TEXCOORD5;
};

void ComputeCoordinatesTransform( in float4 InterpolatedPosition, in out float4 vShadowTexCoord ) 
{
	float4 vLightDot = mul ( InterpolatedPosition, m_mShadow );
    vLightDot *= m_vCascadeScale[3];
    vLightDot += m_vCascadeOffset[3];
	vShadowTexCoord.xyz = vLightDot.xyz;
} 

void CalculatePCFPercentLitSingle ( in float4 vShadowTexCoord, out float fPercentLit )
{
	// Use PCF to sample the depth map and return a percent lit value.
    fPercentLit = 0.0f;
	float fTS = (1.0f/1024.0f);//m_fTexelSize;
	for ( int p=0; p<64; p+=8 )
	{
		fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x,vShadowTexCoord.y)+(PoissonSamples[p]*fTS)).x ? 1.0f : 0.0f;
	}
	fPercentLit /= 8.0f;
	//float fTS = m_fTexelSize * 2.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x,vShadowTexCoord.y-fTS)).x ? 1.0f : 0.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x+fTS,vShadowTexCoord.y-fTS)).x ? 1.0f : 0.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x+fTS+fTS,vShadowTexCoord.y-fTS)).x ? 1.0f : 0.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x,vShadowTexCoord.y)).x ? 1.0f : 0.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x+fTS,vShadowTexCoord.y)).x ? 1.0f : 0.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x+fTS+fTS,vShadowTexCoord.y)).x ? 1.0f : 0.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x,vShadowTexCoord.y+fTS)).x ? 1.0f : 0.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x+fTS,vShadowTexCoord.y+fTS)).x ? 1.0f : 0.0f;
	//fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x+fTS+fTS,vShadowTexCoord.y+fTS)).x ? 1.0f : 0.0f;
	//fPercentLit /= 9.0f;
}

// CALC LIGHT

float4 CalcSpotFlashNoNormal( float3 worldPos )
{
    float4 output = (float4)0.0;
    float3 toLight = (SpotFlashPos.xyz - worldPos.xyz);
    float3 lightDir = normalize( toLight );
    float lightDist = length( toLight );
    
    float MinFalloff = 100;  //falloff start distance
    float LinearFalloff = 1;
    float ExpFalloff = .005;  // 1/200
    SpotFlashPos.w = clamp(0,1,SpotFlashPos.w -.2);
    
    //classic attenuation - but never actually reaches zero
    float fAtten = 1.0/(MinFalloff + (LinearFalloff*lightDist)+(ExpFalloff*lightDist*lightDist));
    output += (SpotFlashColor) *fAtten * (SpotFlashPos.w); //don't use normal, faster
        
    return output;
}

float4 CalcLightingNoNormal(float3 worldPos)
{
	// No normals to calculate, veg receives light for all sides
    float4 output = (float4)0.0;
    
    // light 0
    float3 toLight = g_lights_pos0.xyz - worldPos;
    float lightDist = length( toLight );
    float fAtten = 1.0/dot( g_lights_atten0, float4(1,lightDist,lightDist*lightDist,0) );
    output+= g_lights_diffuse0 * fAtten * 1.7;
	
    // light 1
    toLight = g_lights_pos1.xyz - worldPos;
    lightDist = length( toLight );
    fAtten = 1.0/dot( g_lights_atten1, float4(1,lightDist,lightDist*lightDist,0) );
    output+= g_lights_diffuse1 * fAtten * 1.7; 
	
    // light 2
    toLight = g_lights_pos2.xyz - worldPos;
    lightDist = length( toLight );
    fAtten = 1.0/dot( g_lights_atten2, float4(1,lightDist,lightDist*lightDist,0) );
    output+= g_lights_diffuse2 * fAtten * 1.7;
	
	// as no normal, reduce overall influence by half
	output *= 0.5f;
	
    return output;
}

/****** vertex shader *****/

vs_out mainVS_highest( app_in IN )
{
	vs_out OUT;

	// Grass clumps are hidden by setting the verts to a 200+ Y position offset in the grass area model. So anything higher than
	// this we can skip processing (perhaps! With pipeling it may still be processed!). When coloroffset.a = 0 is passed to the pixel 
	// shader, the pixel will be clipped straight away
	OUT.coloroffset.a = 0;
	if (IN.pos.y < 199)
	{	
		//animate the verts - model must have pivot at base of model on export
		float amplitude = pow((SwayAmount * (1-IN.uv.y) * 50.0f),1); //power function biases movement toward the top of the UV map (veg can be high)
		float4 wave = amplitude * float4(sin(time * SwaySpeed +IN.pos.x),0,cos(time *SwaySpeed +IN.pos.z),0);
		float4 vert = IN.pos + wave;
		vert.w = 1;
		/////////////////
		
		float4 temppos = mul(vert, World);
		float4 tempposforcol = temppos*ColorSpeed; //using world space pos to randomize colors so same mesh will not all look the same

		//offset colors
		float thesin = sin(time+tempposforcol.x +tempposforcol.y + tempposforcol.z);
		OUT.coloroffset.r = (RedTint*thesin); //may want to saturate these 3 values to prevent subtracting color
		OUT.coloroffset.g = (GreenTint*thesin); //try x or z for a different color effect
		OUT.coloroffset.b = (BlueTint*thesin);
		OUT.pos = mul( vert, WorldViewProjection ); //use modified vert position instead of IN.pos
		
		// fade alpha with distance from camera
		float3 diff = temppos.xyz - eyePos.xyz;
		float fDist = sqrt(diff.x*diff.x+diff.z*diff.z);
		float fEdgePerc = max(0,fDist-(GrassFadeDistance*0.4f)) / (GrassFadeDistance*0.6f);
		OUT.coloroffset.a = 1.0f - fEdgePerc;

		// shadow painted in veg shadow map generated from cascade shadow capture and user painting?)
		// and needs a UV coordinate derived from the world position of the vegetable
		OUT.vegshadowuv = float2(temppos.x/51100.0f,temppos.z/51100.0f);
		
		OUT.uv = IN.uv;
		OUT.LightVec = normalize(LightSource);
		OUT.WorldNormal = float3(0,1,0);//normalize(mul(IN.Normal, WorldIT).xyz);
		
		// calculate Water FOG colour
		float4 cameraPos = mul( temppos, View );
		float fogstrength = cameraPos.z * FogColor.w;
		OUT.WPos = temppos;
		OUT.WaterFog = min(fogstrength,1.0);

		// all shaders should send the clip value to the pixel shader
		OUT.clip = dot(temppos, clipPlane); 
	}	
	return OUT;
}

vs_out_lowest mainVS_lowest( app_in IN )
{
	// uses no IF branches, no animation
	vs_out_lowest OUT;
	OUT.pos = mul(IN.pos, WorldViewProjection ); 
	OUT.uv = IN.uv;
	float4 temppos = mul(IN.pos, World);
	OUT.vegshadowuv = float2(temppos.x/51100.0f,temppos.z/51100.0f);
	float3 diff = temppos.xyz - eyePos.xyz;
	float fDist = sqrt(diff.x*diff.x+diff.z*diff.z);
	OUT.DistAlpha = 1.0 - (fDist / (GrassFadeDistance*0.4f));
	float alphaoffset = 0 - max(0,fDist-(GrassFadeDistance*0.4f)) / (GrassFadeDistance*0.6f); 
	OUT.WPos = temppos;
	OUT.clip = alphaoffset - (max(0,IN.pos.y-199));
	OUT.cameraPos = mul(temppos, View);
	return OUT;
}

float4 mainPS_highest( vs_out IN ) : COLOR
{
	// clip
	clip(IN.clip);

	// texture reference
	float4 diffusemap = tex2D(BaseSamp,IN.uv);
	clip(diffusemap.a < 0.8f ? -1:1); 

	// lighting
    float3 Ln = normalize(IN.LightVec);
	float3 V  = (eyePos - IN.WPos);  
    float3 Vn  = normalize(V); 
    float3 Hn = normalize(Vn+Ln);
    float4 lighting = lit((dot(Ln,IN.WorldNormal)),dot(Hn,IN.WorldNormal),24);
	
	// dynamic lighting
    float4 spotflashlighting = CalcSpotFlashNoNormal (IN.WPos.xyz);
    float4 dynamicContrib = (CalcLightingNoNormal(IN.WPos.xyz) * diffusemap) + spotflashlighting;
	
	// flash light system (flash light control carried in SpotFlashColor.w )
    float4 cameraPos = mul(IN.WPos, View);
	float conewidth = 24;
	float intensity = max(0, 1.5f - (cameraPos.z/500.0f));
	float3 lightvector = Vn;
	float3 lightdir = float3(View._m02,View._m12,View._m22);
	float flashlight = pow(max(dot(-lightvector, lightdir),0),conewidth) * intensity * SpotFlashColor.w;	
	dynamicContrib.xyz = dynamicContrib.xyz + (diffusemap*float3(flashlight,flashlight,flashlight));
	
	// spherical ambience not used
	float4 ambContrib = diffusemap * (AmbiColor) * AmbiColorOverride * 2;
	
	// simple shadow mapping code
	float fShadow = 0.0f;
	float4 vShadowMapTextureCoord = 0.0f;
	ComputeCoordinatesTransform( IN.WPos, vShadowMapTextureCoord );    
	CalculatePCFPercentLitSingle ( vShadowMapTextureCoord, fShadow );
	
	// finally modulate shadow with strength
	fShadow = fShadow * ShadowStrength;  
	float fInvShadow = (1.0-(fShadow*0.65f));
	
	// paint
	float4 diff = float4(diffusemap.xyz+(IN.coloroffset*ColorVarAmount),1);
	float4 diffuseContrib = SurfColor * diff * 0.61 * GlobalSurfaceIntensity;
	float4 specContrib = lighting.z * diff * SurfColor * GlobalSpecular;
	
	// apply shadow mapping to final render
	ambContrib.xyz = ambContrib.xyz * fInvShadow;
	diffuseContrib.xyz = diffuseContrib.xyz * fInvShadow;
	specContrib.xyz = specContrib.xyz * fInvShadow;
	float4 result = diffuseContrib + ambContrib + specContrib + dynamicContrib;
	
	// fog
    float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
    float3 hudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	
    // water fog
    hudfogresult = lerp(hudfogresult,FogColor,IN.WaterFog);
	
	// modulate with distance alpha (fade out)
	result.a = IN.coloroffset.a;
	
	// return final pixel
	return float4(hudfogresult.xyz,result.a);
}

float4 mainPS_medium( vs_out_lowest IN ) : COLOR
{
	// clip
	clip(IN.clip);

	// texture reference
	float4 diffusemap = tex2D(BaseSamp,IN.uv);
	clip(diffusemap.a < 0.8f ? -1:1); 

	// dynamic lighting
    float4 spotflashlighting = CalcSpotFlashNoNormal (IN.WPos.xyz);
    float4 dynamicContrib = (CalcLightingNoNormal(IN.WPos.xyz) * diffusemap) + spotflashlighting;
	
	// flash light system (flash light control carried in SpotFlashColor.w )
	float3 V  = (eyePos - IN.WPos);  
    float3 Vn  = normalize(V); 
	float conewidth = 24;
	float intensity = max(0, 1.5f - (IN.cameraPos.z/500.0f));
	float3 lightvector = Vn;
	float3 lightdir = float3(View._m02,View._m12,View._m22);
	float flashlight = pow(max(dot(-lightvector, lightdir),0),conewidth) * intensity * SpotFlashColor.w;	
	dynamicContrib.xyz = dynamicContrib.xyz + (diffusemap*float3(flashlight,flashlight,flashlight));
	
	// spherical ambience from sky only
	float4 ambContrib = diffusemap * AmbiColor * AmbiColorOverride * 2;
	
	// paint
	float4 diffuseContrib = SurfColor * diffusemap * 0.61 * GlobalSurfaceIntensity;
	
	// diffuse + ambient
	float4 result = diffuseContrib + ambContrib + dynamicContrib;
	
	// fog
    float hudfogfactor = saturate((IN.cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
    float3 hudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	
	// modulate with distance alpha (fade out)
	result.a = IN.DistAlpha;
		
	// return final pixel
	return float4(hudfogresult.xyz,result.a);
}

float4 mainPS_lowest( vs_out_lowest IN ) : COLOR
{
	// clip
	clip(IN.clip);
	
	// texture reference
	float4 diffusemap = tex2D(BaseSamp,IN.uv);
	clip(diffusemap.a < 0.8f ? -1:1); 
	
	// CHEAPEST flash light system (flash light control carried in SpotFlashColor.w )
	float flashlight = (1.0f-min(1,IN.cameraPos.z/300.0f)) * SpotFlashColor.w;	
	
	// spherical ambience from sky only
	float4 ambContrib = diffusemap * AmbiColor * AmbiColorOverride * 2;
	
	// paint
	float4 diffuseContrib = SurfColor * (diffusemap * (1.0+flashlight) * 0.61 * GlobalSurfaceIntensity);
	
	// diffuse + ambient
	float4 result = diffuseContrib + ambContrib;
	
	// fog
    float hudfogfactor = saturate((IN.cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
    float3 hudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	
	// return final pixel
	return float4(hudfogresult.xyz,IN.DistAlpha);
}
	
float4 BlackPixelShader( vs_out_lowest IN ) : COLOR
{
	// clip
	clip(IN.clip);
		
	// clip grass pixels where the texture has low transparency
	float4 result = tex2D(BaseSamp,IN.uv*1.0);	
	clip(result.a < 0.8f ? -1:1); 
	
	// return final pixel
	return float4(0,0,0,result.a);
}

technique Highest
{
	pass p0
	{
		VertexShader = compile vs_3_0 mainVS_highest( );
		PixelShader = compile ps_3_0 mainPS_highest( );
		alphablendenable=true;
		alphafunc=greater;
		alpharef=1;
		alphatestenable=true;
		cullmode = none;
	}	
}

technique Medium
{
	pass p0
	{
		VertexShader = compile vs_3_0 mainVS_lowest( );
		PixelShader = compile ps_3_0 mainPS_medium( );
		alphablendenable=true;
		alphafunc=greater;
		alpharef=1;
		alphatestenable=true;
		cullmode = none;
	}	
}

technique Lowest
{
	pass p0
	{
		VertexShader = compile vs_2_0 mainVS_lowest( );
		PixelShader = compile ps_2_0 mainPS_lowest( );
		alphablendenable=true;
		alphafunc=greater;
		alpharef=1;
		alphatestenable=true;
		cullmode=cw;
	}	
}

technique blacktextured
{
	pass p0
	{
		alphablendenable=false;
		alphafunc=greater;
		alpharef=84;
		alphatestenable=true;
		cullmode = none;
		VertexShader = compile vs_2_0 mainVS_lowest( );
		PixelShader = compile ps_2_0 BlackPixelShader( );
	}	
}
