xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.15
// Time: Mon Aug 10 11:37:35 2009

// Start of Templates

template VertexDuplicationIndices {
 <b8d65549-d7c9-4995-89cf-53a9a8b031e3>
 DWORD nIndices;
 DWORD nOriginalVertices;
 array DWORD indices[nIndices];
}

template FVFData {
 <b6e70a0e-8ef9-4e83-94ad-ecc8b0c04897>
 DWORD dwFVF;
 DWORD nDWords;
 array DWORD data[nDWords];
}

template Header {
 <3D82AB43-62DA-11cf-AB39-0020AF71E433>
 WORD major;
 WORD minor;
 DWORD flags;
}

template Vector {
 <3D82AB5E-62DA-11cf-AB39-0020AF71E433>
 FLOAT x;
 FLOAT y;
 FLOAT z;
}

template Coords2d {
 <F6F23F44-7686-11cf-8F52-0040333594A3>
 FLOAT u;
 FLOAT v;
}

template Matrix4x4 {
 <F6F23F45-7686-11cf-8F52-0040333594A3>
 array FLOAT matrix[16];
}

template ColorRGBA {
 <35FF44E0-6C7C-11cf-8F52-0040333594A3>
 FLOAT red;
 FLOAT green;
 FLOAT blue;
 FLOAT alpha;
}

template ColorRGB {
 <D3E16E81-7835-11cf-8F52-0040333594A3>
 FLOAT red;
 FLOAT green;
 FLOAT blue;
}

template IndexedColor {
 <1630B820-7842-11cf-8F52-0040333594A3>
 DWORD index;
 ColorRGBA indexColor;
}

template Material {
 <3D82AB4D-62DA-11cf-AB39-0020AF71E433>
 ColorRGBA faceColor;
 FLOAT power;
 ColorRGB specularColor;
 ColorRGB emissiveColor;
 [...]
}

template TextureFilename {
 <A42790E1-7810-11cf-8F52-0040333594A3>
 STRING filename;
}

template MeshFace {
 <3D82AB5F-62DA-11cf-AB39-0020AF71E433>
 DWORD nFaceVertexIndices;
 array DWORD faceVertexIndices[nFaceVertexIndices];
}

template MeshTextureCoords {
 <F6F23F40-7686-11cf-8F52-0040333594A3>
 DWORD nTextureCoords;
 array Coords2d textureCoords[nTextureCoords];
}

template MeshMaterialList {
 <F6F23F42-7686-11cf-8F52-0040333594A3>
 DWORD nMaterials;
 DWORD nFaceIndexes;
 array DWORD faceIndexes[nFaceIndexes];
 [Material]
}

template MeshNormals {
 <F6F23F43-7686-11cf-8F52-0040333594A3>
 DWORD nNormals;
 array Vector normals[nNormals];
 DWORD nFaceNormals;
 array MeshFace faceNormals[nFaceNormals];
}

template MeshVertexColors {
 <1630B821-7842-11cf-8F52-0040333594A3>
 DWORD nVertexColors;
 array IndexedColor vertexColors[nVertexColors];
}

template Mesh {
 <3D82AB44-62DA-11cf-AB39-0020AF71E433>
 DWORD nVertices;
 array Vector vertices[nVertices];
 DWORD nFaces;
 array MeshFace faces[nFaces];
 [...]
}

template FrameTransformMatrix {
 <F6F23F41-7686-11cf-8F52-0040333594A3>
 Matrix4x4 frameMatrix;
}

template Frame {
 <3D82AB46-62DA-11cf-AB39-0020AF71E433>
 [...]
}

template FloatKeys {
 <10DD46A9-775B-11cf-8F52-0040333594A3>
 DWORD nValues;
 array FLOAT values[nValues];
}

template TimedFloatKeys {
 <F406B180-7B3B-11cf-8F52-0040333594A3>
 DWORD time;
 FloatKeys tfkeys;
}

