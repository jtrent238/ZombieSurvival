string Description = "Terrain Shader";

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
float           m_fCascadeBlendArea;
float           m_fTexelSize; 
float           m_fCascadeFrustumsEyeSpaceDepths[8];

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

float DetailMapScale
<    string UIName =  "DetailMapScale";    
> = {1.5f};

// regular shader constants	
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

float4 HighlightCursor
<   string UIType = "HighlightCursor";
> = {0.0f,0.0f,0.0f,1.0f};

float4 HighlightParams
<   string UIType = "HighlightParams";
> = {0.0f,0.0f,0.0f,1.0f};

float4 DistanceTransition
<   string UIType = "DistanceTransition";
> = {1600.0f,2000.0f,400.0f,0.0f};

/**************VALUES PROVIDED FROM FPSC - NON TWEAKABLE**************************************/

float4 clipPlane : ClipPlane;  //cliplane for water plane

float4 LightSource
<   string UIType = "Fixed Light Direction";
> = {0.0f, -1.0f, 0.0f, 1.0f};

//Supports dynamic lights (using CalcLighting function)
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

//WATER Fog Color
float4 FogColor : Diffuse
<   string UIName =  "Fog Color";    
> = {0.0f, 0.0f, 0.0f, 0.000001f};

//HUD Fog Color
float4 HudFogColor : Diffuse
<   string UIName =  "Hud Fog Color";    
> = {0.0f, 0.0f, 0.0f, 1.0f};

//HUD Fog Distances (near,far,0,0)
float4 HudFogDist : Diffuse
<   string UIName =  "Hud Fog Dist";    
> = {1.0f, 0.0f, 0.0f, 0.0000001f};

float4 AmbiColorOverride
<    string UIName =  "AmbiColorOverride";    
> = {1.0f, 1.0f, 1.0f, 1.0f};

float4 AmbiColor : Ambient
<    string UIName =  "AmbiColor";    
> = {0.2f, 0.2f, 0.3f, 0.0f};

float4 SurfColor : Diffuse
<    string UIName =  "SurfColor";    
> = {1.0f, 0.9f, 0.8f, 1.0f};

float4 SkyColor : Diffuse
<    string UIName =  "SkyColor";    
> = {1.0, 1.0, 1.0, 1.0f};

float4 FloorColor : Diffuse
<    string UIName =  "FloorColor";    
> = {1.0, 1.0, 1.00, 1.0f};

//Shader Variables pulled from FPI scripting 
float4 ShaderVariables : ShaderVariables
<    string UIName =  "Shader Variables";    
> = {1.0f, 1.0f, 1.0f, 1.0f};


/***************TEXTURES AND SAMPLERS***************************************************/

texture VegShadowMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DynTerShaMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DiffuseSlopeMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DiffuseMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DiffuseMap3 : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DiffuseMap4 : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DiffuseMap5 : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture HighlighterMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;

texture NormalMap1 : DiffuseMap
<
    string Name = "N.tga";
    string type = "2D";
>;
texture NormalMap2 : DiffuseMap
<
    string Name = "N.tga";
    string type = "2D";
>;
texture NormalMap3 : DiffuseMap
<
    string Name = "N.tga";
    string type = "2D";
>;
texture DetailMap : DiffuseMap
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

