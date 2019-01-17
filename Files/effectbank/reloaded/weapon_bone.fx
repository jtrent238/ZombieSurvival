string Description = "Weapon Shader (bones)";

// shadow mapping
matrix m_mShadow;
float4 m_vCascadeOffset[8];
float4 m_vCascadeScale[8];
int    m_nCascadeLevels;   
float  m_fCascadeBlendArea;
float  m_fTexelSize; 
float  m_fCascadeFrustumsEyeSpaceDepths[8];

float ShadowStrength
<    string UIName =  "ShadowStrength";    
> = {1.0f};

float GlobalSpecular
<    string UIName =  "GlobalSpecular";    
> = {0.5f};

float GlobalSurfaceIntensity
<    string UIName =  "GlobalSurfaceIntensity";    
> = {1.0f};

// regular constants
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
float boneCount : BoneCount;
float4x4 boneMatrix[60] : BoneMatrixPalette;
float4 clipPlane : ClipPlane;

float4 LightSource
<   string UIType = "Fixed Light Direction";
> = {-0.3f,-0.4f,-0.3f,1.0f};

float4 AmbiColor : Ambient
<    string UIName =  "AmbiColor";    
> = {0.3f, 0.3f, 0.3f, 1.0f};

float4 AmbiColorOverride
<    string UIName =  "AmbiColorOverride";    
> = {1.0f, 1.0f, 1.0f, 1.0f};

float4 SurfColor : Diffuse
<    string UIName =  "SurfColor";    
> = {1.0f, 0.98f, 0.8, 1.0f};

float4 SkyColor : Diffuse
<    string UIName =  "SkyColor";    
> = {1.0, 1.0, 1.0, 1.0f};

float4 FloorColor : Diffuse
<    string UIName =  "FloorColor";    
> = {1.0, 1.0, 1.00, 1.0f};

float4 SpotFlashPos;
float4 SpotFlashColor;

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

//Shader Variables pulled from FPI scripting 
float4 ShaderVariables : ShaderVariables
<    string UIName =  "Shader Variables";    
> = {1.0f, 1.0f, 1.0f, 1.0f};

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

//FloorPositionY.x holds the shadow offset value which places the shadow at character's feet
float4 FloorPositionY : Diffuse
<
> = { 0.000000, 0.000000, 0.000000, 0.000000 };

//Textures for guns
texture DiffuseMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>; 
texture NormalMap : DiffuseMap
<
    string Name = "N.tga";
    string type = "2D";
>;
texture SpecularMap : SpecularMap
<
    string Name = "R.tga";
    string type = "2D";
>;
texture IlluminationMap : IlluminationMap
<
    string Name = "I.tga";
    string type = "2D";
>;
texture CubeMap
<
    string Name = "CUBE.tga";
    string type = "CUBE";
>;
texture VegMap : DiffuseMap
<
    string Name = "V.tga";
    string type = "2D";
>;
texture DynTerShaMap : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;
texture DepthMapTX2 : DiffuseMap
<
    string Name = "DEPTH2.tga";
    string type = "2D";
>;

