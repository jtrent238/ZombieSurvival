string Description = "Sky Shader";

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

/***************TEXTURES AND SAMPLERS***************************************************/

texture DiffuseMap : DiffuseMap
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

/************* DATA STRUCTS **************/

struct appdata 
{
    float4 Position	: POSITION;
    float2 UV		: TEXCOORD0;
    float4 Normal	: NORMAL;
};

struct vertexOutput
{
    float4 Position     : POSITION;
    float2 TexCoord     : TEXCOORD0;
    float clip          : TEXCOORD1;
	float4 WPos			: TEXCOORD2;
};

/*******Main Vertex Shader***************************/

vertexOutput mainVS(appdata IN)   
{
    vertexOutput OUT;
    float4 worldSpacePos = mul(IN.Position, World);
    OUT.Position = mul(IN.Position, WorldViewProjection);
    OUT.TexCoord  = IN.UV; 
    OUT.clip = dot(worldSpacePos, clipPlane);                                                                      
	OUT.WPos = IN.Position;//worldSpacePos;
    return OUT;
}

/****************Framgent Shader*****************/

float4 mainPS(vertexOutput IN) : COLOR
{
    float4 result;
    result = float4(tex2D(DiffuseSampler,IN.TexCoord.xy).xyz,alphaoverride);
	float distantfogfactor = 1.0 - (HudFogDist.y / 50000.0f);
    float hudfogfactor = (1 - saturate(IN.WPos.y / 1.5)) * distantfogfactor;
	result = lerp(result,float4(HudFogColor.xyz,0),hudfogfactor*HudFogColor.w);
    return float4(result.xyz,1);
}

/****** technique *****************************************************************************/

technique dx9textured
{
    pass P0
    {
        // shaders
        VertexShader = compile vs_3_0 mainVS();
        PixelShader  = compile ps_3_0 mainPS();
        CullMode = none;
        AlphaBlendEnable = TRUE;
        AlphaTestEnable = false;
    }
}