sampler2D VegShadowSampler = sampler_state
{
    Texture   = <VegShadowMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
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
sampler2D DiffuseSlopeSampler = sampler_state
{
    Texture   = <DiffuseSlopeMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};
sampler2D DiffuseSampler = sampler_state
{
    Texture   = <DiffuseMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};
sampler2D DiffuseSampler3 = sampler_state
{
    Texture   = <DiffuseMap3>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};
sampler2D DiffuseSampler4 = sampler_state
{
    Texture   = <DiffuseMap4>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};
sampler2D DiffuseSampler5 = sampler_state
{
    Texture   = <DiffuseMap5>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};
sampler2D HighlighterSampler = sampler_state
{
    Texture   = <HighlighterMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};

sampler2D NormalMap1Sampler = sampler_state
{
    Texture   = <NormalMap1>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};
sampler2D NormalMap2Sampler = sampler_state
{
    Texture   = <NormalMap2>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};
sampler2D NormalMap3Sampler = sampler_state
{
    Texture   = <NormalMap3>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};
sampler2D DetailSampler = sampler_state
{
    Texture   = <DetailMap>;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};

sampler2D DepthMap1 = sampler_state
{
	Texture = <DepthMapTX1>;	
    MinFilter = POINT;//LINEAR;
    MagFilter = POINT;//LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};
sampler2D DepthMap2 = sampler_state
{
	Texture = <DepthMapTX2>;	
    MinFilter = POINT;//LINEAR;
    MagFilter = POINT;//LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
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

// structures for final render
struct appdata
 {
    float4 Position	: POSITION;
    float2 UV0		: TEXCOORD0;
    float2 UV1		: TEXCOORD1;
    float4 Normal	: NORMAL;    
};

/*data passed to pixel shader*/
struct vertexOutput
{
    float4 Position     : POSITION;
    float2 TexCoord     : TEXCOORD0;
    float2 TexCoordLM   : TEXCOORD1;
    float3 LightVec	    : TEXCOORD2;
    float3 WorldNormal	: TEXCOORD3;
    float4 WPos         : TEXCOORD4;
    float  WaterFog     : TEXCOORD5;  
    float  clip         : TEXCOORD6;
    float  vDepth       : TEXCOORD7;
};

struct vertexOutput_low
{
    float4 Position     : POSITION;
    float2 TexCoord     : TEXCOORD0;
    float3 LightVec	    : TEXCOORD1;
    float3 WorldNormal	: TEXCOORD2;
    float4 WPos         : TEXCOORD3;
    float  clip         : TEXCOORD4;
};

/****** helper functions for shadow mapping*****/

void ComputeCoordinatesTransform( in int iCascadeIndex,
                                      in float4 InterpolatedPosition ,
                                      in out float4 vShadowTexCoord ) 
{
	float4 vLightDot = mul ( InterpolatedPosition, m_mShadow );
    vLightDot *= m_vCascadeScale[iCascadeIndex];
    vLightDot += m_vCascadeOffset[iCascadeIndex];
	vShadowTexCoord.xyz = vLightDot.xyz;
} 

void CalculatePCFPercentLit_highest ( in int iCurrentCascadeIndex,
									  in float4 vShadowTexCoord, 
									  out float fPercentLit ) 
{
	// Use PCF to sample the depth map and return a percent lit value.
    fPercentLit = 0.0f;
	
	float fTS = 1.0f/1024.0f;//m_fTexelSize;
	if ( iCurrentCascadeIndex==0 )
	{
		for ( int p=0; p<64; p+=8 )
		{
			fPercentLit += vShadowTexCoord.z > tex2D(DepthMap1,float2(vShadowTexCoord.x,vShadowTexCoord.y)+(PoissonSamples[p]*fTS)).x ? 1.0f : 0.0f;
		}
		fPercentLit /= 8.0f;
	}
	else
	{
		if ( iCurrentCascadeIndex==1 )
		{
			// IF STATEMENT KILLER :)
			// float gt=1;
			// gt=vShadowTexCoord.z-tex2D(DepthMap2,float2(vShadowTexCoord.x,vShadowTexCoord.y)+(PoissonSamples[0]*fTS)).x;
			// gt=saturate(gt/abs(gt));
			// fPercentLit += gt;
			
			fPercentLit += vShadowTexCoord.z > tex2D(DepthMap2,float2(vShadowTexCoord.x,vShadowTexCoord.y)+(PoissonSamples[0]*fTS)).x ? 1.0f : 0.0f;
			fPercentLit += vShadowTexCoord.z > tex2D(DepthMap2,float2(vShadowTexCoord.x,vShadowTexCoord.y)+(PoissonSamples[16]*fTS)).x ? 1.0f : 0.0f;
			fPercentLit += vShadowTexCoord.z > tex2D(DepthMap2,float2(vShadowTexCoord.x,vShadowTexCoord.y)+(PoissonSamples[32]*fTS)).x ? 1.0f : 0.0f;
			fPercentLit += vShadowTexCoord.z > tex2D(DepthMap2,float2(vShadowTexCoord.x,vShadowTexCoord.y)+(PoissonSamples[48]*fTS)).x ? 1.0f : 0.0f;
			fPercentLit /= 4.0f;
		}
		else
		{
			if ( iCurrentCascadeIndex==2 )
			{
				fPercentLit += vShadowTexCoord.z > tex2D(DepthMap3,float2(vShadowTexCoord.x,vShadowTexCoord.y)).x ? 1.0f : 0.0f;
			}
			else
			{
				if ( iCurrentCascadeIndex==3 && vShadowTexCoord.z<1.0 )
				{
					fPercentLit += vShadowTexCoord.z > tex2D(DepthMap4,float2(vShadowTexCoord.x,vShadowTexCoord.y)).x ? 1.0f : 0.0f;
				}
			}
		}
	}
}

void CalculateBlendAmountForInterval ( in int iCurrentCascadeIndex, 
                                       in out float fPixelDepth, 
                                       in out float fCurrentPixelsBlendBandLocation,
                                       out float fBlendBetweenCascadesAmount ) 
{
	// Calculate amount to blend between two cascades and the band where blending will occure.
    // We need to calculate the band of the current shadow map where it will fade into the next cascade.
    // We can then early out of the expensive PCF for loop. 
    float fBlendInterval = m_fCascadeFrustumsEyeSpaceDepths[ iCurrentCascadeIndex ];
	
    int fBlendIntervalbelowIndex = min(0, iCurrentCascadeIndex-1);
	if ( fBlendIntervalbelowIndex>1 )
	{
		fPixelDepth -= m_fCascadeFrustumsEyeSpaceDepths[ fBlendIntervalbelowIndex ];
		fBlendInterval -= m_fCascadeFrustumsEyeSpaceDepths[ fBlendIntervalbelowIndex ];
    }
	
    // The current pixel's blend band location will be used to determine when we need to blend and by how much.
    fCurrentPixelsBlendBandLocation = 1.0f - (fPixelDepth / fBlendInterval);

    // The fBlendBetweenCascadesAmount is our location in the blend band.
    fBlendBetweenCascadesAmount = fCurrentPixelsBlendBandLocation / m_fCascadeBlendArea;
}

/*******Vertex Shader***************************/

vertexOutput mainVS_highest(appdata IN)   
{
	vertexOutput OUT;
    float4 worldSpacePos = mul(IN.Position, World);
    OUT.WPos = worldSpacePos;  

    OUT.LightVec = normalize(LightSource);
    OUT.WorldNormal = normalize(mul(IN.Normal, WorldIT).xyz);
    OUT.Position = mul(IN.Position, WorldViewProjection);
    OUT.TexCoord  = IN.UV0 * 500.0f; 
    OUT.TexCoordLM  = IN.UV1 / 2.5f; 
  
    // calculate Water FOG colour
    float4 cameraPos = mul( worldSpacePos, View );
    float fogstrength = cameraPos.z * FogColor.w;
    OUT.WaterFog = min(fogstrength,1.0);
   
    // all shaders should send the clip value to the pixel shader (for refr/refl)                                                                     
    OUT.clip = dot(worldSpacePos, clipPlane);                                                                      
	
    // SHADOW MAPPING - world position and projected depth (for cascade distance calc)
    // OUT.vInterpPos = mul ( IN.Position, World );   - see OUT.WPos above!
    OUT.vDepth = mul( IN.Position, WorldViewProjection ).z; 
	
    return OUT;
}

vertexOutput_low mainVS_lowest(appdata IN)   
{
    vertexOutput_low OUT;
    OUT.Position = mul(IN.Position, WorldViewProjection);
    OUT.LightVec = normalize(LightSource);
    OUT.WorldNormal = normalize(mul(IN.Normal, WorldIT).xyz);
    OUT.TexCoord  = IN.UV0 * 500.0f; 
    float4 worldSpacePos = mul(IN.Position, World);
    OUT.WPos = worldSpacePos;  
    OUT.clip = dot(worldSpacePos, clipPlane);                                                                      
    return OUT;
}

/****************Framgent Shader*****************/

float4 CalcSpotFlash( float3 worldNormal, float3 worldPos )
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

float4 CalcLighting(float3 Nb, float3 worldPos, float3 Vn, float4 diffusemap,float4 specmap)
{
    float4 output = (float4)0.0;
    
    // light 0
    float3 toLight = g_lights_pos0.xyz - worldPos;
    float lightDist = length( toLight );
    float fAtten = 1.0/dot( g_lights_atten0, float4(1,lightDist,lightDist*lightDist,0) );
    float3 lightDir = normalize( toLight );
    float3 halfvec = normalize(Vn + lightDir);
    float4 lit0 = lit(dot(lightDir,Nb),dot(halfvec,Nb),24); 
    output+= (lit0.y *g_lights_diffuse0 * fAtten * 1.7*diffusemap) + (lit0.z * g_lights_diffuse0 * fAtten *specmap );   
	
    // light 1
    toLight = g_lights_pos1.xyz - worldPos;
    lightDist = length( toLight );
    fAtten = 1.0/dot( g_lights_atten1, float4(1,lightDist,lightDist*lightDist,0) );
    lightDir = normalize( toLight );
    halfvec = normalize(Vn + lightDir);
    lit0 = lit(dot(lightDir,Nb),dot(halfvec,Nb),24); 
    output+= (lit0.y *g_lights_diffuse1 * fAtten * 1.7*diffusemap) + (lit0.z * g_lights_diffuse1 * fAtten *specmap );   
	
    // light 2
    toLight = g_lights_pos2.xyz - worldPos;
    lightDist = length( toLight );
    fAtten = 1.0/dot( g_lights_atten2, float4(1,lightDist,lightDist*lightDist,0) );
    lightDir = normalize( toLight );
    halfvec = normalize(Vn + lightDir);
    lit0 = lit(dot(lightDir,Nb),dot(halfvec,Nb),24); 
    output+= (lit0.y *g_lights_diffuse2 * fAtten * 1.7*diffusemap) + (lit0.z * g_lights_diffuse2 * fAtten *specmap );   
	
    return output;
}

float4 mainlightPS_highest(vertexOutput IN) : COLOR
{	
	// clip
	clip(IN.clip);
	
	// veg and rock common texture lookups
	float4 VegShadowColor = tex2D(VegShadowSampler,IN.TexCoord/500.0f);
	float3 rockuv = float3(IN.WPos.x,IN.WPos.y,IN.WPos.z)/500.0f;
	float4 cXY = tex2D(DiffuseSlopeSampler, rockuv.xy);
	float4 cXZ = tex2D(DiffuseSlopeSampler, rockuv.xz);
	float4 cYZ = tex2D(DiffuseSlopeSampler, rockuv.yz);
	
	// rock normal references
	float4 nXY = tex2D(NormalMap3Sampler, rockuv.xy);
	float4 nYZ = tex2D(NormalMap3Sampler, rockuv.yz);
		
	// transition to Very Low Distant technique
	float4 viewspacePos = mul(IN.WPos, View);
	float4 finalcolor = float4(0,0,0,0);
	if ( viewspacePos.z < DistanceTransition.y )
	{
		// texture selection
		float fShadowFromNormal = IN.WorldNormal.y;
		float texselectorV = VegShadowColor.b;
		float texselectorcol1 = max(0,0.25f-abs(texselectorV-0.00))*4.0f;
		float texselectorcol2 = max(0,0.25f-abs(texselectorV-0.25))*4.0f;
		float texselectorcol3 = max(0,0.25f-abs(texselectorV-0.50))*4.0f;
		float texselectorcol4 = max(0,0.25f-abs(texselectorV-0.75))*4.0f;
		float texselectorcol5 = max(0,0.25f-abs(texselectorV-1.00))*4.0f;
		
		// work out normal textures from selector
		float3 texpart1 = tex2D(NormalMap1Sampler,IN.TexCoord) * texselectorcol1;
		float3 texpart2 = tex2D(NormalMap2Sampler,IN.TexCoord) * texselectorcol2;
		float3 texpart3 = tex2D(NormalMap3Sampler,IN.TexCoord) * texselectorcol3;
		float3 texpart4 = tex2D(NormalMap3Sampler,IN.TexCoord) * texselectorcol4;
		float3 texpart5 = tex2D(NormalMap3Sampler,IN.TexCoord) * texselectorcol5;
		float3 normalmap = texpart1+texpart2+texpart3+texpart4+texpart5;

		// merge rock normal on deep slopes	
		float3 Nn = normalize(IN.WorldNormal);
		float mXY = pow(abs(Nn.z),6);
		float mXZ = pow(abs(Nn.y),2);
		float mYZ = pow(abs(Nn.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		normalmap = nXY*mXY + normalmap*mXZ + nYZ*mYZ; 
					
		// texture references
		float4 texpartd1 = tex2D(DiffuseSampler,IN.TexCoord) * texselectorcol1;
		float4 texpartd2 = tex2D(DiffuseSampler3,IN.TexCoord) * texselectorcol2;
		float4 texpartd3 = tex2D(DiffuseSampler4,IN.TexCoord) * texselectorcol3;
		float4 texpartd4 = tex2D(DiffuseSampler5,IN.TexCoord) * texselectorcol4;
		float4 texpartd5 = cXZ * texselectorcol5;
		float4 diffusemap = texpartd1+texpartd2+texpartd3+texpartd4+texpartd5;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 
		float4 specmap = diffusemap.w;

		// calculate tangent and binormal (saves terrain poly vertice data size)
		float3 p = (IN.WPos);
		float3 dp1 = ddx(p);
		float3 dp2 = ddy(p);
		float2 duv1 = ddx( IN.TexCoord.xy );
		float2 duv2 = ddy( IN.TexCoord.xy );
		float3x3 M = float3x3( dp1, dp2, cross(dp1,dp2) );
		float2x3 invTM = float2x3(cross(M[1],M[2]),cross(M[2],M[0]));
		float3 T = mul( float2( duv1.x, duv2.x ), invTM );
		float3 B = mul( float2( duv1.y, duv2.y ), invTM );
		float3x3 tangentbasis = float3x3( 2*normalize(T), 2*normalize(B), Nn );

		// lighting
		float3 Nb = normalmap;
		Nb.xy = Nb.xy * 2.0 - 1.0;
		Nb.z = sqrt(1.0 - dot(Nb.xy, Nb.xy));
		Nb = mul(Nb,tangentbasis);
		Nb = normalize(Nb);
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,Nb))+0.5,2),dot(Hn,Nb),24);

		// some falloff to blend away as distance increases
		lighting.z = lighting.z * max(1.0f-(viewspacePos.z/1000.0f),0); 

		// dynamic lighting
		float4 spotflashlighting = CalcSpotFlash (Nb,IN.WPos.xyz);   
		float4 dynamicContrib = CalcLighting (Nb,IN.WPos.xyz,Vn,diffusemap,float4(0,0,0,0)) + spotflashlighting;  
	
		// flash light system (flash light control carried in SpotFlashColor.w )
		float conewidth = 24;
		float intensity = max(0, 1.5f - (viewspacePos.z/500.0f));
		float3 lightvector = Vn;
		float3 lightdir = float3(View._m02,View._m12,View._m22);
		float flashlight = pow(max(dot(-lightvector, lightdir),0),conewidth) * intensity * SpotFlashColor.w;	
		
		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = (float4(bouncelightcolor,1) * (AmbiColor) * AmbiColorOverride) * 2;

		// shadow mapping code
		float4 vShadowMapTextureCoord = 0.0f;
		float fShadow = 0.0f;
		if ( ShadowStrength > 0.0f )
		{
			float4 vShadowMapTextureCoord_blend = 0.0f;
			float fPercentLit = 0.0f;
			float fPercentLit_blend = 0.0f;

			// The interval based selection technique compares the pixel's depth against the frustum's cascade divisions.
			float fCurrentPixelDepth;
			fCurrentPixelDepth = IN.vDepth;
			int iCurrentCascadeIndex;
			iCurrentCascadeIndex = 3;
			if ( fCurrentPixelDepth < m_fCascadeFrustumsEyeSpaceDepths[2] ) iCurrentCascadeIndex = 2;
			if ( fCurrentPixelDepth < m_fCascadeFrustumsEyeSpaceDepths[1] ) iCurrentCascadeIndex = 1;
			if ( fCurrentPixelDepth < m_fCascadeFrustumsEyeSpaceDepths[0] ) iCurrentCascadeIndex = 0;

			// Repeat text coord calculations for the next cascade - the next cascade index is used for blurring between maps.
			int iNextCascadeIndex = 1;
			iNextCascadeIndex = min ( 4 - 1, iCurrentCascadeIndex + 1 ); 
			float fBlendBetweenCascadesAmount = 1.0f;
			float fCurrentPixelsBlendBandLocation = 1.0f;
			CalculateBlendAmountForInterval ( iCurrentCascadeIndex, fCurrentPixelDepth, 
				fCurrentPixelsBlendBandLocation, fBlendBetweenCascadesAmount );
				
			// World out texture coordinate into specified shadow map
			float4 finalwpos = IN.WPos;
			ComputeCoordinatesTransform( iCurrentCascadeIndex, finalwpos, vShadowMapTextureCoord );    

			// work out how much shadow
			CalculatePCFPercentLit_highest ( iCurrentCascadeIndex, vShadowMapTextureCoord, fShadow );
									 
			if( fCurrentPixelsBlendBandLocation < m_fCascadeBlendArea ) 
			{  
				// the current pixel is within the blend band.
				// Repeat text coord calculations for the next cascade. 
				// The next cascade index is used for blurring between maps.
				ComputeCoordinatesTransform( iNextCascadeIndex, finalwpos, vShadowMapTextureCoord_blend );  
		   
				// the current pixel is within the blend band.
				CalculatePCFPercentLit_highest ( iNextCascadeIndex, vShadowMapTextureCoord_blend, fPercentLit_blend );
										
				// Blend the two calculated shadows by the blend amount.
				fShadow = lerp( fPercentLit_blend, fShadow, fBlendBetweenCascadesAmount ); 
			}
			
			// extra shadow term comes from veg map (can paint and pre-bake this one)
			fShadow = fShadow + tex2D(VegShadowSampler,IN.TexCoord/500.0f).g;
		}
		
		// finally modulate shadow with strength
		fShadow = fShadow * 0.65f * ShadowStrength;  
		float fInvShadow = 1.0-fShadow;
			
		// paint
		dynamicContrib.xyz = dynamicContrib.xyz + (diffusemap.xyz*float3(flashlight,flashlight,flashlight));
		float4 diffuseContrib = SurfColor * diffusemap * lighting.y * GlobalSurfaceIntensity;
		float4 specContrib = lighting.z * specmap * SurfColor * GlobalSpecular;
		
		// apply shadow mapping to final render
		ambContrib.xyz = ambContrib.xyz * fInvShadow;
		diffuseContrib.xyz = diffuseContrib.xyz * fInvShadow;
		specContrib.xyz = specContrib.xyz * fInvShadow;
		float4 result = diffuseContrib + ambContrib + specContrib + dynamicContrib;
				
		// lime green tint to show where grass is being painted (editor control)
		float fVeg = VegShadowColor.r;
		result.xyz = result.xyz + float3(HighlightParams.y/8.0f,HighlightParams.y/2.0,HighlightParams.y/8.0f) * fVeg;
		
		// highlighter stage : HighlightCursor
		// radius of 500=50.0f and radius of 50.0f=500.0f
		// radius = 500 = 9.75f
		// radius = 50 = 0.975f
		// radius = 5 = 0.0975f
		// radius = 1 = 0.0195f
		float highlightsize = (1.0f/HighlightCursor.z)*25600.0f;
		float2 highlightuv = (((IN.TexCoord/500.0f)-float2(0.5f,0.5f))*highlightsize) + float2(0.5f,0.5f) - (HighlightCursor.xy/(HighlightCursor.z*0.0195));
		float4 highlighttex = tex2D(HighlighterSampler,highlightuv);
		float highlightalpha = (highlighttex.a*0.5f);
		result.xyz = result.xyz + (HighlightParams.x*float3(highlightalpha*HighlightParams.z,highlightalpha*HighlightParams.a,0));
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		finalcolor = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	}
	if ( viewspacePos.z > DistanceTransition.x )
	{
		// copied from Distant technique (any way to re-use code here!?)
		
		// read from pre-rendered mega texture of whole terrain
		float4 diffusemap = float4(tex2D(HighlighterSampler,IN.TexCoord/500.0f).xyz,1);

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);

		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 

		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
		
		// paint lighting in
		float4 diffuseContrib = SurfColor * (diffusemap * lighting.y * GlobalSurfaceIntensity);
		float4 result = ambContrib + diffuseContrib;
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		float4 cheaphudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
		
		// combine for transition effect
		finalcolor = lerp ( finalcolor, cheaphudfogresult, min((viewspacePos.z-DistanceTransition.x)/DistanceTransition.z,1.0f) );
	}
	
	// final color
	return finalcolor;
}

