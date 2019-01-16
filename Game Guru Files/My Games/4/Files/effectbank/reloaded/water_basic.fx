  //-----------------
  // Reflective/Refractive  
  //-----------------
  // by Evolved
  // http://www.vector3r.com/
  //-----------------

  //-----------------
  // un-tweaks
  //-----------------
   matrix WorldVP:WorldViewProjection; 
   matrix World:World;   
   matrix ViewInv:ViewInverse; 
   float4x4 View : View;
   float time : Time ;
   float4x4 RefrMat = {0.5,0,0,0.5,0,-0.5,0,0.5,0,0,0.5,0.5,0,0,0,1};
   float4x4 ReflMat = {0.5,0,0,0.5,0,0.5,0,0.5,0,0,0.5,0.5,0,0,0,1};

  //-----------------
  // tweaks
  //-----------------
   float2 WaterScale = { 10.0f , 10.0f};
   float WaterBump = 0.02f;
   float FresnelBias = 0.1f;
   float FresnelScale = 5.0f;//7.5f;
   float2 Speed1 = { -0.015, 0.0 };
   float2 Speed2 = { 0.014, -0.014 };
   float2 Speed3 = { -0.007, 0.007 };
   float4 WaterTint = { 0.7f, 0.7f, 0.7f, 1.0f };
   
  //HUD Fog Color
   float4 HudFogColor : Diffuse
   <   string UIName =  "Hud Fog Color";    
   > = {0.0f, 1.0f, 0.0f, 0.5f};

  //HUD Fog Distances (near,far,0,0)
   float4 HudFogDist : Diffuse
   <   string UIName =  "Hud Fog Dist";    
   > = {0.0f, 1.0f, 0.0f, 0.0f};

  //-----------------
  // Texture
  //-----------------
   texture WaterbumpTX <string Name=""; >; 
   sampler2D Waterbump=sampler_state 
     {
	Texture = <WaterbumpTX>;
	MagFilter = Linear;	
	MinFilter = Point;
	MipFilter = Point;
     };
   texture WaterRefractTX <string Name=""; >;	
   sampler2D WaterRefract=sampler_state
     {
	Texture = <WaterRefractTX>;
   	ADDRESSU = CLAMP;
   	ADDRESSV = CLAMP;
   	ADDRESSW = CLAMP;
     };
   texture WaterReflectTX <string Name=""; >;	
   sampler2D WaterReflect=sampler_state
     {
	Texture = <WaterReflectTX>;
   	ADDRESSU = CLAMP;
   	ADDRESSV = CLAMP;
   	ADDRESSW = CLAMP;
     };
   texture WaterMaskTX <string Name=""; >;	
   sampler2D WaterMask=sampler_state
     {
	Texture = <WaterMaskTX>;
	MagFilter = Linear;	
	MinFilter = Point;
	MipFilter = Point;
   	ADDRESSU = CLAMP;
   	ADDRESSV = CLAMP;
   	ADDRESSW = CLAMP;
     };

  //-----------------
  // structs 
  //-----------------
   struct input
     {
 	float4 Pos:POSITION; 
 	float2 UV:TEXCOORD; 
 	float3 Normal:NORMAL; 
 	float3 Tangent:TANGENT;
 	float3 Binormal:BINORMAL; 
     };
   struct output
   {
 	float4 OPos:POSITION; 
 	float2 Tex0:TEXCOORD0; 
 	float2 Tex1:TEXCOORD1; 
 	float2 Tex2:TEXCOORD2; 
	float2 Tex3:TEXCOORD3; 
	float3 ViewVec:TEXCOORD4;  
 	float4 RefrProj:TEXCOORD6;
  	float4 ReflProj:TEXCOORD7;
	float4 WPos:TEXCOORD8;
   };

  //-----------------
  // vertex shader
  //-----------------
   output VS(input IN) 
   {
 	output OUT;
	OUT.OPos = mul(IN.Pos,WorldVP); 
	OUT.Tex0 = IN.UV;
	OUT.Tex1 = IN.UV*WaterScale/0.8+(time*Speed1);
	OUT.Tex2 = IN.UV*WaterScale+(time*Speed2);
	OUT.Tex3 = IN.UV*WaterScale*0.8+(time*Speed3);
	float4 WPos= mul(IN.Pos,World);  
	float3 VP = ViewInv[3].xyz-WPos.xyz; 
 	OUT.ViewVec = -VP/(FresnelScale*VP.y); 
  	OUT.RefrProj = mul(RefrMat,OUT.OPos);
  	OUT.ReflProj = mul(ReflMat,OUT.OPos);
 	OUT.WPos = WPos; 
	return OUT;
   }

