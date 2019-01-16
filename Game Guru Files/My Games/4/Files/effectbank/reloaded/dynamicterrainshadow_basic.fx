string Description = "Dynamic Terrain Shadow Texture Camera Shader";

// shadow mapping constants
matrix          m_mShadow;
float4          m_vCascadeOffset[8];
float4          m_vCascadeScale[8];
int             m_nCascadeLevels;
float           m_fMinBorderPadding;     
float           m_fMaxBorderPadding;
float           m_fShadowBiasFromGUI; 
float           m_fCascadeBlendArea;
float           m_fTexelSize; 
float           m_fCascadeFrustumsEyeSpaceDepths[8];
float3          m_vLightDir;

// constants
float4x4 WorldViewProjection : WorldViewProjection;
float2 ViewSize : ViewSize;
float4x4 World : World;
float4x4 View : View;

texture frame : RENDERCOLORTARGET
< 
	string ResourceName = "";
	float2 ViewportRatio = {1.0,1.0 };
	
>;
texture DepthMapTX4 : DiffuseMap
<
    string Name = "D.tga";
    string type = "2D";
>;

sampler2D frameSamp = sampler_state 
{
    Texture = < frame >;
    MinFilter = Point; MagFilter = Point; MipFilter = Point;
    AddressU = Clamp; AddressV = Clamp;
};
sampler2D DepthMap4 = sampler_state
{
	Texture = <DepthMapTX4>;	
    MinFilter = LINEAR; MagFilter = LINEAR;
    AddressU = Clamp; AddressV = Clamp;
};

struct input 
{
	float4 pos : POSITION;
	float2 uv : TEXCOORD0;
};
 
struct output 
{
	float4 pos: POSITION;
	float4 WPos: TEXCOORD0;
};

output VS( input IN ) 
{
	output OUT;
	
	float4 vert = IN.pos;	
	float4 temppos = mul(vert, World);
	temppos.z = 51200.0f - temppos.z;
	OUT.WPos = temppos;
	OUT.pos = mul( vert, WorldViewProjection );
		
	return OUT;	
}

/****** helper functions for shadow mapping*****/

void ComputeCoordinatesTransform( in float4 InterpolatedPosition, in out float4 vShadowTexCoord ) 
{
	float4 vLightDot = mul ( InterpolatedPosition, m_mShadow );
    vLightDot *= m_vCascadeScale[3];
    vLightDot += m_vCascadeOffset[3];
	vShadowTexCoord.xyz = vLightDot.xyz;
} 

float4 PSPresent( output IN, uniform sampler2D srcTex ) : COLOR
{
	// account for terrain height at XZ coordinates
	float4 HeightCol = tex2D(srcTex,float2(IN.WPos.x/51200.0f,IN.WPos.z/51200.0f));
	float fThisHeight = (((HeightCol.z*255))+((HeightCol.y*255)*256)+((HeightCol.x*255)*65536))/100.0f;
	float4 actualPos = float4(IN.WPos.x,IN.WPos.y+fThisHeight,IN.WPos.z,IN.WPos.w);	
	float4 color;
	float4 vShadowMapTextureCoord = 0.0f;
	ComputeCoordinatesTransform( actualPos, vShadowMapTextureCoord );    
	if ( vShadowMapTextureCoord.x>=0 && vShadowMapTextureCoord.x<=1.0 && vShadowMapTextureCoord.y>=0.0f && vShadowMapTextureCoord.y<=1.0 )
	{
		// commit this shadow pixel to the dynamic shadow long-term-storage
		float fShadow = vShadowMapTextureCoord.z > tex2D(DepthMap4,float2(vShadowMapTextureCoord.x,vShadowMapTextureCoord.y)).x ? 1.0f : 0.0f;
		color = float4(fShadow,fShadow,fShadow,1);
	}
	else
	{
		// reject pixel
		clip(-1);
		color = float4(0,0,0,0);
	}	
    return color;
}

float4 PSPresent_superflat( output IN, uniform sampler2D srcTex ) : COLOR
{
	// account for terrain height at XZ coordinates
	float4 HeightCol = tex2D(srcTex,float2(IN.WPos.x/51200.0f,IN.WPos.z/51200.0f));
	float fThisHeight = 1000.0f;
	float4 actualPos = float4(IN.WPos.x,IN.WPos.y+fThisHeight,IN.WPos.z,IN.WPos.w);	
	float4 color;
	float4 vShadowMapTextureCoord = 0.0f;
	ComputeCoordinatesTransform( actualPos, vShadowMapTextureCoord );    
	if ( vShadowMapTextureCoord.x>=0 && vShadowMapTextureCoord.x<=1.0 && vShadowMapTextureCoord.y>=0.0f && vShadowMapTextureCoord.y<=1.0 )
	{
		// commit this shadow pixel to the dynamic shadow mong-term-storage
		float fShadow = vShadowMapTextureCoord.z > tex2D(DepthMap4,float2(vShadowMapTextureCoord.x,vShadowMapTextureCoord.y)).x ? 1.0f : 0.0f;
		color = float4(fShadow,fShadow,fShadow,1);
	}
	else
	{
		// reject pixel
		clip(-1);
		color = float4(0,0,0,0);
	}	
    return color;
}

technique Terrain
<
	string RenderColorTarget = "frame";
>
{
	pass Present
	<
		string RenderColorTarget = "";
	>
	{
		VertexShader = compile vs_3_0 VS();
		PixelShader = compile ps_3_0 PSPresent( frameSamp );
	}
}

technique SuperFlat
<
	string RenderColorTarget = "frame";
>
{
	pass Present
	<
		string RenderColorTarget = "";
	>
	{
		VertexShader = compile vs_3_0 VS();
		PixelShader = compile ps_3_0 PSPresent_superflat( frameSamp );
	}
}