float4 mainlightPS_medium(vertexOutput_low IN) : COLOR
{	
	// clip
	clip(IN.clip);
	
	// veg and rock common texture lookups
	float4 VegShadowColor = tex2D(VegShadowSampler,IN.TexCoord/500.0f);
	float3 rockuv = float3(IN.WPos.x,IN.WPos.y,IN.WPos.z)/500.0f;
	float4 cXY = tex2D(DiffuseSlopeSampler, rockuv.xy);
	float4 cXZ = tex2D(DiffuseSlopeSampler, rockuv.xz);
	float4 cYZ = tex2D(DiffuseSlopeSampler, rockuv.yz);
		
	// transition to Very Low Distant technique
	float4 viewspacePos = mul(IN.WPos, View);
	float4 finalcolor = float4(0,0,0,0);
	if ( viewspacePos.z < DistanceTransition.y )
	{
		// texture selection
		float fShadowFromNormal = IN.WorldNormal.y;
		float texselectorV = VegShadowColor.b;
		float texselectorcol1 = max(0,0.25f-abs(texselectorV-0.00))*4.0f;
		float texselectorcol2 = max(0,0.25f-abs(texselectorV-0.25))*4.0f;
		float texselectorcol3 = max(0,0.25f-abs(texselectorV-0.50))*4.0f;
		float texselectorcol4 = max(0,0.25f-abs(texselectorV-0.75))*4.0f;
		float texselectorcol5 = max(0,0.25f-abs(texselectorV-1.00))*4.0f;
		
		// paint
		float4 texpartd1 = tex2D(DiffuseSampler,IN.TexCoord) * texselectorcol1;
		float4 texpartd2 = tex2D(DiffuseSampler3,IN.TexCoord) * texselectorcol2;
		float4 texpartd3 = tex2D(DiffuseSampler4,IN.TexCoord) * texselectorcol3;
		float4 texpartd4 = tex2D(DiffuseSampler5,IN.TexCoord) * texselectorcol4;
		float4 texpartd5 = cXZ * texselectorcol5;
		float4 diffusemap = texpartd1+texpartd2+texpartd3+texpartd4+texpartd5;
		
		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);
		
		// some falloff to blend away as distance increases
		lighting.z = lighting.z * max(1.0f-(viewspacePos.z/1000.0f),0); 

		// cheap terrain shadow floor texture read
		float fShadow = float4(tex2D(DynTerShaSampler,(IN.TexCoord/500.0f)-float2(0.0005f,0.0005f)).xyz,1);
		fShadow = fShadow * 0.675f * ShadowStrength;
	
		// dynamic lighting
		float4 spotflashlighting = CalcSpotFlash (IN.WorldNormal,IN.WPos.xyz);   
		float4 dynamicContrib = CalcLighting (IN.WorldNormal,IN.WPos.xyz,Vn,diffusemap,float4(0,0,0,0)) + spotflashlighting;  

		// flash light system (flash light control carried in SpotFlashColor.w )
		float conewidth = 24;
		float intensity = max(0, 1.5f - (viewspacePos.z/500.0f));
		float3 lightvector = Vn;
		float3 lightdir = float3(View._m02,View._m12,View._m22);
		float flashlight = pow(max(dot(-lightvector, lightdir),0),conewidth) * intensity * SpotFlashColor.w;	
		
		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * (AmbiColor) * AmbiColorOverride * 2;
			
		// paint lighting in
		dynamicContrib.xyz = dynamicContrib.xyz + (diffusemap.xyz*float3(flashlight,flashlight,flashlight));
		float4 diffuseContrib = SurfColor * diffusemap * lighting.y * GlobalSurfaceIntensity;
		float fInvShadow = 1.0-fShadow;
		ambContrib.xyz = ambContrib.xyz * fInvShadow;
		diffuseContrib.xyz = diffuseContrib.xyz * fInvShadow;
		float4 result = ambContrib + diffuseContrib + dynamicContrib;
		
		// lime green tint to show where grass is being painted (editor control)
		float fVeg = VegShadowColor.r;
		result.xyz = result.xyz + float3(HighlightParams.y/8.0f,HighlightParams.y/2.0,HighlightParams.y/8.0f) * fVeg;
		
		// highlighter stage : HighlightCursor
		// radius of 500=50.0f and radius of 50.0f=500.0f
		// radius = 500 = 9.75f
		// radius = 50 = 0.975f
		// radius = 5 = 0.0975f
		// radius = 1 = 0.0195f
		float highlightsize = (1.0f/HighlightCursor.z)*25600.0f;
		float2 highlightuv = (((IN.TexCoord/500.0f)-float2(0.5f,0.5f))*highlightsize) + float2(0.5f,0.5f) - (HighlightCursor.xy/(HighlightCursor.z*0.0195));
		float4 highlighttex = tex2D(HighlighterSampler,highlightuv);
		float highlightalpha = (highlighttex.a*0.5f);
		result.xyz = result.xyz + (HighlightParams.x*float3(highlightalpha*HighlightParams.z,highlightalpha*HighlightParams.a,0));
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		finalcolor = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	}
	if ( viewspacePos.z > DistanceTransition.x )
	{
		// copied from Distant technique (any way to re-use code here!?)
		
		// read from pre-rendered mega texture of whole terrain
		float4 diffusemap = float4(tex2D(HighlighterSampler,IN.TexCoord/500.0f).xyz,1);

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);

		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 

		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
		
		// paint lighting in
		float4 diffuseContrib = SurfColor * (diffusemap * lighting.y * GlobalSurfaceIntensity);
		float4 result = ambContrib + diffuseContrib;
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		float4 cheaphudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
		
		// combine for transition effect
		finalcolor = lerp ( finalcolor, cheaphudfogresult, min((viewspacePos.z-DistanceTransition.x)/DistanceTransition.z,1.0f) );
	}
	
	// final color
	return finalcolor;
}

