xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.13
// Time: Sun Mar 22 17:48:59 2009

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
 30;
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
    74;
    5.961940; 0.152292; 3.886630;,
    5.961940; 0.152292; -3.886630;,
    5.961940; 0.421438; 3.886630;,
    5.961940; 0.421438; -3.886630;,
    -5.961940; 0.152292; -3.886630;,
    -5.961940; 0.152292; 3.886630;,
    -5.961940; 0.421438; -3.886630;,
    -5.961940; 0.421438; 3.886630;,
    -3.245620; 0.408524; -3.886630;,
    -3.245620; 0.677551; -3.886630;,
    3.241370; 0.408298; -3.886630;,
    3.241370; 0.677443; -3.886630;,
    3.241370; 0.408298; 3.886630;,
    3.241370; 0.677443; 3.886630;,
    -3.245620; 0.408524; 3.886630;,
    -3.245620; 0.677551; 3.886630;,
    -1.781670; 0.331114; -3.886630;,
    -1.781670; 0.600153; -3.886630;,
    -0.002468; 0.000000; -3.886630;,
    -0.002468; 0.269039; -3.886630;,
    -0.002468; 0.000000; 3.886630;,
    -0.002468; 0.269146; 3.886630;,
    -1.781670; 0.331114; 3.886630;,
    -1.781670; 0.600153; 3.886630;,
    -0.002468; 0.000000; -3.886630;,
    -0.002468; 0.269039; -3.886630;,
    1.760690; 0.353412; -3.886630;,
    1.760690; 0.622558; -3.886630;,
    1.760690; 0.353412; 3.886630;,
    1.760690; 0.622558; 3.886630;,
    -0.002468; 0.000000; 3.886630;,
    -0.002468; 0.269146; 3.886630;,
    5.767321; 0.439741; 3.636050;,
    5.961940; 0.421438; 3.886630;,
    5.767321; 0.439741; -3.636070;,
    5.961940; 0.421438; -3.886630;,
    -5.767449; 0.439741; -3.636070;,
    -5.961940; 0.421438; -3.886630;,
    -5.767449; 0.439741; 3.636050;,
    -5.961940; 0.421438; 3.886630;,
    -0.002468; 0.269039; -3.636070;,
    -0.002468; 0.269039; -3.886630;,
    -1.781670; 0.600153; -3.636070;,
    -1.781670; 0.600153; -3.886630;,
    -0.001741; 0.780346; -3.636070;,
    -1.780950; 1.111353; -3.636070;,
    -0.001741; 0.780346; 3.636050;,
    -1.780950; 1.111353; 3.636050;,
    -0.002468; 0.269146; 3.636050;,
    -1.781670; 0.600153; 3.636050;,
    -0.002468; 0.269146; 3.886630;,
    -1.781670; 0.600153; 3.886630;,
    -3.245620; 0.677551; -3.636070;,
    -3.245620; 0.677551; -3.886630;,
    -3.244900; 1.188751; -3.636070;,
    -3.244900; 1.188751; 3.636050;,
    -3.245620; 0.677551; 3.636050;,
    -3.245620; 0.677551; 3.886630;,
    3.241370; 0.677443; -3.636070;,
    3.241370; 0.677443; -3.886630;,
    1.760690; 0.622558; -3.636070;,
    1.760690; 0.622558; -3.886630;,
    3.242100; 1.188644; -3.636070;,
    1.761390; 1.133758; -3.636070;,
    3.242100; 1.188644; 3.636050;,
    1.761390; 1.133758; 3.636050;,
    3.241370; 0.677443; 3.636050;,
    1.760690; 0.622558; 3.636050;,
    3.241370; 0.677443; 3.886630;,
    1.760690; 0.622558; 3.886630;,
    -4.997650; 0.915837; 3.636050;,
    -4.997650; 0.915837; -3.636070;,
    4.928980; 0.897081; -3.636070;,
    4.928980; 0.897081; 3.636050;;
    108;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;5, 7, 6;,
    3;8, 4, 9;,
    3;4, 6, 9;,
    3;10, 11, 1;,
    3;11, 3, 1;,
    3;12, 0, 13;,
    3;0, 2, 13;,
    3;14, 15, 5;,
    3;15, 7, 5;,
    3;14, 5, 8;,
    3;5, 4, 8;,
    3;12, 10, 0;,
    3;10, 1, 0;,
    3;8, 9, 16;,
    3;9, 17, 16;,
    3;16, 17, 18;,
    3;17, 19, 18;,
    3;20, 21, 22;,
    3;21, 23, 22;,
    3;22, 23, 14;,
    3;23, 15, 14;,
    3;14, 8, 22;,
    3;8, 16, 22;,
    3;22, 16, 20;,
    3;16, 18, 20;,
    3;24, 25, 26;,
    3;25, 27, 26;,
    3;26, 27, 10;,
    3;27, 11, 10;,
    3;12, 13, 28;,
    3;13, 29, 28;,
    3;28, 29, 30;,
    3;29, 31, 30;,
    3;30, 24, 28;,
    3;24, 26, 28;,
    3;28, 26, 12;,
    3;26, 10, 12;,
    3;32, 33, 34;,
    3;33, 35, 34;,
    3;36, 37, 38;,
    3;37, 39, 38;,
    3;40, 41, 42;,
    3;41, 43, 42;,
    3;44, 45, 46;,
    3;45, 47, 46;,
    3;48, 49, 50;,
    3;49, 51, 50;,
    3;42, 43, 52;,
    3;43, 53, 52;,
    3;45, 54, 47;,
    3;54, 55, 47;,
    3;49, 56, 51;,
    3;56, 57, 51;,
    3;58, 59, 60;,
    3;59, 61, 60;,
    3;62, 63, 64;,
    3;63, 65, 64;,
    3;66, 67, 68;,
    3;67, 69, 68;,
    3;60, 61, 40;,
    3;61, 41, 40;,
    3;63, 44, 65;,
    3;44, 46, 65;,
    3;67, 48, 69;,
    3;48, 50, 69;,
    3;70, 55, 71;,
    3;55, 54, 71;,
    3;38, 39, 56;,
    3;39, 57, 56;,
    3;52, 53, 36;,
    3;53, 37, 36;,
    3;72, 62, 73;,
    3;62, 64, 73;,
    3;34, 35, 58;,
    3;35, 59, 58;,
    3;68, 33, 66;,
    3;33, 32, 66;,
    3;45, 42, 54;,
    3;42, 52, 54;,
    3;54, 52, 71;,
    3;52, 36, 71;,
    3;44, 40, 45;,
    3;40, 42, 45;,
    3;63, 60, 44;,
    3;60, 40, 44;,
    3;62, 58, 63;,
    3;58, 60, 63;,
    3;72, 34, 62;,
    3;34, 58, 62;,
    3;65, 67, 64;,
    3;67, 66, 64;,
    3;64, 66, 73;,
    3;66, 32, 73;,
    3;46, 48, 65;,
    3;48, 67, 65;,
    3;47, 49, 46;,
    3;49, 48, 46;,
    3;55, 56, 47;,
    3;56, 49, 47;,
    3;70, 38, 55;,
    3;38, 56, 55;,
    3;71, 36, 70;,
    3;36, 38, 70;,
    3;73, 32, 72;,
    3;32, 34, 72;;

   MeshNormals {
    74;
    0.540409; -0.593649; 0.596271;,
    0.540409; -0.593649; -0.596271;,
    0.470265; 0.788664; 0.396056;,
    0.470265; 0.788664; -0.396056;,
    -0.540317; -0.593684; -0.596319;,
    -0.540317; -0.593684; 0.596319;,
    -0.470341; 0.788619; -0.396055;,
    -0.470351; 0.788636; 0.396009;,
    0.014554; -0.706002; -0.708060;,
    -0.014542; 0.706003; -0.708060;,
    -0.020048; -0.706064; -0.707864;,
    0.020048; 0.706072; -0.707856;,
    -0.020048; -0.706064; 0.707864;,
    0.020048; 0.706072; 0.707856;,
    0.014554; -0.706002; 0.708060;,
    -0.014542; 0.706027; 0.708035;,
    -0.083445; -0.701399; -0.707867;,
    0.083442; 0.701399; -0.707867;,
    0.004842; -0.700578; -0.713559;,
    -0.004863; 0.700576; -0.713561;,
    0.004842; -0.700578; 0.713559;,
    -0.004863; 0.700580; 0.713557;,
    -0.083445; -0.701399; 0.707867;,
    0.083422; 0.701402; 0.707867;,
    0.004842; -0.700578; -0.713559;,
    -0.004863; 0.700576; -0.713561;,
    0.082715; -0.701100; -0.708249;,
    -0.082735; 0.701097; -0.708250;,
    0.082715; -0.701100; 0.708249;,
    -0.082715; 0.701100; 0.708249;,
    0.004842; -0.700578; 0.713559;,
    -0.004863; 0.700580; 0.713557;,
    0.214183; 0.922377; 0.321476;,
    0.470265; 0.788664; 0.396056;,
    0.214183; 0.922377; -0.321476;,
    0.470265; 0.788664; -0.396056;,
    -0.230490; 0.917898; -0.323013;,
    -0.470341; 0.788619; -0.396055;,
    -0.230493; 0.917911; 0.322973;,
    -0.470351; 0.788636; 0.396009;,
    -0.004863; 0.700576; -0.713561;,
    -0.004863; 0.700576; -0.713561;,
    0.083442; 0.701399; -0.707867;,
    0.083442; 0.701399; -0.707867;,
    -0.004864; 0.700580; -0.713557;,
    0.083422; 0.701403; -0.707867;,
    -0.004864; 0.700580; 0.713557;,
    0.083422; 0.701403; 0.707867;,
    -0.004863; 0.700580; 0.713557;,
    0.083422; 0.701402; 0.707867;,
    -0.004863; 0.700580; 0.713557;,
    0.083422; 0.701402; 0.707867;,
    -0.014542; 0.706003; -0.708060;,
    -0.014542; 0.706003; -0.708060;,
    -0.035825; 0.704291; -0.709007;,
    -0.035825; 0.704291; 0.709007;,
    -0.014542; 0.706027; 0.708035;,
    -0.014542; 0.706027; 0.708035;,
    0.020048; 0.706072; -0.707856;,
    0.020048; 0.706072; -0.707856;,
    -0.082735; 0.701097; -0.708250;,
    -0.082735; 0.701097; -0.708250;,
    0.047247; 0.703600; -0.709023;,
    -0.082716; 0.701100; -0.708249;,
    0.047247; 0.703600; 0.709023;,
    -0.082716; 0.701100; 0.708249;,
    0.020048; 0.706072; 0.707856;,
    -0.082715; 0.701100; 0.708249;,
    0.020048; 0.706072; 0.707856;,
    -0.082715; 0.701100; 0.708249;,
    -0.308941; 0.835496; 0.454425;,
    -0.308941; 0.835496; -0.454425;,
    0.293491; 0.842317; -0.452067;,
    0.293491; 0.842317; 0.452067;;
    108;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;5, 7, 6;,
    3;8, 4, 9;,
    3;4, 6, 9;,
    3;10, 11, 1;,
    3;11, 3, 1;,
    3;12, 0, 13;,
    3;0, 2, 13;,
    3;14, 15, 5;,
    3;15, 7, 5;,
    3;14, 5, 8;,
    3;5, 4, 8;,
    3;12, 10, 0;,
    3;10, 1, 0;,
    3;8, 9, 16;,
    3;9, 17, 16;,
    3;16, 17, 18;,
    3;17, 19, 18;,
    3;20, 21, 22;,
    3;21, 23, 22;,
    3;22, 23, 14;,
    3;23, 15, 14;,
    3;14, 8, 22;,
    3;8, 16, 22;,
    3;22, 16, 20;,
    3;16, 18, 20;,
    3;24, 25, 26;,
    3;25, 27, 26;,
    3;26, 27, 10;,
    3;27, 11, 10;,
    3;12, 13, 28;,
    3;13, 29, 28;,
    3;28, 29, 30;,
    3;29, 31, 30;,
    3;30, 24, 28;,
    3;24, 26, 28;,
    3;28, 26, 12;,
    3;26, 10, 12;,
    3;32, 33, 34;,
    3;33, 35, 34;,
    3;36, 37, 38;,
    3;37, 39, 38;,
    3;40, 41, 42;,
    3;41, 43, 42;,
    3;44, 45, 46;,
    3;45, 47, 46;,
    3;48, 49, 50;,
    3;49, 51, 50;,
    3;42, 43, 52;,
    3;43, 53, 52;,
    3;45, 54, 47;,
    3;54, 55, 47;,
    3;49, 56, 51;,
    3;56, 57, 51;,
    3;58, 59, 60;,
    3;59, 61, 60;,
    3;62, 63, 64;,
    3;63, 65, 64;,
    3;66, 67, 68;,
    3;67, 69, 68;,
    3;60, 61, 40;,
    3;61, 41, 40;,
    3;63, 44, 65;,
    3;44, 46, 65;,
    3;67, 48, 69;,
    3;48, 50, 69;,
    3;70, 55, 71;,
    3;55, 54, 71;,
    3;38, 39, 56;,
    3;39, 57, 56;,
    3;52, 53, 36;,
    3;53, 37, 36;,
    3;72, 62, 73;,
    3;62, 64, 73;,
    3;34, 35, 58;,
    3;35, 59, 58;,
    3;68, 33, 66;,
    3;33, 32, 66;,
    3;45, 42, 54;,
    3;42, 52, 54;,
    3;54, 52, 71;,
    3;52, 36, 71;,
    3;44, 40, 45;,
    3;40, 42, 45;,
    3;63, 60, 44;,
    3;60, 40, 44;,
    3;62, 58, 63;,
    3;58, 60, 63;,
    3;72, 34, 62;,
    3;34, 58, 62;,
    3;65, 67, 64;,
    3;67, 66, 64;,
    3;64, 66, 73;,
    3;66, 32, 73;,
    3;46, 48, 65;,
    3;48, 67, 65;,
    3;47, 49, 46;,
    3;49, 48, 46;,
    3;55, 56, 47;,
    3;56, 49, 47;,
    3;70, 38, 55;,
    3;38, 56, 55;,
    3;71, 36, 70;,
    3;36, 38, 70;,
    3;73, 32, 72;,
    3;32, 34, 72;;
   }

   MeshTextureCoords {
    74;
    0.292398; 0.929000;,
    0.734245; 0.930364;,
    0.290710; 0.941121;,
    0.735839; 0.942498;,
    0.735860; 0.926793;,
    0.294009; 0.928157;,
    0.737543; 0.938919;,
    0.292420; 0.940295;,
    0.735441; 0.787134;,
    0.751580; 0.787383;,
    0.735103; 0.790639;,
    0.751209; 0.790960;,
    0.292818; 0.789125;,
    0.276693; 0.789327;,
    0.292818; 0.789125;,
    0.276693; 0.789327;,
    0.735115; 0.711890;,
    0.750517; 0.713485;,
    0.734615; 0.619066;,
    0.749533; 0.618972;,
    0.292179; 0.620698;,
    0.277259; 0.620641;,
    0.292671; 0.713491;,
    0.277279; 0.715285;,
    0.736080; 0.622476;,
    0.750998; 0.622570;,
    0.735592; 0.714679;,
    0.750982; 0.716482;,
    0.292671; 0.713491;,
    0.277279; 0.715285;,
    0.293643; 0.620844;,
    0.278724; 0.620902;,
    0.751055; 0.432969;,
    0.760434; 0.443535;,
    0.748843; 0.121081;,
    0.757935; 0.110424;,
    0.205867; 0.123966;,
    0.196481; 0.113395;,
    0.208089; 0.435920;,
    0.198997; 0.446586;,
    0.477503; 0.100846;,
    0.477461; 0.090438;,
    0.397390; 0.101474;,
    0.397403; 0.090434;,
    0.477605; 0.122847;,
    0.394886; 0.123384;,
    0.479526; 0.434116;,
    0.396825; 0.434420;,
    0.479347; 0.456112;,
    0.399324; 0.456135;,
    0.479398; 0.466522;,
    0.399232; 0.467170;,
    0.324362; 0.099411;,
    0.322556; 0.088514;,
    0.327924; 0.123842;,
    0.329956; 0.434669;,
    0.325567; 0.455916;,
    0.324070; 0.466878;,
    0.631732; 0.101021;,
    0.633220; 0.090094;,
    0.557200; 0.100887;,
    0.557292; 0.089827;,
    0.627380; 0.122243;,
    0.559780; 0.122528;,
    0.629410; 0.433172;,
    0.561719; 0.433598;,
    0.632926; 0.457357;,
    0.559131; 0.455418;,
    0.634672; 0.468306;,
    0.559125; 0.466479;,
    0.249205; 0.434775;,
    0.247162; 0.124563;,
    0.705373; 0.122094;,
    0.707410; 0.432527;;
   }

   MeshVertexColors {
    74;
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
    59; 1.000000; 1.000000; 1.000000; 1.000000;,
    60; 1.000000; 1.000000; 1.000000; 1.000000;,
    61; 1.000000; 1.000000; 1.000000; 1.000000;,
    62; 1.000000; 1.000000; 1.000000; 1.000000;,
    63; 1.000000; 1.000000; 1.000000; 1.000000;,
    64; 1.000000; 1.000000; 1.000000; 1.000000;,
    65; 1.000000; 1.000000; 1.000000; 1.000000;,
    66; 1.000000; 1.000000; 1.000000; 1.000000;,
    67; 1.000000; 1.000000; 1.000000; 1.000000;,
    68; 1.000000; 1.000000; 1.000000; 1.000000;,
    69; 1.000000; 1.000000; 1.000000; 1.000000;,
    70; 1.000000; 1.000000; 1.000000; 1.000000;,
    71; 1.000000; 1.000000; 1.000000; 1.000000;,
    72; 1.000000; 1.000000; 1.000000; 1.000000;,
    73; 1.000000; 1.000000; 1.000000; 1.000000;;
   }

   MeshMaterialList {
    1;
    108;
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

    Material openbook {
     1.000000; 1.000000; 1.000000; 1.000000;;
     128.000000;
     1.000000; 1.000000; 1.000000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "open_book.jpg";
     }
    }

   }
  }
}
