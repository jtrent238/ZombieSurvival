string Description = "Shadow Shader";

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

float ShadowStrength	
<    string UIName =  "ShadowStrength";    
> = {1.0f};

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
float4 clipPlane : ClipPlane;  //cliplane for water plane

float4 FogColor : Diffuse
<   string UIName =  "Fog Color";    
> = {0.0f, 0.0f, 0.0f, 0.0000001f};

float4 HudFogColor : Diffuse
<   string UIName =  "Hud Fog Color";    
> = {0.0f, 0.0f, 0.0f, 0.0000001f};

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

float GlobalSurfaceIntensity
<    string UIName =  "GlobalSurfaceIntensity";    
> = {1.0f};

float alphaoverride  : alphaoverride;

texture DiffuseMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;

texture DepthMapTX1 : DiffuseMap
<
    string Name = "DEPTH1.tga";
    string type = "2D";
>;
texture DepthMapTX2 : DiffuseMap
<
    string Name = "DEPTH1.tga";
    string type = "2D";
>;
texture DepthMapTX3 : DiffuseMap
<
    string Name = "DEPTH1.tga";
    string type = "2D";
>;
texture DepthMapTX4 : DiffuseMap
<
    string Name = "DEPTH1.tga";
    string type = "2D";
>;

sampler2D DiffuseSampler = sampler_state
{
    Texture   = <DiffuseMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
};
sampler2D DepthMap1 = sampler_state
{
	Texture = <DepthMapTX1>;	
    MinFilter = POINT;//LINEAR;
    MagFilter = POINT;//LINEAR;
    AddressU = Border;
    AddressV = Border;
	BorderColor = float4(1,1,1,1);
};
sampler2D DepthMap2 = sampler_state
{
	Texture = <DepthMapTX2>;	
    MinFilter = POINT;//LINEAR;
    MagFilter = POINT;//LINEAR;
    AddressU = Border;
    AddressV = Border;
	BorderColor = float4(1,1,1,1);
};
sampler2D DepthMap3 = sampler_state
{
	Texture = <DepthMapTX3>;	
    MinFilter = POINT;//LINEAR;
    MagFilter = POINT;//LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};
sampler2D DepthMap4 = sampler_state
{
	Texture = <DepthMapTX4>;	
    MinFilter = POINT;//LINEAR;
    MagFilter = POINT;//LINEAR;
    AddressU = Border;
    AddressV = Border;
	BorderColor = 0xFFFFFFFF;
};

struct appdata 
{
    float4 Position	: POSITION;
    float2 UV0		: TEXCOORD0;
};

struct vertexOutput
{
    float4 Position      : POSITION;
    float2 TexCoord      : TEXCOORD0;
	float4 Pos		     : TEXCOORD1;
	float vDepth		 : TEXCOORD2;
    float4 WPos          : TEXCOORD3;
};

vertexOutput mainVS(appdata IN)   
{
	vertexOutput OUT;
	float4 tPos = mul(IN.Position, WorldViewProjection);
	OUT.Position = tPos;
	OUT.TexCoord = IN.UV0;
	OUT.Pos = IN.Position;
	OUT.vDepth = tPos.z; 
	float4 worldSpacePos = mul(IN.Position, World);
	OUT.WPos = worldSpacePos; 
    return OUT;
}

float4 mainPS(vertexOutput IN) : COLOR
{
	// dynamic shadow mapping
	float4 vSMapTexCoord = mul ( IN.WPos, m_mShadow );
    vSMapTexCoord *= m_vCascadeScale[1];
    vSMapTexCoord += m_vCascadeOffset[1];
	vSMapTexCoord.x = max(vSMapTexCoord.x,0.01);
	vSMapTexCoord.y = max(vSMapTexCoord.y,0.01);
	vSMapTexCoord.x = min(vSMapTexCoord.x,0.99);
	vSMapTexCoord.y = min(vSMapTexCoord.y,0.99);
	float2 offset = 0;
    float fDynamicShadow = 0;
	float fTS = 1.0f / 1024.0f;
	for ( int p=0; p<64; p+=8 )
	{
		fDynamicShadow += vSMapTexCoord.z > tex2D(DepthMap2,float2(vSMapTexCoord.x,vSMapTexCoord.y)+(PoissonSamples[p]*fTS)).x ? 1.0f : 0.0f;
	}
	fDynamicShadow /= 8.0f;

	// fade out dynamic shadow beyond X units
	float fFadeOutCascade = saturate(1.0-((IN.vDepth-600.0)/400.0));
	fDynamicShadow = fDynamicShadow * fFadeOutCascade;

	float fFarShadow = 0.0;
	vSMapTexCoord = mul ( IN.WPos, m_mShadow );
    vSMapTexCoord *= m_vCascadeScale[3];
    vSMapTexCoord += m_vCascadeOffset[3];
	vSMapTexCoord.x = max(vSMapTexCoord.x,0.01);
	vSMapTexCoord.y = max(vSMapTexCoord.y,0.01);
	vSMapTexCoord.x = min(vSMapTexCoord.x,0.99);
	vSMapTexCoord.y = min(vSMapTexCoord.y,0.99);
	fFarShadow += vSMapTexCoord.z > tex2D(DepthMap4,float2(vSMapTexCoord.x,vSMapTexCoord.y)).x ? 1.0f : 0.0f;
	fDynamicShadow = fDynamicShadow + (fFarShadow*(1-fFadeOutCascade));

	// multiply lightmap directly with 'frame buffer pixel thanks to destblend=srccolor'
	float4 result = float4(tex2D(DiffuseSampler,IN.TexCoord.xy).xyz/3.0f,1);
	result = result * 2.0f;
	result.x = max(min(result.x,0.2f),result.x-fDynamicShadow);
	result.y = max(min(result.y,0.2f),result.y-fDynamicShadow);
	result.z = max(min(result.z,0.2f),result.z-fDynamicShadow);

	// fog diminishes shadow strength
	float finalshadowstrength = ShadowStrength;
    float4 cameraPos = mul(IN.WPos, View);
    float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
	finalshadowstrength = finalshadowstrength - (hudfogfactor*HudFogColor.w);

	// apply strength of shadow/lm
	result = lerp(float4(0.5,0.5,0.5,1),result,finalshadowstrength);

    // done	
    return result;
}

technique Highest
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS();
        PixelShader  = compile ps_3_0 mainPS();
        AlphaBlendEnable = true;
        AlphaTestEnable = false;
		CullMode = ccw;
		ZWriteEnable = false;
		SrcBlend = DestColor;
        DestBlend = SrcColor;
    }
}