float4 mainlightPS_lowest(vertexOutput_low IN) : COLOR
{	
	// clip
	clip(IN.clip);
	
	// veg and rock common texture lookups
	float4 VegShadowColor = tex2D(VegShadowSampler,IN.TexCoord/500.0f);
	float3 rockuv = float3(IN.WPos.x,IN.WPos.y,IN.WPos.z)/500.0f;
	float4 cXY = tex2D(DiffuseSlopeSampler, rockuv.xy);
	float4 cXZ = tex2D(DiffuseSlopeSampler, rockuv.xz);
	float4 cYZ = tex2D(DiffuseSlopeSampler, rockuv.yz);
		
	// transition to Very Low Distant technique
	float4 viewspacePos = mul(IN.WPos, View);
	float4 finalcolor = float4(0,0,0,0);
	if ( viewspacePos.z < DistanceTransition.y )
	{
		// texture selection
		float fShadowFromNormal = IN.WorldNormal.y;
		float texselectorV = VegShadowColor.b;
		float texselectorcol1 = max(0,0.25f-abs(texselectorV-0.00))*4.0f;
		float texselectorcol2 = max(0,0.25f-abs(texselectorV-0.25))*4.0f;
		float texselectorcol3 = max(0,0.25f-abs(texselectorV-0.50))*4.0f;
		float texselectorcol4 = max(0,0.25f-abs(texselectorV-0.75))*4.0f;
		float texselectorcol5 = max(0,0.25f-abs(texselectorV-1.00))*4.0f;
		
		// paint
		float4 texpartd1 = tex2D(DiffuseSampler,IN.TexCoord) * texselectorcol1;
		float4 texpartd2 = tex2D(DiffuseSampler3,IN.TexCoord) * texselectorcol2;
		float4 texpartd3 = tex2D(DiffuseSampler4,IN.TexCoord) * texselectorcol3;
		float4 texpartd4 = tex2D(DiffuseSampler5,IN.TexCoord) * texselectorcol4;
		float4 texpartd5 = cXZ * texselectorcol5;
		float4 diffusemap = texpartd1+texpartd2+texpartd3+texpartd4+texpartd5;
		
		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);
		
		// some falloff to blend away as distance increases
		lighting.z = lighting.z * max(1.0f-(viewspacePos.z/1000.0f),0);

		// cheap terrain shadow floor texture read
		float fShadow = float4(tex2D(DynTerShaSampler,(IN.TexCoord/500.0f)-float2(0.0005f,0.0005f)).xyz,1);
		fShadow = fShadow * 0.675f * ShadowStrength;
	
		// CHEAPEST flash light system (flash light control carried in SpotFlashColor.w )
		float flashlight = (1.0f-min(1,viewspacePos.z/300.0f)) * SpotFlashColor.w;	
		float4 dynamicContrib = diffusemap*float4(flashlight,flashlight,flashlight,1);
		
		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
			
		// paint lighting in
		float4 diffuseContrib = SurfColor * diffusemap * lighting.y * GlobalSurfaceIntensity;
		float fInvShadow = 1.0-fShadow;
		ambContrib.xyz = ambContrib.xyz * fInvShadow;
		diffuseContrib.xyz = diffuseContrib.xyz * fInvShadow;
		float4 result = ambContrib + diffuseContrib + dynamicContrib;
		
		// lime green tint to show where grass is being painted (editor control)
		float fVeg = VegShadowColor.r;
		result.xyz = result.xyz + float3(HighlightParams.y/8.0f,HighlightParams.y/2.0,HighlightParams.y/8.0f) * fVeg;
		
		// highlighter stage : HighlightCursor
		// radius of 500=50.0f and radius of 50.0f=500.0f
		// radius = 500 = 9.75f
		// radius = 50 = 0.975f
		// radius = 5 = 0.0975f
		// radius = 1 = 0.0195f
		float highlightsize = (1.0f/HighlightCursor.z)*25600.0f;
		float2 highlightuv = (((IN.TexCoord/500.0f)-float2(0.5f,0.5f))*highlightsize) + float2(0.5f,0.5f) - (HighlightCursor.xy/(HighlightCursor.z*0.0195));
		float4 highlighttex = tex2D(HighlighterSampler,highlightuv);
		float highlightalpha = (highlighttex.a*0.5f);
		result.xyz = result.xyz + (HighlightParams.x*float3(highlightalpha*HighlightParams.z,highlightalpha*HighlightParams.a,0));
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		finalcolor = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	}
	if ( viewspacePos.z > DistanceTransition.x )
	{
		// copied from Distant technique (any way to re-use code here!?)
		
		// read from pre-rendered mega texture of whole terrain
		float4 diffusemap = float4(tex2D(HighlighterSampler,IN.TexCoord/500.0f).xyz,1);

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);

		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 

		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
		
		// paint lighting in
		float4 diffuseContrib = SurfColor * (diffusemap * lighting.y * GlobalSurfaceIntensity);
		float4 result = ambContrib + diffuseContrib;
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		float4 cheaphudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
		
		// combine for transition effect
		finalcolor = lerp ( finalcolor, cheaphudfogresult, min((viewspacePos.z-DistanceTransition.x)/DistanceTransition.z,1.0f) );
	}
	
	// final color
	return finalcolor;
}