// pixel shaders

float4 PS_Fresnel_Reflect(output IN) : COLOR 
{
	float Mask=tex2D(WaterMask,IN.Tex0).x;
	float RippleFactor=tex2D(WaterMask,IN.Tex0).y;
	float4 Distort = (tex2D(Waterbump, IN.Tex1)*2-1)*0.3;
		   Distort = Distort+(Distort,tex2D(Waterbump, IN.Tex2)*2-1)*0.3;
		   Distort = Distort+(Distort,tex2D(Waterbump, IN.Tex3)*2-1)*0.3;
	float  Fresnel = 1-saturate(dot(IN.ViewVec,IN.ViewVec));
		   Fresnel = FresnelBias+Fresnel*(1-FresnelBias);
		   Fresnel = Fresnel * 0.4f;
	Distort = (Distort*(IN.RefrProj.z*WaterBump)) * RippleFactor;
	float3 Reflection = tex2Dproj(WaterReflect,IN.ReflProj+Distort);
	float3 WaterColor = (Reflection*WaterTint);
	
	// SK: Adding in fog
    float4 cameraPos = mul(IN.WPos, View);
    float hudfogfactor = saturate((cameraPos.z - HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
	float fMaskValue = 0.1f+((Mask*(1.0f-Fresnel))*0.9f);
    float4 result = float4(WaterColor,fMaskValue);
	float finalFactor = hudfogfactor*HudFogColor.w;
    float4 hudfogresult = lerp(result,float4(HudFogColor.xyz,0),finalFactor);
	return float4(hudfogresult.xyz,fMaskValue+finalFactor);
} 

float4 PS_Fresnel_NoReflect(output IN) : COLOR 
{
	float Mask=tex2D(WaterMask,IN.Tex0).r;
	float RippleFactor=tex2D(WaterMask,IN.Tex0).y;
	float  Fresnel = 1-saturate(dot(IN.ViewVec,IN.ViewVec));
		   Fresnel = FresnelBias+Fresnel*(1-FresnelBias);
	float3 WaterColor = float3(34.0/256.0,54.0/256.0,107.0/256.0);
	
	// SK: Adding in fog
    float4 cameraPos = mul(IN.WPos, View);
    float hudfogfactor = saturate((cameraPos.z- HudFogDist.x)/(HudFogDist.y - HudFogDist.x));
	float fMaskValue = 0.1f+((Mask*(1.0f-Fresnel))*0.9f);
    float4 result = float4(WaterColor,fMaskValue);
	float finalFactor = hudfogfactor*HudFogColor.w;
    float3 hudfogresult = lerp(result,float4(HudFogColor.xyz,0),finalFactor);
	return float4(hudfogresult,fMaskValue+finalFactor);
} 

// techniques   
technique UseReflection
{
	pass p1
	{		
		VertexShader = compile vs_3_0 VS(); 
		PixelShader = compile ps_3_0 PS_Fresnel_Reflect(); 		
	}
}
technique NoReflection
{
	pass p1
	{		
		VertexShader = compile vs_3_0 VS(); 
		PixelShader = compile ps_3_0 PS_Fresnel_NoReflect(); 		
	}
}
