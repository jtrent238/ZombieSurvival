xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.18
// Time: Thu Sep 10 19:33:12 2009

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

   }

   Frame Body0 {
      FrameTransformMatrix {
       1.000000, 0.000000, 0.000000, 0.000000,
       0.000000, 1.000000, 0.000000, 0.000000,
       0.000000, 0.000000, 1.000000, 0.000000,
       0.000000, 0.000000, 0.000000, 1.000000;;
      }

      Mesh skinnedMesh {
       86;
       -0.127466; 0.258430; -4.415610;,
       0.127464; 0.258430; -4.415610;,
       -0.127466; 0.100400; -4.415610;,
       0.127464; 0.100400; -4.415610;,
       -0.127466; 0.100400; -4.415610;,
       0.127464; 0.100400; -4.415610;,
       -0.291286; 0.100710; -4.078850;,
       0.291287; 0.100710; -4.078850;,
       -0.127466; 0.258430; -4.415610;,
       -0.291286; 0.257161; -4.078850;,
       0.127464; 0.258430; -4.415610;,
       0.291287; 0.257161; -4.078850;,
       -0.546056; 0.101211; -3.459830;,
       0.546053; 0.101211; -3.459830;,
       -0.546056; 0.255225; -3.459830;,
       0.546053; 0.255225; -3.459830;,
       -0.446006; 0.101010; -3.132180;,
       0.446002; 0.101010; -3.132180;,
       -0.446006; 0.255990; -3.132180;,
       0.446002; 0.255990; -3.132180;,
       -0.227516; 0.100590; -2.686260;,
       0.227515; 0.100590; -2.686260;,
       -0.227516; 0.257648; -2.686260;,
       0.227515; 0.257648; -2.686260;,
       -0.291286; 0.100710; -2.258398;,
       0.291287; 0.100710; -2.258398;,
       -0.291286; 0.257160; -2.258398;,
       0.291287; 0.257160; -2.258398;,
       -0.352626; 0.189417; -1.857865;,
       0.352620; 0.189417; -1.857865;,
       -0.352626; 0.344995; -1.857865;,
       0.352620; 0.344995; -1.857865;,
       -0.247036; 0.252475; -1.193460;,
       0.247037; 0.252475; -1.193460;,
       -0.247036; 0.408847; -1.193460;,
       0.247037; 0.408847; -1.193460;,
       -0.109406; 0.252100; 0.991080;,
       0.109404; 0.252100; 0.991080;,
       -0.109406; 0.410312; 0.991080;,
       0.109404; 0.410312; 0.991080;,
       -0.182126; 0.176419; 1.554130;,
       0.182287; 0.176419; 1.554130;,
       -0.182126; 0.333915; 1.554130;,
       0.182287; 0.333915; 1.554130;,
       -0.427946; 0.113660; 2.218699;,
       0.427942; 0.113660; 2.218699;,
       -0.427946; 0.268792; 2.218699;,
       0.427942; 0.268792; 2.218699;,
       -0.573546; 0.153757; 2.773950;,
       -0.573546; 0.000000; 2.773950;,
       0.573546; 0.000000; 2.773950;,
       0.573546; 0.153757; 2.773950;,
       -0.429896; 0.153757; 2.773950;,
       -0.429896; 0.000000; 2.773950;,
       -0.573546; 0.153757; 3.474800;,
       -0.573546; 0.000000; 3.474800;,
       -0.485696; 0.076890; 4.415610;,
       -0.429896; 0.153757; 3.474800;,
       -0.429896; 0.000000; 3.474800;,
       0.398334; 0.153757; 3.474800;,
       0.398334; 0.153757; 2.773950;,
       0.398334; 0.000000; 3.474800;,
       0.398334; 0.000000; 2.773950;,
       0.486346; 0.076890; 4.415610;,
       0.542147; 0.153757; 3.474800;,
       0.542147; 0.153757; 2.773950;,
       0.542147; 0.000000; 3.474800;,
       0.542147; 0.000000; 2.773950;,
       0.044654; 0.153757; 3.474800;,
       0.044654; 0.153757; 2.773950;,
       0.044654; 0.000000; 3.474800;,
       0.044654; 0.000000; 2.773950;,
       0.132504; 0.076890; 4.415610;,
       0.188470; 0.153757; 3.474800;,
       0.188470; 0.153757; 2.773950;,
       0.188470; 0.000000; 3.474800;,
       0.188470; 0.000000; 2.773950;,
       -0.245736; 0.153757; 3.474800;,
       -0.245736; 0.153757; 2.773950;,
       -0.245736; 0.000000; 3.474800;,
       -0.245736; 0.000000; 2.773950;,
       -0.157886; 0.076890; 4.415610;,
       -0.101926; 0.153757; 3.474800;,
       -0.101926; 0.153757; 2.773950;,
       -0.101926; 0.000000; 3.474800;,
       -0.101926; 0.000000; 2.773950;;
       142;
       3;0, 1, 2;,
       3;1, 3, 2;,
       3;4, 5, 6;,
       3;5, 7, 6;,
       3;8, 4, 9;,
       3;4, 6, 9;,
       3;10, 8, 11;,
       3;8, 9, 11;,
       3;5, 10, 7;,
       3;10, 11, 7;,
       3;6, 7, 12;,
       3;7, 13, 12;,
       3;9, 6, 14;,
       3;6, 12, 14;,
       3;11, 9, 15;,
       3;9, 14, 15;,
       3;7, 11, 13;,
       3;11, 15, 13;,
       3;12, 13, 16;,
       3;13, 17, 16;,
       3;14, 12, 18;,
       3;12, 16, 18;,
       3;15, 14, 19;,
       3;14, 18, 19;,
       3;13, 15, 17;,
       3;15, 19, 17;,
       3;16, 17, 20;,
       3;17, 21, 20;,
       3;18, 16, 22;,
       3;16, 20, 22;,
       3;19, 18, 23;,
       3;18, 22, 23;,
       3;17, 19, 21;,
       3;19, 23, 21;,
       3;20, 21, 24;,
       3;21, 25, 24;,
       3;22, 20, 26;,
       3;20, 24, 26;,
       3;23, 22, 27;,
       3;22, 26, 27;,
       3;21, 23, 25;,
       3;23, 27, 25;,
       3;24, 25, 28;,
       3;25, 29, 28;,
       3;26, 24, 30;,
       3;24, 28, 30;,
       3;27, 26, 31;,
       3;26, 30, 31;,
       3;25, 27, 29;,
       3;27, 31, 29;,
       3;28, 29, 32;,
       3;29, 33, 32;,
       3;30, 28, 34;,
       3;28, 32, 34;,
       3;31, 30, 35;,
       3;30, 34, 35;,
       3;29, 31, 33;,
       3;31, 35, 33;,
       3;32, 33, 36;,
       3;33, 37, 36;,
       3;34, 32, 38;,
       3;32, 36, 38;,
       3;35, 34, 39;,
       3;34, 38, 39;,
       3;33, 35, 37;,
       3;35, 39, 37;,
       3;36, 37, 40;,
       3;37, 41, 40;,
       3;38, 36, 42;,
       3;36, 40, 42;,
       3;39, 38, 43;,
       3;38, 42, 43;,
       3;37, 39, 41;,
       3;39, 43, 41;,
       3;40, 41, 44;,
       3;41, 45, 44;,
       3;42, 40, 46;,
       3;40, 44, 46;,
       3;43, 42, 47;,
       3;42, 46, 47;,
       3;41, 43, 45;,
       3;43, 47, 45;,
       3;46, 44, 48;,
       3;44, 49, 48;,
       3;45, 47, 50;,
       3;47, 51, 50;,
       3;52, 53, 51;,
       3;53, 50, 51;,
       3;44, 45, 49;,
       3;45, 50, 49;,
       3;49, 50, 53;,
       3;47, 46, 51;,
       3;46, 48, 51;,
       3;51, 48, 52;,
       3;54, 48, 55;,
       3;48, 49, 55;,
       3;55, 56, 54;,
       3;57, 52, 54;,
       3;52, 48, 54;,
       3;54, 56, 57;,
       3;55, 49, 58;,
       3;49, 53, 58;,
       3;58, 56, 55;,
       3;58, 53, 57;,
       3;53, 52, 57;,
       3;57, 56, 58;,
       3;59, 60, 61;,
       3;60, 62, 61;,
       3;61, 63, 59;,
       3;64, 65, 59;,
       3;65, 60, 59;,
       3;59, 63, 64;,
       3;61, 62, 66;,
       3;62, 67, 66;,
       3;66, 63, 61;,
       3;66, 67, 64;,
       3;67, 65, 64;,
       3;64, 63, 66;,
       3;68, 69, 70;,
       3;69, 71, 70;,
       3;70, 72, 68;,
       3;73, 74, 68;,
       3;74, 69, 68;,
       3;68, 72, 73;,
       3;70, 71, 75;,
       3;71, 76, 75;,
       3;75, 72, 70;,
       3;75, 76, 73;,
       3;76, 74, 73;,
       3;73, 72, 75;,
       3;77, 78, 79;,
       3;78, 80, 79;,
       3;79, 81, 77;,
       3;82, 83, 77;,
       3;83, 78, 77;,
       3;77, 81, 82;,
       3;79, 80, 84;,
       3;80, 85, 84;,
       3;84, 81, 79;,
       3;84, 85, 82;,
       3;85, 83, 82;,
       3;82, 81, 84;;

      MeshNormals {
       86;
       0.000000; 0.000000; -1.000000;,
       0.000000; 0.000000; -1.000000;,
       0.000000; 0.000000; -1.000000;,
       0.000000; 0.000000; -1.000000;,
       -0.804439; -0.447285; -0.390915;,
       0.402218; -0.894571; -0.194843;,
       -0.648136; -0.707384; -0.282008;,
       0.642123; -0.707384; -0.295441;,
       -0.402420; 0.895011; -0.192388;,
       -0.642460; 0.707751; -0.293828;,
       0.804837; 0.447506; -0.389841;,
       0.648482; 0.707758; -0.280267;,
       -0.686322; -0.725614; 0.049462;,
       0.678665; -0.725614; -0.113571;,
       -0.678644; 0.725591; -0.113843;,
       0.686300; 0.725587; 0.050168;,
       -0.649753; -0.708203; 0.276169;,
       0.663542; -0.708203; 0.241164;,
       -0.663817; 0.708494; 0.239547;,
       0.650018; 0.708488; 0.274811;,
       -0.691637; -0.721420; 0.034523;,
       0.669738; -0.721422; 0.176071;,
       -0.669768; 0.721453; 0.175829;,
       0.691665; 0.721446; 0.033393;,
       -0.704792; -0.707243; -0.055457;,
       0.708767; -0.705436; -0.003215;,
       -0.693723; 0.690672; -0.204257;,
       0.697225; 0.699754; -0.155633;,
       -0.699505; -0.695852; 0.162734;,
       0.705422; -0.706095; 0.061729;,
       -0.700715; 0.701438; -0.130317;,
       0.706227; 0.702724; -0.086155;,
       -0.701872; -0.703614; 0.110917;,
       0.700117; -0.705366; 0.110886;,
       -0.702931; 0.708175; 0.066146;,
       0.706094; 0.707793; 0.021466;,
       -0.703871; -0.706124; -0.077164;,
       0.706334; -0.705012; -0.063645;,
       -0.706413; 0.705003; 0.062867;,
       0.705914; 0.708151; -0.014385;,
       -0.666911; -0.692539; -0.274988;,
       0.683227; -0.697447; -0.216260;,
       -0.698389; 0.712724; -0.065406;,
       0.689577; 0.715886; -0.109502;,
       -0.665657; -0.688445; -0.287999;,
       0.654083; -0.679781; -0.331774;,
       -0.689458; 0.716270; -0.107727;,
       0.691059; 0.714421; -0.109727;,
       -0.891217; 0.448306; -0.068955;,
       -0.440170; -0.885884; -0.146492;,
       0.884142; -0.447734; 0.133517;,
       0.315455; 0.638679; 0.701839;,
       0.408248; 0.816497; 0.408248;,
       0.666667; -0.333333; 0.666667;,
       -0.553644; 0.831347; 0.048384;,
       -0.831131; -0.553967; 0.048394;,
       0.008179; 0.000006; 0.999967;,
       0.831692; 0.553865; 0.039012;,
       0.554366; -0.831357; 0.039023;,
       -0.553639; 0.831347; 0.048431;,
       -0.894427; 0.447214; 0.000000;,
       -0.831128; -0.553967; 0.048441;,
       -0.447214; -0.894427; 0.000000;,
       0.008225; 0.000007; 0.999966;,
       0.831692; 0.553865; 0.039012;,
       0.447214; 0.894427; 0.000000;,
       0.554366; -0.831357; 0.039024;,
       0.894427; -0.447214; 0.000000;,
       -0.553644; 0.831347; 0.048384;,
       -0.894427; 0.447214; 0.000000;,
       -0.831131; -0.553967; 0.048394;,
       -0.447214; -0.894427; 0.000000;,
       0.008142; 0.000006; 0.999967;,
       0.831690; 0.553865; 0.039061;,
       0.447214; 0.894427; 0.000000;,
       0.554363; -0.831357; 0.039072;,
       0.894427; -0.447214; 0.000000;,
       -0.553644; 0.831347; 0.048384;,
       -0.894427; 0.447214; 0.000000;,
       -0.831131; -0.553967; 0.048394;,
       -0.447214; -0.894427; 0.000000;,
       0.008143; 0.000006; 0.999967;,
       0.831690; 0.553865; 0.039059;,
       0.447214; 0.894427; 0.000000;,
       0.554363; -0.831357; 0.039070;,
       0.894427; -0.447214; 0.000000;;
       142;
       3;0, 1, 2;,
       3;1, 3, 2;,
       3;4, 5, 6;,
       3;5, 7, 6;,
       3;8, 4, 9;,
       3;4, 6, 9;,
       3;10, 8, 11;,
       3;8, 9, 11;,
       3;5, 10, 7;,
       3;10, 11, 7;,
       3;6, 7, 12;,
       3;7, 13, 12;,
       3;9, 6, 14;,
       3;6, 12, 14;,
       3;11, 9, 15;,
       3;9, 14, 15;,
       3;7, 11, 13;,
       3;11, 15, 13;,
       3;12, 13, 16;,
       3;13, 17, 16;,
       3;14, 12, 18;,
       3;12, 16, 18;,
       3;15, 14, 19;,
       3;14, 18, 19;,
       3;13, 15, 17;,
       3;15, 19, 17;,
       3;16, 17, 20;,
       3;17, 21, 20;,
       3;18, 16, 22;,
       3;16, 20, 22;,
       3;19, 18, 23;,
       3;18, 22, 23;,
       3;17, 19, 21;,
       3;19, 23, 21;,
       3;20, 21, 24;,
       3;21, 25, 24;,
       3;22, 20, 26;,
       3;20, 24, 26;,
       3;23, 22, 27;,
       3;22, 26, 27;,
       3;21, 23, 25;,
       3;23, 27, 25;,
       3;24, 25, 28;,
       3;25, 29, 28;,
       3;26, 24, 30;,
       3;24, 28, 30;,
       3;27, 26, 31;,
       3;26, 30, 31;,
       3;25, 27, 29;,
       3;27, 31, 29;,
       3;28, 29, 32;,
       3;29, 33, 32;,
       3;30, 28, 34;,
       3;28, 32, 34;,
       3;31, 30, 35;,
       3;30, 34, 35;,
       3;29, 31, 33;,
       3;31, 35, 33;,
       3;32, 33, 36;,
       3;33, 37, 36;,
       3;34, 32, 38;,
       3;32, 36, 38;,
       3;35, 34, 39;,
       3;34, 38, 39;,
       3;33, 35, 37;,
       3;35, 39, 37;,
       3;36, 37, 40;,
       3;37, 41, 40;,
       3;38, 36, 42;,
       3;36, 40, 42;,
       3;39, 38, 43;,
       3;38, 42, 43;,
       3;37, 39, 41;,
       3;39, 43, 41;,
       3;40, 41, 44;,
       3;41, 45, 44;,
       3;42, 40, 46;,
       3;40, 44, 46;,
       3;43, 42, 47;,
       3;42, 46, 47;,
       3;41, 43, 45;,
       3;43, 47, 45;,
       3;46, 44, 48;,
       3;44, 49, 48;,
       3;45, 47, 50;,
       3;47, 51, 50;,
       3;52, 53, 51;,
       3;53, 50, 51;,
       3;44, 45, 49;,
       3;45, 50, 49;,
       3;49, 50, 53;,
       3;47, 46, 51;,
       3;46, 48, 51;,
       3;51, 48, 52;,
       3;54, 48, 55;,
       3;48, 49, 55;,
       3;55, 56, 54;,
       3;57, 52, 54;,
       3;52, 48, 54;,
       3;54, 56, 57;,
       3;55, 49, 58;,
       3;49, 53, 58;,
       3;58, 56, 55;,
       3;58, 53, 57;,
       3;53, 52, 57;,
       3;57, 56, 58;,
       3;59, 60, 61;,
       3;60, 62, 61;,
       3;61, 63, 59;,
       3;64, 65, 59;,
       3;65, 60, 59;,
       3;59, 63, 64;,
       3;61, 62, 66;,
       3;62, 67, 66;,
       3;66, 63, 61;,
       3;66, 67, 64;,
       3;67, 65, 64;,
       3;64, 63, 66;,
       3;68, 69, 70;,
       3;69, 71, 70;,
       3;70, 72, 68;,
       3;73, 74, 68;,
       3;74, 69, 68;,
       3;68, 72, 73;,
       3;70, 71, 75;,
       3;71, 76, 75;,
       3;75, 72, 70;,
       3;75, 76, 73;,
       3;76, 74, 73;,
       3;73, 72, 75;,
       3;77, 78, 79;,
       3;78, 80, 79;,
       3;79, 81, 77;,
       3;82, 83, 77;,
       3;83, 78, 77;,
       3;77, 81, 82;,
       3;79, 80, 84;,
       3;80, 85, 84;,
       3;84, 81, 79;,
       3;84, 85, 82;,
       3;85, 83, 82;,
       3;82, 81, 84;;
      }

      MeshTextureCoords {
       86;
       0.828872; 0.232108;,
       0.828872; 0.232108;,
       0.828872; 0.232108;,
       0.828872; 0.232108;,
       0.143430; 0.790667;,
       0.155288; 0.791191;,
       0.133075; 0.772583;,
       0.166168; 0.772583;,
       0.143430; 0.790667;,
       0.133075; 0.772583;,
       0.155288; 0.791191;,
       0.166168; 0.772583;,
       0.120169; 0.737421;,
       0.180646; 0.737421;,
       0.120169; 0.737421;,
       0.180646; 0.737421;,
       0.124284; 0.718807;,
       0.174959; 0.718807;,
       0.124284; 0.718807;,
       0.174959; 0.718807;,
       0.136694; 0.693469;,
       0.162548; 0.693469;,
       0.136694; 0.693469;,
       0.162548; 0.693469;,
       0.133075; 0.669166;,
       0.166168; 0.669166;,
       0.133075; 0.669166;,
       0.166168; 0.669166;,
       0.129589; 0.646413;,
       0.169653; 0.646413;,
       0.129589; 0.646413;,
       0.169653; 0.646413;,
       0.138729; 0.608667;,
       0.161038; 0.608142;,
       0.138729; 0.608667;,
       0.161038; 0.608142;,
       0.143407; 0.484564;,
       0.155836; 0.484564;,
       0.143407; 0.484564;,
       0.155836; 0.484564;,
       0.139271; 0.452571;,
       0.159973; 0.452571;,
       0.139271; 0.452571;,
       0.159973; 0.452571;,
       0.125310; 0.414823;,
       0.173934; 0.414823;,
       0.125310; 0.414823;,
       0.173934; 0.414823;,
       0.120182; 0.383281;,
       0.120182; 0.383281;,
       0.182207; 0.383281;,
       0.182207; 0.383281;,
       0.125201; 0.383281;,
       0.125201; 0.383281;,
       0.120182; 0.343459;,
       0.120182; 0.343459;,
       0.122028; 0.290011;,
       0.125201; 0.343459;,
       0.125201; 0.343459;,
       0.175925; 0.343459;,
       0.173827; 0.383281;,
       0.175925; 0.343459;,
       0.173827; 0.383281;,
       0.172527; 0.290011;,
       0.180420; 0.343459;,
       0.180420; 0.383281;,
       0.180420; 0.343459;,
       0.180420; 0.383281;,
       0.154781; 0.343459;,
       0.154781; 0.383281;,
       0.154781; 0.343459;,
       0.154781; 0.383281;,
       0.154529; 0.290011;,
       0.162947; 0.343459;,
       0.160325; 0.383281;,
       0.162947; 0.343459;,
       0.160325; 0.383281;,
       0.137759; 0.343459;,
       0.137235; 0.383281;,
       0.137759; 0.343459;,
       0.137235; 0.383281;,
       0.139081; 0.290011;,
       0.143827; 0.343459;,
       0.143827; 0.383281;,
       0.143827; 0.343459;,
       0.143827; 0.383281;;
      }

      MeshVertexColors {
       86;
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
       73; 1.000000; 1.000000; 1.000000; 1.000000;,
       74; 1.000000; 1.000000; 1.000000; 1.000000;,
       75; 1.000000; 1.000000; 1.000000; 1.000000;,
       76; 1.000000; 1.000000; 1.000000; 1.000000;,
       77; 1.000000; 1.000000; 1.000000; 1.000000;,
       78; 1.000000; 1.000000; 1.000000; 1.000000;,
       79; 1.000000; 1.000000; 1.000000; 1.000000;,
       80; 1.000000; 1.000000; 1.000000; 1.000000;,
       81; 1.000000; 1.000000; 1.000000; 1.000000;,
       82; 1.000000; 1.000000; 1.000000; 1.000000;,
       83; 1.000000; 1.000000; 1.000000; 1.000000;,
       84; 1.000000; 1.000000; 1.000000; 1.000000;,
       85; 1.000000; 1.000000; 1.000000; 1.000000;;
      }

      MeshMaterialList {
       1;
       142;
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

       Material ec_dinnerknife {
        1.000000; 1.000000; 1.000000; 1.000000;;
        128.000000;
        1.000000; 1.000000; 1.000000;;
        0.000000; 0.000000; 0.000000;;

        TextureFilename {
         "plate.dds";
        }
       }

      }

      XSkinMeshHeader {
       1;
       1;
       1;
      }

      SkinWeights {
       "Body";
       86;
       0,
       1,
       2,
       3,
       4,
       5,
       6,
       7,
       8,
       9,
       10,
       11,
       12,
       13,
       14,
       15,
       16,
       17,
       18,
       19,
       20,
       21,
       22,
       23,
       24,
       25,
       26,
       27,
       28,
       29,
       30,
       31,
       32,
       33,
       34,
       35,
       36,
       37,
       38,
       39,
       40,
       41,
       42,
       43,
       44,
       45,
       46,
       47,
       48,
       49,
       50,
       51,
       52,
       53,
       54,
       55,
       56,
       57,
       58,
       59,
       60,
       61,
       62,
       63,
       64,
       65,
       66,
       67,
       68,
       69,
       70,
       71,
       72,
       73,
       74,
       75,
       76,
       77,
       78,
       79,
       80,
       81,
       82,
       83,
       84,
       85;
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000,
       1.000000;
          1.000000, -0.000000, 0.000000, 0.000000,
          -0.000000, 1.000000, -0.000000, 0.000000,
          0.000000, -0.000000, 1.000000, 0.000000,
          -0.000000, -0.000000, -0.000000, 1.000000;;
      }


     }
   }

// Start of Animation

AnimationSet Untitled {
}