float4 mainlightPS_highest_prebake(vertexOutput IN) : COLOR
{	
	// clip
	clip(IN.clip);
	
	// veg and rock common texture lookups
	float4 VegShadowColor = tex2D(VegShadowSampler,IN.TexCoord/500.0f);
	float3 rockuv = float3(IN.WPos.x,IN.WPos.y,IN.WPos.z)/500.0f;
	float4 cXZ = tex2D(DiffuseSlopeSampler, rockuv.xz);
	
	// rock normal references
	float4 nXY = tex2D(NormalMap3Sampler, rockuv.xy);
	float4 nYZ = tex2D(NormalMap3Sampler, rockuv.yz);
		
	// transition to Very Low Distant technique
	float4 viewspacePos = mul(IN.WPos, View);
	float4 finalcolor = float4(0,0,0,0);
	if ( viewspacePos.z < DistanceTransition.y )
	{
		// triplanar vertical ref
		float4 cXY = tex2D(DiffuseSlopeSampler, rockuv.xy);
		float4 cYZ = tex2D(DiffuseSlopeSampler, rockuv.yz);
		
		// texture selection
		float fShadowFromNormal = IN.WorldNormal.y;
		float texselectorV = VegShadowColor.b;
		float texselectorcol1 = max(0,0.25f-abs(texselectorV-0.00))*4.0f;
		float texselectorcol2 = max(0,0.25f-abs(texselectorV-0.25))*4.0f;
		float texselectorcol3 = max(0,0.25f-abs(texselectorV-0.50))*4.0f;
		float texselectorcol4 = max(0,0.25f-abs(texselectorV-0.75))*4.0f;
		float texselectorcol5 = max(0,0.25f-abs(texselectorV-1.00))*4.0f;
		
		// work out normal textures from selector
		float3 texpart1 = tex2D(NormalMap1Sampler,IN.TexCoord) * texselectorcol1;
		float3 texpart2 = tex2D(NormalMap2Sampler,IN.TexCoord) * texselectorcol2;
		float3 texpart3 = tex2D(NormalMap3Sampler,IN.TexCoord) * texselectorcol3;
		float3 texpart4 = tex2D(NormalMap3Sampler,IN.TexCoord) * texselectorcol4;
		float3 texpart5 = tex2D(NormalMap3Sampler,IN.TexCoord) * texselectorcol5;
		float3 normalmap = texpart1+texpart2+texpart3+texpart4+texpart5;

		// merge rock normal on deep slopes	
		float3 Nn = normalize(IN.WorldNormal);
		float mXY = pow(abs(Nn.z),6);
		float mXZ = pow(abs(Nn.y),2);
		float mYZ = pow(abs(Nn.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		normalmap = nXY*mXY + normalmap*mXZ + nYZ*mYZ; 
					
		// texture references
		float4 texpartd1 = tex2D(DiffuseSampler,IN.TexCoord) * texselectorcol1;
		float4 texpartd2 = tex2D(DiffuseSampler3,IN.TexCoord) * texselectorcol2;
		float4 texpartd3 = tex2D(DiffuseSampler4,IN.TexCoord) * texselectorcol3;
		float4 texpartd4 = tex2D(DiffuseSampler5,IN.TexCoord) * texselectorcol4;
		float4 texpartd5 = cXZ * texselectorcol5;
		float4 diffusemap = texpartd1+texpartd2+texpartd3+texpartd4+texpartd5;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 
		float4 specmap = diffusemap.w;

		// calculate tangent and binormal (saves terrain poly vertice data size)
		float3 p = (IN.WPos);
		float3 dp1 = ddx(p);
		float3 dp2 = ddy(p);
		float2 duv1 = ddx( IN.TexCoord.xy );
		float2 duv2 = ddy( IN.TexCoord.xy );
		float3x3 M = float3x3( dp1, dp2, cross(dp1,dp2) );
		float2x3 invTM = float2x3(cross(M[1],M[2]),cross(M[2],M[0]));
		float3 T = mul( float2( duv1.x, duv2.x ), invTM );
		float3 B = mul( float2( duv1.y, duv2.y ), invTM );
		float3x3 tangentbasis = float3x3( 2*normalize(T), 2*normalize(B), Nn );

		// lighting
		float3 Nb = normalmap;
		Nb.xy = Nb.xy * 2.0 - 1.0;
		Nb.z = sqrt(1.0 - dot(Nb.xy, Nb.xy));
		Nb = mul(Nb,tangentbasis);
		Nb = normalize(Nb);
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,Nb))+0.5,2),dot(Hn,Nb),24);

		// some falloff to blend away as distance increases
		lighting.z = lighting.z * max(1.0f-(viewspacePos.z/1000.0f),0); 

		// dynamic lighting
		float4 spotflashlighting = CalcSpotFlash (Nb,IN.WPos.xyz);   
		float4 dynamicContrib = CalcLighting (Nb,IN.WPos.xyz,Vn,diffusemap,float4(0,0,0,0)) + spotflashlighting;  
		
		// flash light system (flash light control carried in SpotFlashColor.w )
		float conewidth = 24;
		float intensity = max(0, 1.5f - (viewspacePos.z/500.0f));
		float3 lightvector = Vn;
		float3 lightdir = float3(View._m02,View._m12,View._m22);
		float flashlight = pow(max(dot(-lightvector, lightdir),0),conewidth) * intensity * SpotFlashColor.w;
		dynamicContrib.xyz = dynamicContrib.xyz + (diffusemap.xyz*float3(flashlight,flashlight,flashlight));
		
		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = (float4(bouncelightcolor,1) * (AmbiColor) * AmbiColorOverride) * 2;
		
		// paint
		float4 diffuseContrib = SurfColor * diffusemap * lighting.y * GlobalSurfaceIntensity;
		float4 specContrib = lighting.z * specmap * SurfColor * GlobalSpecular;
		
		// apply shadow mapping to final render
		float4 result = diffuseContrib + ambContrib + specContrib + dynamicContrib;
				
		// lime green tint to show where grass is being painted (editor control)
		float fVeg = VegShadowColor.r;
		result.xyz = result.xyz + float3(HighlightParams.y/8.0f,HighlightParams.y/2.0,HighlightParams.y/8.0f) * fVeg;
		
		// highlighter stage : HighlightCursor
		// radius of 500=50.0f and radius of 50.0f=500.0f
		// radius = 500 = 9.75f
		// radius = 50 = 0.975f
		// radius = 5 = 0.0975f
		// radius = 1 = 0.0195f
		float highlightsize = (1.0f/HighlightCursor.z)*25600.0f;
		float2 highlightuv = (((IN.TexCoord/500.0f)-float2(0.5f,0.5f))*highlightsize) + float2(0.5f,0.5f) - (HighlightCursor.xy/(HighlightCursor.z*0.0195));
		float4 highlighttex = tex2D(HighlighterSampler,highlightuv);
		float highlightalpha = (highlighttex.a*0.5f);
		result.xyz = result.xyz + (HighlightParams.x*float3(highlightalpha*HighlightParams.z,highlightalpha*HighlightParams.a,0));
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		finalcolor = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	}
	if ( viewspacePos.z > DistanceTransition.x )
	{
		// read from pre-rendered mega texture of whole terrain
		float4 diffusemap = float4(tex2D(HighlighterSampler,IN.TexCoord/500.0f).xyz,1);

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);

		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXZ*mXY + diffusemap*mXZ + cXZ*mYZ; 

		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
		
		// paint lighting in
		float4 diffuseContrib = SurfColor * (diffusemap * lighting.y * GlobalSurfaceIntensity);
		float4 result = ambContrib + diffuseContrib;
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		float4 cheaphudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
		
		// combine for transition effect
		finalcolor = lerp ( finalcolor, cheaphudfogresult, min((viewspacePos.z-DistanceTransition.x)/DistanceTransition.z,1.0f) );
	}
	
	// final color
	return finalcolor;
}