sampler2D DiffuseMapSampler = sampler_state
{
	Texture = <DiffuseMap>;
	MinFilter = ANISOTROPIC;
	MaxAnisotropy = 8;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	SRGBTEXTURE = 1;
};
sampler2D NormalMapSampler = sampler_state
{
	Texture = <NormalMap>;
	MinFilter = ANISOTROPIC;
	MaxAnisotropy = 8;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
};
sampler2D SpecularMapSampler = sampler_state
{
	Texture = <SpecularMap>;
	MinFilter = ANISOTROPIC;
	MaxAnisotropy = 8;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	SRGBTEXTURE = 1;
};
sampler2D IlluminationMapSampler = sampler_state
{
	Texture = <IlluminationMap>;
	MinFilter = ANISOTROPIC;
	MaxAnisotropy = 8;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	SRGBTEXTURE = 1;
};
samplerCUBE CubeMapSampler = sampler_state
{
	Texture = <CubeMap>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	SRGBTEXTURE = 1;
};
sampler2D VegMapSampler = sampler_state
{
	Texture = <VegMap>;
	MinFilter = ANISOTROPIC;
	MaxAnisotropy = 8;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
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
sampler2D DepthMap2 = sampler_state
{
    Texture = <DepthMapTX2>;	
    MinFilter = POINT;//LINEAR;
    MagFilter = POINT;//LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};

struct appdata 
{
    float3 Position 	: POSITION;
    float2 UV		: TEXCOORD0;
    float4 Normal   	: NORMAL;
    float4 Tangent  	: TANGENT0;
    float4 Binormal 	: BINORMAL0;
    float4 Blendweight	: TEXCOORD1;
    float4 Blendindices	: TEXCOORD2;
};

struct vertexOutput 
{
    float4 HPosition	: POSITION;
    float2 TexCoord	: TEXCOORD0;
    float3 LightVec	: TEXCOORD1;
    float3 WorldNormal	: TEXCOORD2;    
    float3 WorldTangent	: TEXCOORD3;
    float3 WorldBinormal: TEXCOORD4;
    float3 WorldEyeVec	: TEXCOORD5;    
    float3 WPos         : TEXCOORD6;
    float clip          : TEXCOORD7;    
    float2 vegshadowuv  : TEXCOORD8;
    float vDepth        : TEXCOORD9;
};

void ComputeCoordinatesTransform( in int iCascadeIndex,
                                      in float4 InterpolatedPosition ,
                                      in out float4 vShadowTexCoord ) 
{
	float4 vLightDot = mul ( InterpolatedPosition, m_mShadow );
    vLightDot *= m_vCascadeScale[iCascadeIndex];
    vLightDot += m_vCascadeOffset[iCascadeIndex];
	vShadowTexCoord.xyz = vLightDot.xyz;
} 

void CalculateRightAndUpTexelDepthDeltas ( in float3 vShadowTexDDX,
                                           in float3 vShadowTexDDY,
                                           out float fUpTextDepthWeight,
                                           out float fRightTextDepthWeight )
{
	// This function calculates the screen space depth for shadow space texels    
    // We use the derivatives in X and Y to create a transformation matrix.  Because these derivives give us the 
    // transformation from screen space to shadow space, we need the inverse matrix to take us from shadow space 
    // to screen space.  This new matrix will allow us to map shadow map texels to screen space.  This will allow 
    // us to find the screen space depth of a corresponding depth pixel.
    // This is not a perfect solution as it assumes the underlying geometry of the scene is a plane.  A more 
    // accureate way of finding the actual depth would be to do a deferred rendering approach and actually 
    // sample the depth (ca-ching dudes!)
    // Using an offset, or using variance shadow maps is a better approach to reducing these artifacts in most cases.
    
    float2x2 matScreentoShadow = float2x2( vShadowTexDDX.xy, vShadowTexDDY.xy );
    float fDeterminant = determinant ( matScreentoShadow );
    
    float fInvDeterminant = 1.0f / fDeterminant;
    
    float2x2 matShadowToScreen = float2x2 (
        matScreentoShadow._22 * fInvDeterminant, matScreentoShadow._12 * -fInvDeterminant, 
        matScreentoShadow._21 * -fInvDeterminant, matScreentoShadow._11 * fInvDeterminant );

    float2 vRightShadowTexelLocation = float2( m_fTexelSize, 0.0f );
    float2 vUpShadowTexelLocation = float2( 0.0f, m_fTexelSize );  
    
    // Transform the right pixel by the shadow space to screen space matrix.
    float2 vRightTexelDepthRatio = mul( vRightShadowTexelLocation,  matShadowToScreen );
    float2 vUpTexelDepthRatio = mul( vUpShadowTexelLocation,  matShadowToScreen );

    // We can now caculate how much depth changes when you move up or right in the shadow map.
    // We use the ratio of change in x and y times the dervivite in X and Y of the screen space 
    // depth to calculate this change.
    fUpTextDepthWeight = 
        vUpTexelDepthRatio.x * vShadowTexDDX.z 
        + vUpTexelDepthRatio.y * vShadowTexDDY.z;
    fRightTextDepthWeight = 
        vRightTexelDepthRatio.x * vShadowTexDDX.z 
        + vRightTexelDepthRatio.y * vShadowTexDDY.z;  
}

void CalculatePCFPercentLit ( in int iCurrentCascadeIndex,
							  in float4 vShadowTexCoord, 
                              in float fRightTexelDepthDelta, 
                              in float fUpTexelDepthDelta,
                              out float fPercentLit ) 
{
	// Use PCF to sample the depth map and return a percent lit value.
    fPercentLit = 0.0f;
	
	float fTS = 1.0f/1024.0f;//m_fTexelSize * 2.0f;
	float fCurrentZDepth = vShadowTexCoord.z-0.00095f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x,vShadowTexCoord.y-fTS)).x ? 1.0f : 0.0f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x+fTS,vShadowTexCoord.y-fTS)).x ? 1.0f : 0.0f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x-fTS,vShadowTexCoord.y-fTS)).x ? 1.0f : 0.0f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x,vShadowTexCoord.y)).x ? 1.0f : 0.0f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x+fTS,vShadowTexCoord.y)).x ? 1.0f : 0.0f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x-fTS,vShadowTexCoord.y)).x ? 1.0f : 0.0f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x,vShadowTexCoord.y+fTS)).x ? 1.0f : 0.0f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x+fTS,vShadowTexCoord.y+fTS)).x ? 1.0f : 0.0f;
	fPercentLit += fCurrentZDepth > tex2D(DepthMap2,float2(vShadowTexCoord.x-fTS,vShadowTexCoord.y+fTS)).x ? 1.0f : 0.0f;
	fPercentLit /= 9.0f;
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