template AnimationKey {
 <10DD46A8-775B-11cf-8F52-0040333594A3>
 DWORD keyType;
 DWORD nKeys;
 array TimedFloatKeys keys[nKeys];
}

template AnimationOptions {
 <E2BF56C0-840F-11cf-8F52-0040333594A3>
 DWORD openclosed;
 DWORD positionquality;
}

template Animation {
 <3D82AB4F-62DA-11cf-AB39-0020AF71E433>
 [...]
}

template AnimationSet {
 <3D82AB50-62DA-11cf-AB39-0020AF71E433>
 [Animation]
}

template XSkinMeshHeader {
 <3CF169CE-FF7C-44ab-93C0-F78F62D172E2>
 WORD nMaxSkinWeightsPerVertex;
 WORD nMaxSkinWeightsPerFace;
 WORD nBones;
}

template SkinWeights {
 <6F0D123B-BAD2-4167-A0D0-80224F25FABB>
 STRING transformNodeName;
 DWORD nWeights;
 array DWORD vertexIndices[nWeights];
 array FLOAT weights[nWeights];
 Matrix4x4 matrixOffset;
}

template AnimTicksPerSecond {
 <9E415A43-7BA6-4a73-8743-B73D47E88476>
 DWORD AnimTicksPerSecond;
}

AnimTicksPerSecond {
 4800;
}

// Start of Frames