float4 mainlightPS_medium_prebake(vertexOutput_low IN) : COLOR
{	
	// clip
	clip(IN.clip);
	
	// veg and rock common texture lookups
	float4 VegShadowColor = tex2D(VegShadowSampler,IN.TexCoord/500.0f);
	float3 rockuv = float3(IN.WPos.x,IN.WPos.y,IN.WPos.z)/500.0f;
	float4 cXZ = tex2D(DiffuseSlopeSampler, rockuv.xz);
		
	// transition to Very Low Distant technique
	float4 viewspacePos = mul(IN.WPos, View);
	float4 finalcolor = float4(0,0,0,0);
	if ( viewspacePos.z < DistanceTransition.y )
	{
		// triplanar vertical ref
		float4 cXY = tex2D(DiffuseSlopeSampler, rockuv.xy);
		float4 cYZ = tex2D(DiffuseSlopeSampler, rockuv.yz);
		
		// texture selection
		float fShadowFromNormal = IN.WorldNormal.y;
		float texselectorV = VegShadowColor.b;
		float texselectorcol1 = max(0,0.25f-abs(texselectorV-0.00))*4.0f;
		float texselectorcol2 = max(0,0.25f-abs(texselectorV-0.25))*4.0f;
		float texselectorcol3 = max(0,0.25f-abs(texselectorV-0.50))*4.0f;
		float texselectorcol4 = max(0,0.25f-abs(texselectorV-0.75))*4.0f;
		float texselectorcol5 = max(0,0.25f-abs(texselectorV-1.00))*4.0f;
		
		// paint
		float4 texpartd1 = tex2D(DiffuseSampler,IN.TexCoord) * texselectorcol1;
		float4 texpartd2 = tex2D(DiffuseSampler3,IN.TexCoord) * texselectorcol2;
		float4 texpartd3 = tex2D(DiffuseSampler4,IN.TexCoord) * texselectorcol3;
		float4 texpartd4 = tex2D(DiffuseSampler5,IN.TexCoord) * texselectorcol4;
		float4 texpartd5 = cXZ * texselectorcol5;
		float4 diffusemap = texpartd1+texpartd2+texpartd3+texpartd4+texpartd5;
		
		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);
		
		// some falloff to blend away as distance increases
		lighting.z = lighting.z * max(1.0f-(viewspacePos.z/1000.0f),0); 

		// dynamic lighting
		float4 spotflashlighting = CalcSpotFlash (IN.WorldNormal,IN.WPos.xyz);   
		float4 dynamicContrib = CalcLighting (IN.WorldNormal,IN.WPos.xyz,Vn,diffusemap,float4(0,0,0,0)) + spotflashlighting;  
		
		// flash light system (flash light control carried in SpotFlashColor.w )
		float conewidth = 24;
		float intensity = max(0, 1.5f - (viewspacePos.z/500.0f));
		float3 lightvector = Vn;
		float3 lightdir = float3(View._m02,View._m12,View._m22);
		float flashlight = pow(max(dot(-lightvector, lightdir),0),conewidth) * intensity * SpotFlashColor.w;	
		dynamicContrib.xyz = dynamicContrib.xyz + (diffusemap.xyz*float3(flashlight,flashlight,flashlight));
		
		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * (AmbiColor) * AmbiColorOverride * 2;
			
		// paint lighting in
		float4 diffuseContrib = SurfColor * diffusemap * lighting.y * GlobalSurfaceIntensity;
		float4 result = ambContrib + diffuseContrib + dynamicContrib;
		
		// lime green tint to show where grass is being painted (editor control)
		float fVeg = VegShadowColor.r;
		result.xyz = result.xyz + float3(HighlightParams.y/8.0f,HighlightParams.y/2.0,HighlightParams.y/8.0f) * fVeg;
		
		// highlighter stage : HighlightCursor
		// radius of 500=50.0f and radius of 50.0f=500.0f
		// radius = 500 = 9.75f
		// radius = 50 = 0.975f
		// radius = 5 = 0.0975f
		// radius = 1 = 0.0195f
		float highlightsize = (1.0f/HighlightCursor.z)*25600.0f;
		float2 highlightuv = (((IN.TexCoord/500.0f)-float2(0.5f,0.5f))*highlightsize) + float2(0.5f,0.5f) - (HighlightCursor.xy/(HighlightCursor.z*0.0195));
		float4 highlighttex = tex2D(HighlighterSampler,highlightuv);
		float highlightalpha = (highlighttex.a*0.5f);
		result.xyz = result.xyz + (HighlightParams.x*float3(highlightalpha*HighlightParams.z,highlightalpha*HighlightParams.a,0));
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		finalcolor = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	}
	if ( viewspacePos.z > DistanceTransition.x )
	{
		// read from pre-rendered mega texture of whole terrain
		float4 diffusemap = float4(tex2D(HighlighterSampler,IN.TexCoord/500.0f).xyz,1);

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);

		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXZ*mXY + diffusemap*mXZ + cXZ*mYZ; 

		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
		
		// paint lighting in
		float4 diffuseContrib = SurfColor * (diffusemap * lighting.y * GlobalSurfaceIntensity);
		float4 result = ambContrib + diffuseContrib;
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		float4 cheaphudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
		
		// combine for transition effect
		finalcolor = lerp ( finalcolor, cheaphudfogresult, min((viewspacePos.z-DistanceTransition.x)/DistanceTransition.z,1.0f) );
	}
	
	// final color
	return finalcolor;
}