vertexOutput mainVS_highest(appdata IN)
{
    vertexOutput OUT;
    
    float3x3 scaleMat =    {1,0,0,
                           0,1.1,0,
                           0,0,1.1};
    
    float3 netPosition = 0, netNormal = 0;
	for (int i = 0; i < 3; i++)
	{
	 float index = IN.Blendindices[i];
	 float3x4 model = float3x4(boneMatrix[index][0], boneMatrix[index][1], boneMatrix[index][2]);     
	 float3 vec3 = mul(model, float4(IN.Position, 1));
	 vec3 = vec3 + boneMatrix[index][3].xyz;
	 float3x3 rotate = float3x3(model[0].xyz, model[1].xyz, model[2].xyz); 
	 float3 norm3 = mul(rotate, IN.Normal);
	 netPosition += vec3.xyz * IN.Blendweight[i];
	 netNormal += norm3.xyz * IN.Blendweight[i];
	}
	
    float4 tempPos = float4(netPosition,1.0);
    netNormal = normalize(netNormal);
    
    OUT.WorldNormal = mul(netNormal, WorldIT).xyz;
    OUT.WorldTangent = mul(IN.Tangent, WorldIT).xyz;   
	OUT.WorldBinormal = mul(IN.Binormal, WorldIT).xyz; 
    
    float3 worldSpacePos = mul(tempPos, World).xyz;
    OUT.WPos = worldSpacePos;
    
    //can offset lights a bit to avoid shading artifacts when very close to light source
    OUT.LightVec = LightSource;
       
	// shadow painted in veg shadow map generated from cascade shadow capture and user painting?)
	// and needs a UV coordinate derived from the world position of the vegetable
	OUT.vegshadowuv = float2(worldSpacePos.x/51200.0f,worldSpacePos.z/51200.0f);
	   
    OUT.TexCoord = IN.UV;
    OUT.WorldEyeVec = (ViewInverse[3].xyz - worldSpacePos); 
    OUT.HPosition = mul(tempPos, WorldViewProjection);  
    
    // all shaders should send the clip value to the pixel shader (for refr/refl)
    OUT.clip = (worldSpacePos.y * clipPlane.y) + clipPlane.a; // good for water plane

    // SHADOW MAPPING - world position and projected depth (for cascade distance calc)
    OUT.vDepth = mul( float4(netPosition,1), WorldViewProjection ).z; 
	
    return OUT;
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

float4 mainPS_highest(vertexOutput IN) : COLOR
{
    float4 finalcolor;                             
	clip(IN.clip);  // all shaders should receive the clip value     
        
    float4 diffusemap = tex2D(DiffuseMapSampler,IN.TexCoord.xy);
    float4 specmap = tex2D(SpecularMapSampler,IN.TexCoord.xy);    
    float4 illummap = tex2D(IlluminationMapSampler,IN.TexCoord.xy);    
    float4 normalmap = tex2D(NormalMapSampler,IN.TexCoord.xy); //sample normal map
    normalmap.xyz = normalmap.xyz *2 -1;  //expand normal map
	
    float3 Ln = normalize(IN.LightVec);    
    float3 Nn = (IN.WorldNormal);
    float3 Tn = (IN.WorldTangent);
    float3 Bn = (IN.WorldBinormal);
    
    float3 Nb = (normalmap.z * Nn) + (1.0 * (normalmap.x * Tn + normalmap.y * Bn));
    Nb = normalize(Nb);
    
    float3 Vn = normalize(IN.WorldEyeVec);
    float3 Hn = normalize(Vn + Ln);
    float3 reflectvect = normalize(reflect(-Vn,Nb));
    float4 cubemap = texCUBElod(CubeMapSampler,float4(reflectvect,(diffusemap.a*3)));
    
	// shadow mapping code
    float4 vShadowMapTextureCoord = 0.0f;
    float4 vShadowMapTextureCoord_blend = 0.0f;
    float fPercentLit = 0.0f;
    float fPercentLit_blend = 0.0f;
    float fUpTextDepthWeight=0;
    float fRightTextDepthWeight=0;
    float fUpTextDepthWeight_blend=0;
    float fRightTextDepthWeight_blend=0;

    // The interval based selection technique compares the pixel's depth against the frustum's cascade divisions.
    float fCurrentPixelDepth;
    fCurrentPixelDepth = IN.vDepth;
    int iCurrentCascadeIndex = 1;

	// Repeat text coord calculations for the next cascade. 
	// The next cascade index is used for blurring between maps.
    int iNextCascadeIndex = 1;
	iNextCascadeIndex = min ( 4 - 1, iCurrentCascadeIndex + 1 ); 
    float fBlendBetweenCascadesAmount = 1.0f;
    float fCurrentPixelsBlendBandLocation = 1.0f;
    CalculateBlendAmountForInterval ( iCurrentCascadeIndex, fCurrentPixelDepth, 
		fCurrentPixelsBlendBandLocation, fBlendBetweenCascadesAmount );
    
	// Adjust final world position of this fragment pixel by contour of parallax surface
	float4 finalwpos = float4(IN.WPos,1); //IN.vInterpos;
	
	// World out texture coordinate into specified shadow map
    ComputeCoordinatesTransform( iCurrentCascadeIndex, 
                                 finalwpos, 
                                 vShadowMapTextureCoord );    

	// work out how much shadow
	float fShadow;
    CalculatePCFPercentLit ( iCurrentCascadeIndex, vShadowMapTextureCoord, fRightTextDepthWeight, 
                             fUpTextDepthWeight, fShadow );
							 
	if( fCurrentPixelsBlendBandLocation < m_fCascadeBlendArea ) 
	{  
		// the current pixel is within the blend band.
		// Repeat text coord calculations for the next cascade. 
		// The next cascade index is used for blurring between maps.
		ComputeCoordinatesTransform( iNextCascadeIndex, finalwpos, 
									 vShadowMapTextureCoord_blend );  
   
		// the current pixel is within the blend band.
		CalculatePCFPercentLit ( iNextCascadeIndex, vShadowMapTextureCoord_blend, fRightTextDepthWeight_blend, 
								fUpTextDepthWeight_blend, fPercentLit_blend );
								
		// Blend the two calculated shadows by the blend amount.
		fShadow = lerp( fPercentLit_blend, fShadow, fBlendBetweenCascadesAmount ); 
	}

	// compound shadow with vegshadowmap (terrain shadow)
	float2 VegShadowMapCoord = IN.WPos.xz/(51200.0f);
	fShadow = max ( fShadow, tex2D(VegMapSampler,float2(VegShadowMapCoord.x,VegShadowMapCoord.y)).g );

	// finally modulate shadow with strength
	fShadow = fShadow * ShadowStrength;
   	
    //Main lighting equation  
    float4 lighting = lit((dot(Ln,Nb)),dot(Hn,Nb),24); //standard blinn (half-lambert makes skin look too waxy) 
    
    //bidirectional lighting helps dark side from looking too flat      
    float3 Hn2 = normalize(Vn + -Ln);
    float4 bilighting = lit((dot(-Ln,Nb)),dot(Hn2,Nb),24)*.6;    
    
	// dynamic lighting
	float fBit = max ( 0, dot ( Nb, normalize(SpotFlashPos.xyz-IN.WPos.xyz) ) * SpotFlashPos.w );
    float4 spotflashlighting = float4(fBit*SpotFlashColor.x*0.0029,fBit*SpotFlashColor.y*0.0029,fBit*SpotFlashColor.z*0.0029,1);
    float4 dynamiclighting = CalcLighting (Nb,IN.WPos.xyz,Vn,diffusemap,specmap) + spotflashlighting;  

	float4 ambCol = AmbiColor * AmbiColorOverride;
    float4 ambContrib = diffusemap * (AmbiColor) * (AmbiColorOverride*4.0);

	SurfColor = SurfColor * GlobalSurfaceIntensity * 4.0;
    float4 diffContrib = (diffusemap * lighting.y * SurfColor)  + (bilighting.y*diffusemap*SurfColor);
    float4 cubeContrib = cubemap * specmap.w*2 * ((ambCol*3) + SurfColor );
    float4 specContrib = 7 * specmap * lighting.z * SurfColor * GlobalSpecular;
    float4 illumContrib = float4(illummap.xyz,1); 
    
	// eliminate specular when in shadow
	specContrib = specContrib * (1.0f-fShadow);

	// final combination
    float4 result = float4(diffContrib + specContrib + ambContrib + cubeContrib + dynamiclighting + illumContrib);
    
	//apply shadow mapping to final render
	result = result * (1.0f-(fShadow*0.65f));
	
    //calculate hud pixel-fog
    float4 cameraPos = mul(float4(IN.WPos.xyz,1), View);
    float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
    
    //Mix in HUD Fog with final color (not using WaterFog - wouldn't apply to weapons anyway);
    float4 hudfogresult = lerp(result,pow(HudFogColor,2.2),hudfogfactor); //need to convert HudFogColor to gamma space
        
    finalcolor = float4(hudfogresult.rgb, diffusemap.w);
	
	return finalcolor;
}

float4 mainPS_lowest(vertexOutput IN) : COLOR
{
	// clip
	clip(IN.clip);
	
	// light
    float4 normalmap = tex2D(NormalMapSampler,IN.TexCoord.xy); //sample normal map
    normalmap.xyz = normalmap.xyz * 2 -1;  //expand normal map
    float3 Ln = normalize(IN.LightVec);    
    float3 Nn = (IN.WorldNormal);
    float3 Tn = (IN.WorldTangent);
    float3 Bn = (IN.WorldBinormal);
    float3 Nb = (normalmap.z * Nn) + (1.0 * (normalmap.x * Tn + normalmap.y * Bn));
    Nb = normalize(Nb);
    float3 Vn = normalize(IN.WorldEyeVec);
    float3 Hn = normalize(Vn + Ln);
	
	// paint
    float4 finalcolor;
    float4 diffusemap = tex2D(DiffuseMapSampler,IN.TexCoord.xy);
    float4 specmap = tex2D(SpecularMapSampler,IN.TexCoord.xy);    
    float4 illummap = tex2D(IlluminationMapSampler,IN.TexCoord.xy);    

	// extra effects
    float3 reflectvect = normalize(reflect(-Vn,Nb));
    float4 cubemap = texCUBElod(CubeMapSampler,float4(reflectvect,(diffusemap.a*3)));
    
	// Adjust final world position of this fragment pixel by contour of parallax surface
	float4 finalwpos = float4(IN.WPos,1);
	
	// cheap dynamic terrain floor shadow texture read
	float fShadow = float4(tex2D(DynTerShaSampler,float2(IN.vegshadowuv.x,IN.vegshadowuv.y)).xyz,1) * ShadowStrength;
	
    //Main lighting equation  
    float4 lighting = lit((dot(Ln,Nb)),dot(Hn,Nb),24); //standard blinn (half-lambert makes skin look too waxy) 
    
    //bidirectional lighting helps dark side from looking too flat      
    float3 Hn2 = normalize(Vn + -Ln);
    float4 bilighting = lit((dot(-Ln,Nb)),dot(Hn2,Nb),24)*.6;    

	// dynamic lighting
	float fBit = max ( 0, dot ( Nb, normalize(SpotFlashPos.xyz-IN.WPos.xyz) ) * SpotFlashPos.w );
	float4 spotflashlighting = float4(fBit*SpotFlashColor.x*0.0029,fBit*SpotFlashColor.y*0.0029,fBit*SpotFlashColor.z*0.0029,1);
	float4 dynamiclighting = CalcLighting (Nb,IN.WPos.xyz,Vn,diffusemap,specmap) + spotflashlighting;  
	
	float4 ambCol = AmbiColor * AmbiColorOverride;
    float4 ambContrib = diffusemap * (AmbiColor) * (AmbiColorOverride*4.0);

	SurfColor = SurfColor * GlobalSurfaceIntensity * 4.0;
    float4 diffContrib = (diffusemap * lighting.y * SurfColor)  + (bilighting.y*diffusemap*SurfColor);
    float4 cubeContrib = cubemap * specmap.w*2 * ((ambCol*3) + SurfColor );
    float4 specContrib = 7 * specmap * lighting.z * SurfColor * GlobalSpecular;
    float4 illumContrib = float4(illummap.xyz,1); 
 
	// eliminate specular when in shadow
	specContrib = specContrib * (1.0f-fShadow);

	// final combination
    float4 result = float4(diffContrib + specContrib + ambContrib + cubeContrib + dynamiclighting + illumContrib);
    
	//apply shadow mapping to final render
	result = result * (1.0f-(fShadow*0.65f));
	
    //calculate hud pixel-fog
    float4 cameraPos = mul(float4(IN.WPos.xyz,1), View);
    float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
    
    //Mix in HUD Fog with final color (not using WaterFog - wouldn't apply to weapons anyway);
    float4 hudfogresult = lerp(result,pow(HudFogColor,2.2),hudfogfactor); //need to convert HudFogColor to gamma space
        
    finalcolor = float4(hudfogresult.rgb, diffusemap.w);
	
	return finalcolor;
}

technique Highest
{
	pass one
	{		
		VertexShader = compile vs_3_0 mainVS_highest();
		PixelShader = compile ps_3_0 mainPS_highest();
		ZEnable = true;
		SrcBlend = srcAlpha;
		DestBlend = invSrcAlpha;
		SrgbWriteEnable = true;
		AlphaBlendEnable = true;
		AlphaTestEnable = false;
		ZWriteEnable = true;
		CullMode = none;
	}
}

technique Lowest
{
	pass one
	{		
		VertexShader = compile vs_3_0 mainVS_highest();
		PixelShader = compile ps_3_0 mainPS_lowest();
		ZEnable = true;
		SrcBlend = srcAlpha;
		DestBlend = invSrcAlpha;
		SrgbWriteEnable = true;
		AlphaBlendEnable = true;
		AlphaTestEnable = false;
		ZWriteEnable = true;
		CullMode = none;
	}
}