Frame Body {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh staticMesh {
    60;
    1.463000; 0.136050; -4.420875;,
    -1.463000; 0.136050; -4.420875;,
    1.463000; 0.315460; -4.421135;,
    -1.463000; 0.315460; -4.421135;,
    -2.135400; 0.137450; 4.421135;,
    2.135400; 0.137450; 4.421135;,
    -2.135400; 0.456350; 4.420675;,
    2.135400; 0.456350; 4.420675;,
    -3.687800; 0.452210; -4.176135;,
    3.687800; 0.452210; -4.176135;,
    -3.244600; 0.424810; -4.314695;,
    3.244600; 0.424810; -4.314695;,
    -3.687800; 0.000000; -4.175485;,
    -3.244600; 0.027000; -4.314115;,
    3.687800; 0.000000; -4.175485;,
    -3.687800; 0.000000; -4.175485;,
    3.244600; 0.027000; -4.314115;,
    -3.244600; 0.027000; -4.314115;,
    3.687800; 0.000000; -4.175485;,
    3.244600; 0.027000; -4.314115;,
    1.463000; 0.136050; -4.420875;,
    -1.463000; 0.136050; -4.420875;,
    3.687800; 0.571510; 3.902405;,
    -3.687800; 0.571510; 3.902405;,
    3.075800; 0.526260; 4.216375;,
    -3.075800; 0.526260; 4.216375;,
    3.687800; 0.020710; 3.903195;,
    3.075800; 0.066860; 4.217035;,
    -3.687800; 0.020710; 3.903195;,
    3.687800; 0.020710; 3.903195;,
    -3.075800; 0.066960; 4.217035;,
    3.075800; 0.066860; 4.217035;,
    -3.687800; 0.020710; 3.903195;,
    -3.075800; 0.066960; 4.217035;,
    -2.135400; 0.137450; 4.421135;,
    2.135400; 0.137450; 4.421135;,
    -2.772100; 0.561980; -2.729685;,
    2.782700; 0.561980; -2.729685;,
    2.782700; 0.455480; -2.729535;,
    -2.772100; 0.455480; -2.729535;,
    2.782700; 0.457150; -1.564635;,
    -2.772100; 0.457150; -1.564635;,
    -2.772100; 0.563650; -1.564785;,
    2.782700; 0.563650; -1.564785;,
    3.687800; 0.018160; 2.130095;,
    3.687800; 0.568960; 2.129305;,
    -3.687800; 0.018160; 2.130095;,
    -3.687800; 0.568960; 2.129305;,
    3.687800; 0.018160; 2.130095;,
    -3.687800; 0.018160; 2.130095;,
    -3.394900; 0.626990; 2.153625;,
    3.398200; 0.626990; 2.153025;,
    3.687800; 0.014800; -0.213898;,
    3.687800; 0.565590; -0.214689;,
    -3.687800; 0.014800; -0.213898;,
    -3.687800; 0.565590; -0.214689;,
    3.687800; 0.014800; -0.213898;,
    -3.687800; 0.014800; -0.213898;,
    -3.007700; 0.645780; -0.158003;,
    3.015400; 0.645670; -0.159303;;
    84;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;5, 7, 6;,
    3;8, 9, 10;,
    3;9, 11, 10;,
    3;12, 8, 13;,
    3;8, 10, 13;,
    3;14, 15, 16;,
    3;15, 17, 16;,
    3;9, 18, 11;,
    3;18, 19, 11;,
    3;10, 11, 3;,
    3;11, 2, 3;,
    3;13, 10, 1;,
    3;10, 3, 1;,
    3;16, 17, 20;,
    3;17, 21, 20;,
    3;11, 19, 2;,
    3;19, 0, 2;,
    3;22, 23, 24;,
    3;23, 25, 24;,
    3;26, 22, 27;,
    3;22, 24, 27;,
    3;28, 29, 30;,
    3;29, 31, 30;,
    3;23, 32, 25;,
    3;32, 33, 25;,
    3;24, 25, 7;,
    3;25, 6, 7;,
    3;27, 24, 5;,
    3;24, 7, 5;,
    3;30, 31, 34;,
    3;31, 35, 34;,
    3;25, 33, 6;,
    3;33, 4, 6;,
    3;36, 37, 8;,
    3;37, 9, 8;,
    3;38, 39, 40;,
    3;39, 41, 40;,
    3;39, 36, 41;,
    3;36, 42, 41;,
    3;38, 37, 39;,
    3;37, 36, 39;,
    3;41, 42, 40;,
    3;42, 43, 40;,
    3;40, 43, 38;,
    3;43, 37, 38;,
    3;44, 45, 26;,
    3;45, 22, 26;,
    3;46, 32, 47;,
    3;32, 23, 47;,
    3;29, 28, 48;,
    3;28, 49, 48;,
    3;47, 23, 50;,
    3;51, 50, 22;,
    3;50, 23, 22;,
    3;51, 22, 45;,
    3;52, 18, 53;,
    3;18, 9, 53;,
    3;52, 53, 44;,
    3;53, 45, 44;,
    3;46, 47, 54;,
    3;47, 55, 54;,
    3;54, 55, 12;,
    3;55, 8, 12;,
    3;48, 49, 56;,
    3;49, 57, 56;,
    3;56, 57, 14;,
    3;57, 15, 14;,
    3;42, 36, 58;,
    3;36, 8, 58;,
    3;58, 8, 55;,
    3;58, 55, 50;,
    3;55, 47, 50;,
    3;43, 42, 59;,
    3;42, 58, 59;,
    3;59, 58, 51;,
    3;58, 50, 51;,
    3;37, 43, 9;,
    3;43, 59, 9;,
    3;9, 59, 53;,
    3;53, 59, 45;,
    3;59, 51, 45;;

   MeshNormals {
    60;
    0.021309; -0.250623; -0.967850;,
    -0.021309; -0.250623; -0.967850;,
    0.021309; 0.247818; -0.968572;,
    -0.021309; 0.247818; -0.968572;,
    -0.084944; -0.377159; 0.922245;,
    0.084931; -0.377160; 0.922246;,
    -0.084946; 0.379894; 0.921122;,
    0.084946; 0.379893; 0.921122;,
    -0.403128; 0.845953; -0.349073;,
    0.293605; 0.881560; -0.369658;,
    -0.107348; 0.502185; -0.858072;,
    0.107343; 0.502185; -0.858072;,
    -0.493539; -0.753694; -0.434011;,
    -0.107347; -0.504658; -0.856619;,
    0.493534; -0.753695; -0.434014;,
    -0.493539; -0.753694; -0.434011;,
    0.107342; -0.504658; -0.856620;,
    -0.107347; -0.504658; -0.856619;,
    0.493534; -0.753695; -0.434014;,
    0.107342; -0.504658; -0.856620;,
    0.021309; -0.250623; -0.967850;,
    -0.021309; -0.250623; -0.967850;,
    0.463987; 0.834089; 0.298347;,
    -0.463470; 0.834358; 0.298400;,
    0.215224; 0.624056; 0.751155;,
    -0.215225; 0.624056; 0.751154;,
    0.544722; -0.743590; 0.387752;,
    0.215207; -0.621827; 0.753005;,
    -0.544722; -0.743590; 0.387752;,
    0.544722; -0.743590; 0.387752;,
    -0.215218; -0.621826; 0.753003;,
    0.215207; -0.621827; 0.753005;,
    -0.544722; -0.743590; 0.387752;,
    -0.215218; -0.621826; 0.753003;,
    -0.084944; -0.377159; 0.922245;,
    0.084931; -0.377160; 0.922246;,
    0.373263; 0.841748; 0.390045;,
    -0.524305; 0.769250; 0.365185;,
    -0.577355; 0.578168; 0.576527;,
    0.577355; 0.578168; 0.576527;,
    -0.577346; 0.576531; -0.578173;,
    0.577346; 0.576531; -0.578173;,
    0.364742; 0.821850; -0.437637;,
    -0.513774; 0.753159; -0.410837;,
    0.707107; -0.707106; 0.001015;,
    0.760808; 0.648963; -0.004213;,
    -0.707107; -0.707106; 0.001015;,
    -0.760385; 0.649472; -0.000934;,
    0.707107; -0.707106; 0.001015;,
    -0.707107; -0.707106; 0.001015;,
    -0.078073; 0.996904; 0.009283;,
    0.078714; 0.996874; 0.006782;,
    0.707107; -0.707104; 0.001828;,
    0.678809; 0.734299; -0.004832;,
    -0.707107; -0.707104; 0.001828;,
    -0.747293; 0.664494; -0.000954;,
    0.707107; -0.707104; 0.001828;,
    -0.707107; -0.707104; 0.001828;,
    -0.058562; 0.998195; -0.013278;,
    -0.052699; 0.998483; -0.015954;;
    84;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;5, 7, 6;,
    3;8, 9, 10;,
    3;9, 11, 10;,
    3;12, 8, 13;,
    3;8, 10, 13;,
    3;14, 15, 16;,
    3;15, 17, 16;,
    3;9, 18, 11;,
    3;18, 19, 11;,
    3;10, 11, 3;,
    3;11, 2, 3;,
    3;13, 10, 1;,
    3;10, 3, 1;,
    3;16, 17, 20;,
    3;17, 21, 20;,
    3;11, 19, 2;,
    3;19, 0, 2;,
    3;22, 23, 24;,
    3;23, 25, 24;,
    3;26, 22, 27;,
    3;22, 24, 27;,
    3;28, 29, 30;,
    3;29, 31, 30;,
    3;23, 32, 25;,
    3;32, 33, 25;,
    3;24, 25, 7;,
    3;25, 6, 7;,
    3;27, 24, 5;,
    3;24, 7, 5;,
    3;30, 31, 34;,
    3;31, 35, 34;,
    3;25, 33, 6;,
    3;33, 4, 6;,
    3;36, 37, 8;,
    3;37, 9, 8;,
    3;38, 39, 40;,
    3;39, 41, 40;,
    3;39, 36, 41;,
    3;36, 42, 41;,
    3;38, 37, 39;,
    3;37, 36, 39;,
    3;41, 42, 40;,
    3;42, 43, 40;,
    3;40, 43, 38;,
    3;43, 37, 38;,
    3;44, 45, 26;,
    3;45, 22, 26;,
    3;46, 32, 47;,
    3;32, 23, 47;,
    3;29, 28, 48;,
    3;28, 49, 48;,
    3;47, 23, 50;,
    3;51, 50, 22;,
    3;50, 23, 22;,
    3;51, 22, 45;,
    3;52, 18, 53;,
    3;18, 9, 53;,
    3;52, 53, 44;,
    3;53, 45, 44;,
    3;46, 47, 54;,
    3;47, 55, 54;,
    3;54, 55, 12;,
    3;55, 8, 12;,
    3;48, 49, 56;,
    3;49, 57, 56;,
    3;56, 57, 14;,
    3;57, 15, 14;,
    3;42, 36, 58;,
    3;36, 8, 58;,
    3;58, 8, 55;,
    3;58, 55, 50;,
    3;55, 47, 50;,
    3;43, 42, 59;,
    3;42, 58, 59;,
    3;59, 58, 51;,
    3;58, 50, 51;,
    3;37, 43, 9;,
    3;43, 59, 9;,
    3;9, 59, 53;,
    3;53, 59, 45;,
    3;59, 51, 45;;
   }

   MeshTextureCoords {
    60;
    0.238756; 0.016356;,
    0.111097; 0.016356;,
    0.240730; 0.010391;,
    0.109123; 0.010391;,
    0.081761; 0.402125;,
    0.268092; 0.402125;,
    0.078880; 0.408090;,
    0.270974; 0.408090;,
    0.009055; 0.021420;,
    0.340798; 0.021420;,
    0.028990; 0.015185;,
    0.320864; 0.015185;,
    0.014031; 0.027054;,
    0.033368; 0.021007;,
    0.558846; 0.540641;,
    0.227103; 0.540641;,
    0.538912; 0.534407;,
    0.247037; 0.534407;,
    0.335822; 0.027054;,
    0.316486; 0.021007;,
    0.458778; 0.529612;,
    0.327171; 0.529612;,
    0.340798; 0.384787;,
    0.009055; 0.384787;,
    0.313271; 0.398905;,
    0.036582; 0.398905;,
    0.335822; 0.379520;,
    0.309121; 0.393216;,
    0.227103; 0.904008;,
    0.558846; 0.904008;,
    0.254630; 0.918127;,
    0.531319; 0.918127;,
    0.014031; 0.379520;,
    0.040732; 0.393216;,
    0.296927; 0.927312;,
    0.489022; 0.927312;,
    0.050242; 0.086485;,
    0.300088; 0.086485;,
    0.300088; 0.086485;,
    0.050242; 0.086485;,
    0.300088; 0.138881;,
    0.050242; 0.138881;,
    0.050242; 0.138881;,
    0.300088; 0.138881;,
    0.335822; 0.302161;,
    0.340798; 0.305035;,
    0.014031; 0.302161;,
    0.009055; 0.305035;,
    0.558846; 0.824257;,
    0.227103; 0.824257;,
    0.022229; 0.306133;,
    0.327773; 0.306106;,
    0.335822; 0.199895;,
    0.340798; 0.199606;,
    0.014031; 0.199895;,
    0.009055; 0.199606;,
    0.558846; 0.718828;,
    0.227103; 0.718828;,
    0.039645; 0.202161;,
    0.310555; 0.202103;;
   }

   MeshVertexColors {
    60;
    0; 1.000000; 1.000000; 1.000000; 1.000000;,
    1; 1.000000; 1.000000; 1.000000; 1.000000;,
    2; 1.000000; 1.000000; 1.000000; 1.000000;,
    3; 1.000000; 1.000000; 1.000000; 1.000000;,
    4; 1.000000; 1.000000; 1.000000; 1.000000;,
    5; 1.000000; 1.000000; 1.000000; 1.000000;,
    6; 1.000000; 1.000000; 1.000000; 1.000000;,
    7; 1.000000; 1.000000; 1.000000; 1.000000;,
    8; 1.000000; 1.000000; 1.000000; 1.000000;,
    9; 1.000000; 1.000000; 1.000000; 1.000000;,
    10; 1.000000; 1.000000; 1.000000; 1.000000;,
    11; 1.000000; 1.000000; 1.000000; 1.000000;,
    12; 1.000000; 1.000000; 1.000000; 1.000000;,
    13; 1.000000; 1.000000; 1.000000; 1.000000;,
    14; 1.000000; 1.000000; 1.000000; 1.000000;,
    15; 1.000000; 1.000000; 1.000000; 1.000000;,
    16; 1.000000; 1.000000; 1.000000; 1.000000;,
    17; 1.000000; 1.000000; 1.000000; 1.000000;,
    18; 1.000000; 1.000000; 1.000000; 1.000000;,
    19; 1.000000; 1.000000; 1.000000; 1.000000;,
    20; 1.000000; 1.000000; 1.000000; 1.000000;,
    21; 1.000000; 1.000000; 1.000000; 1.000000;,
    22; 1.000000; 1.000000; 1.000000; 1.000000;,
    23; 1.000000; 1.000000; 1.000000; 1.000000;,
    24; 1.000000; 1.000000; 1.000000; 1.000000;,
    25; 1.000000; 1.000000; 1.000000; 1.000000;,
    26; 1.000000; 1.000000; 1.000000; 1.000000;,
    27; 1.000000; 1.000000; 1.000000; 1.000000;,
    28; 1.000000; 1.000000; 1.000000; 1.000000;,
    29; 1.000000; 1.000000; 1.000000; 1.000000;,
    30; 1.000000; 1.000000; 1.000000; 1.000000;,
    31; 1.000000; 1.000000; 1.000000; 1.000000;,
    32; 1.000000; 1.000000; 1.000000; 1.000000;,
    33; 1.000000; 1.000000; 1.000000; 1.000000;,
    34; 1.000000; 1.000000; 1.000000; 1.000000;,
    35; 1.000000; 1.000000; 1.000000; 1.000000;,
    36; 1.000000; 1.000000; 1.000000; 1.000000;,
    37; 1.000000; 1.000000; 1.000000; 1.000000;,
    38; 1.000000; 1.000000; 1.000000; 1.000000;,
    39; 1.000000; 1.000000; 1.000000; 1.000000;,
    40; 1.000000; 1.000000; 1.000000; 1.000000;,
    41; 1.000000; 1.000000; 1.000000; 1.000000;,
    42; 1.000000; 1.000000; 1.000000; 1.000000;,
    43; 1.000000; 1.000000; 1.000000; 1.000000;,
    44; 1.000000; 1.000000; 1.000000; 1.000000;,
    45; 1.000000; 1.000000; 1.000000; 1.000000;,
    46; 1.000000; 1.000000; 1.000000; 1.000000;,
    47; 1.000000; 1.000000; 1.000000; 1.000000;,
    48; 1.000000; 1.000000; 1.000000; 1.000000;,
    49; 1.000000; 1.000000; 1.000000; 1.000000;,
    50; 1.000000; 1.000000; 1.000000; 1.000000;,
    51; 1.000000; 1.000000; 1.000000; 1.000000;,
    52; 1.000000; 1.000000; 1.000000; 1.000000;,
    53; 1.000000; 1.000000; 1.000000; 1.000000;,
    54; 1.000000; 1.000000; 1.000000; 1.000000;,
    55; 1.000000; 1.000000; 1.000000; 1.000000;,
    56; 1.000000; 1.000000; 1.000000; 1.000000;,
    57; 1.000000; 1.000000; 1.000000; 1.000000;,
    58; 1.000000; 1.000000; 1.000000; 1.000000;,
    59; 1.000000; 1.000000; 1.000000; 1.000000;;
   }

   MeshMaterialList {
    1;
    84;
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0;

    Material def_surf_mat {
     0.992157; 0.992157; 0.992157; 1.000000;;
     128.000000;
     0.150000; 0.150000; 0.150000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "calculator.dds";
     }
    }

   }
  }
}