float4 mainlightPS_lowest_prebake(vertexOutput_low IN) : COLOR
{	
	// clip
	clip(IN.clip);
	
	// veg and rock common texture lookups
	float4 VegShadowColor = tex2D(VegShadowSampler,IN.TexCoord/500.0f);
	float3 rockuv = float3(IN.WPos.x,IN.WPos.y,IN.WPos.z)/500.0f;
	float4 cXZ = tex2D(DiffuseSlopeSampler, rockuv.xz);
		
	// transition to Very Low Distant technique
	float4 viewspacePos = mul(IN.WPos, View);
	float4 finalcolor = float4(0,0,0,0);
	if ( viewspacePos.z < DistanceTransition.y )
	{
		// triplanar vertical rocks
		float4 cXY = tex2D(DiffuseSlopeSampler, rockuv.xy);
		float4 cYZ = tex2D(DiffuseSlopeSampler, rockuv.yz);
		
		// texture selection
		float fShadowFromNormal = IN.WorldNormal.y;
		float texselectorV = VegShadowColor.b;
		float texselectorcol1 = max(0,0.25f-abs(texselectorV-0.00))*4.0f;
		float texselectorcol2 = max(0,0.25f-abs(texselectorV-0.25))*4.0f;
		float texselectorcol3 = max(0,0.25f-abs(texselectorV-0.50))*4.0f;
		float texselectorcol4 = max(0,0.25f-abs(texselectorV-0.75))*4.0f;
		float texselectorcol5 = max(0,0.25f-abs(texselectorV-1.00))*4.0f;
		
		// paint
		float4 texpartd1 = tex2D(DiffuseSampler,IN.TexCoord) * texselectorcol1;
		float4 texpartd2 = tex2D(DiffuseSampler3,IN.TexCoord) * texselectorcol2;
		float4 texpartd3 = tex2D(DiffuseSampler4,IN.TexCoord) * texselectorcol3;
		float4 texpartd4 = tex2D(DiffuseSampler5,IN.TexCoord) * texselectorcol4;
		float4 texpartd5 = cXZ * texselectorcol5;
		float4 diffusemap = texpartd1+texpartd2+texpartd3+texpartd4+texpartd5;
		
		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXY*mXY + diffusemap*mXZ + cYZ*mYZ; 

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);
		
		// some falloff to blend away as distance increases
		lighting.z = lighting.z * max(1.0f-(viewspacePos.z/1000.0f),0); 

		// CHEAPEST flash light system (flash light control carried in SpotFlashColor.w )
		float flashlight = (1.0f-min(1,viewspacePos.z/300.0f)) * SpotFlashColor.w;	
		
		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
			
		// paint lighting in
		float4 diffuseContrib = SurfColor * diffusemap * lighting.y * GlobalSurfaceIntensity;
		diffuseContrib.xyz = diffuseContrib.xyz + (diffusemap.xyz*float3(flashlight,flashlight,flashlight));
		float4 result = ambContrib + diffuseContrib;
		
		// lime green tint to show where grass is being painted (editor control)
		float fVeg = VegShadowColor.r;
		result.xyz = result.xyz + float3(HighlightParams.y/8.0f,HighlightParams.y/2.0,HighlightParams.y/8.0f) * fVeg;
		
		// highlighter stage : HighlightCursor
		// radius of 500=50.0f and radius of 50.0f=500.0f
		// radius = 500 = 9.75f
		// radius = 50 = 0.975f
		// radius = 5 = 0.0975f
		// radius = 1 = 0.0195f
		float highlightsize = (1.0f/HighlightCursor.z)*25600.0f;
		float2 highlightuv = (((IN.TexCoord/500.0f)-float2(0.5f,0.5f))*highlightsize) + float2(0.5f,0.5f) - (HighlightCursor.xy/(HighlightCursor.z*0.0195));
		float4 highlighttex = tex2D(HighlighterSampler,highlightuv);
		float highlightalpha = (highlighttex.a*0.5f);
		result.xyz = result.xyz + (HighlightParams.x*float3(highlightalpha*HighlightParams.z,highlightalpha*HighlightParams.a,0));
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		finalcolor = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
	}
	if ( viewspacePos.z > DistanceTransition.x )
	{
		// copied from Distant technique (any way to re-use code here!?)
		
		// read from pre-rendered mega texture of whole terrain
		float4 diffusemap = float4(tex2D(HighlighterSampler,IN.TexCoord/500.0f).xyz,1);

		// cheapest directional lighting
		float3 Ln = normalize(IN.LightVec);
		float3 V  = (eyePos - IN.WPos);  
		float3 Vn  = normalize(V); 
		float3 Hn = normalize(Vn+Ln);
		float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);

		// merge rock texture on deep slopes	
		float mXY = pow(abs(IN.WorldNormal.z),6);
		float mXZ = pow(abs(IN.WorldNormal.y),2);
		float mYZ = pow(abs(IN.WorldNormal.x),6);		
		float total = mXY + mXZ + mYZ;
		mXY /= total;
		mXZ /= total;
		mYZ /= total;
		diffusemap = cXZ*mXY + diffusemap*mXZ + cXZ*mYZ; 

		// spherical ambience
		float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
		float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
		bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
		float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
		
		// paint lighting in
		float4 diffuseContrib = SurfColor * (diffusemap * lighting.y * GlobalSurfaceIntensity);
		float4 result = ambContrib + diffuseContrib;
		
		//calculate hud pixel-fog
		float4 cameraPos = mul(IN.WPos, View);
		float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
		float4 cheaphudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
		
		// combine for transition effect
		finalcolor = lerp ( finalcolor, cheaphudfogresult, min((viewspacePos.z-DistanceTransition.x)/DistanceTransition.z,1.0f) );
	}
	
	// final color
	return finalcolor;
}

float4 mainlightPS_distant(vertexOutput_low IN) : COLOR
{
	// clip
	clip(IN.clip);

	// read from pre-rendered mega texture of whole terrain
	float4 diffusemap = float4(tex2D(HighlighterSampler,IN.TexCoord/500.0f).xyz,1);

	// triplanar even for distant terrain (can we avoid this?)
	float3 rockuv = float3(IN.WPos.x,IN.WPos.y,IN.WPos.z)/500.0f;
	float4 cXZ = tex2D(DiffuseSlopeSampler, rockuv.xz);
	
	// cheapest directional lighting
	float3 Ln = normalize(IN.LightVec);
	float3 V  = (eyePos - IN.WPos);  
	float3 Vn  = normalize(V); 
	float3 Hn = normalize(Vn+Ln);
	float4 lighting = lit(pow(0.5*(dot(Ln,IN.WorldNormal))+0.5,2),dot(Hn,IN.WorldNormal),24);

	// merge rock texture on deep slopes	
	float mXY = pow(abs(IN.WorldNormal.z),6);
	float mXZ = pow(abs(IN.WorldNormal.y),2);
	float mYZ = pow(abs(IN.WorldNormal.x),6);		
	float total = mXY + mXZ + mYZ;
	mXY /= total;
	mXZ /= total;
	mYZ /= total;
	diffusemap = cXZ*mXY + diffusemap*mXZ + cXZ*mYZ; 

	// spherical ambience
	float fSkyFloorRatio = (1+dot(IN.WorldNormal.xyz,float3(0,1,0)))/2;
	float3 bouncelightcolor = lerp(FloorColor,SkyColor,fSkyFloorRatio) * diffusemap.xyz * 0.8;
	bouncelightcolor = bouncelightcolor + (diffusemap.xyz * 0.2);
	float4 ambContrib = float4(bouncelightcolor,1) * AmbiColor * AmbiColorOverride * 2;
		
	// paint lighting in
	float4 diffuseContrib = SurfColor * (diffusemap * lighting.y * GlobalSurfaceIntensity);
	float4 result = ambContrib + diffuseContrib;
		
	//calculate hud pixel-fog
	float4 cameraPos = mul(IN.WPos, View);
	float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
	float4 cheaphudfogresult = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
		
	// cheapest chips!
	return cheaphudfogresult;
}

float4 blackPS(vertexOutput_low IN) : COLOR
{
    clip(IN.clip);
	return float4(0,0,0,1);
}

/****** technique ********************************/

technique Highest
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_highest();
        PixelShader  = compile ps_3_0 mainlightPS_highest();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique High
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_highest();
        PixelShader  = compile ps_3_0 mainlightPS_highest();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique Medium
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_lowest();
        PixelShader  = compile ps_3_0 mainlightPS_medium();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique Lowest
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_lowest();
        PixelShader  = compile ps_3_0 mainlightPS_lowest();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique Highest_Prebake
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_highest();
        PixelShader  = compile ps_3_0 mainlightPS_highest_prebake();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique High_Prebake
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_highest();
        PixelShader  = compile ps_3_0 mainlightPS_highest_prebake();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique Medium_Prebake
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_lowest();
        PixelShader  = compile ps_3_0 mainlightPS_medium_prebake();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique Lowest_Prebake
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_lowest();
        PixelShader  = compile ps_3_0 mainlightPS_lowest_prebake();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique Distant
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_lowest();
        PixelShader  = compile ps_3_0 mainlightPS_distant();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique DepthMap
{
 	pass p0
    {		
	VertexShader = compile vs_2_0 mainVS_lowest(); 
	PixelShader  = NULL;	
        CullMode = NONE;
   }
}

technique ReflectedOnly
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS_lowest();
        PixelShader  = compile ps_3_0 mainlightPS_distant();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}

technique blacktextured
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_2_0 mainVS_lowest();
        PixelShader  = compile ps_2_0 blackPS();
        AlphaBlendEnable = FALSE;
        AlphaTestEnable = FALSE;
    }
}
