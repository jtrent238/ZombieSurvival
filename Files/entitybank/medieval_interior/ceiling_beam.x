xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.18
// Time: Fri Sep 11 10:52:12 2009

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
       56;
       49.428604; 99.850800; -5.076440;,
       49.563202; 99.850800; 3.211970;,
       49.428604; 96.814400; -5.076440;,
       49.563202; 96.814400; 3.211970;,
       -49.432800; 99.850800; 4.819770;,
       -49.567398; 99.850800; -3.468630;,
       -49.432800; 96.814400; 4.819770;,
       -49.567398; 96.814400; -3.468630;,
       31.669500; 99.850800; -3.953700;,
       49.428604; 99.850800; -5.076440;,
       31.669500; 96.814400; -3.953700;,
       49.428604; 96.814400; -5.076440;,
       31.804100; 99.850800; 4.334610;,
       31.804100; 96.814400; 4.334610;,
       49.563202; 99.850800; 3.211970;,
       49.563202; 96.814400; 3.211970;,
       31.669500; 99.850800; -3.953700;,
       31.804100; 99.850800; 4.334610;,
       49.428604; 99.850800; -5.076440;,
       49.563202; 99.850800; 3.211970;,
       31.804100; 96.814400; 4.334610;,
       31.669500; 96.814400; -3.953700;,
       49.563202; 96.814400; 3.211970;,
       49.428604; 96.814400; -5.076440;,
       10.711200; 99.850800; -4.447630;,
       10.711200; 96.814400; -4.447630;,
       10.845800; 99.850800; 3.840780;,
       10.845800; 96.814400; 3.840780;,
       10.711200; 99.850800; -4.447630;,
       10.845800; 99.850800; 3.840780;,
       10.845800; 96.814400; 3.840780;,
       10.711200; 96.814400; -4.447630;,
       -14.110900; 99.850800; -4.044490;,
       -14.110900; 96.814400; -4.044490;,
       -13.976300; 99.850800; 4.243920;,
       -13.976300; 96.814400; 4.243920;,
       -14.110900; 99.850800; -4.044490;,
       -13.976300; 99.850800; 4.243920;,
       -13.976300; 96.814400; 4.243920;,
       -14.110900; 96.814400; -4.044490;,
       -34.822098; 99.850800; -4.285590;,
       -34.822098; 96.814400; -4.285590;,
       -49.567398; 99.850800; -3.468630;,
       -49.567398; 96.814400; -3.468630;,
       -34.687500; 99.850800; 4.002720;,
       -49.432800; 99.850800; 4.819770;,
       -34.687500; 96.814400; 4.002720;,
       -49.432800; 96.814400; 4.819770;,
       -49.567398; 99.850800; -3.468630;,
       -49.432800; 99.850800; 4.819770;,
       -34.822098; 99.850800; -4.285590;,
       -34.687500; 99.850800; 4.002720;,
       -49.432800; 96.814400; 4.819770;,
       -49.567398; 96.814400; -3.468630;,
       -34.687500; 96.814400; 4.002720;,
       -34.822098; 96.814400; -4.285590;;
       44;
       3;0, 1, 2;,
       3;1, 3, 2;,
       3;4, 5, 6;,
       3;5, 7, 6;,
       3;8, 9, 10;,
       3;9, 11, 10;,
       3;12, 13, 14;,
       3;13, 15, 14;,
       3;16, 17, 18;,
       3;17, 19, 18;,
       3;20, 21, 22;,
       3;21, 23, 22;,
       3;8, 10, 24;,
       3;10, 25, 24;,
       3;26, 27, 12;,
       3;27, 13, 12;,
       3;28, 29, 16;,
       3;29, 17, 16;,
       3;30, 31, 20;,
       3;31, 21, 20;,
       3;24, 25, 32;,
       3;25, 33, 32;,
       3;34, 35, 26;,
       3;35, 27, 26;,
       3;36, 37, 28;,
       3;37, 29, 28;,
       3;38, 39, 30;,
       3;39, 31, 30;,
       3;32, 33, 40;,
       3;33, 41, 40;,
       3;40, 41, 42;,
       3;41, 43, 42;,
       3;44, 45, 46;,
       3;45, 47, 46;,
       3;44, 46, 34;,
       3;46, 35, 34;,
       3;48, 49, 50;,
       3;49, 51, 50;,
       3;50, 51, 36;,
       3;51, 37, 36;,
       3;52, 53, 54;,
       3;53, 55, 54;,
       3;54, 55, 38;,
       3;55, 39, 38;;

      MeshNormals {
       56;
       0.999868; 0.000000; -0.016237;,
       0.999868; 0.000000; -0.016237;,
       0.999868; 0.000000; -0.016237;,
       0.999868; 0.000000; -0.016237;,
       -0.999868; 0.000000; 0.016237;,
       -0.999868; 0.000000; 0.016237;,
       -0.999868; 0.000000; 0.016237;,
       -0.999868; 0.000000; 0.016237;,
       -0.019786; 0.000000; -0.999804;,
       -0.063095; 0.000000; -0.998008;,
       -0.019786; 0.000000; -0.999804;,
       -0.063095; 0.000000; -0.998008;,
       0.005330; 0.000000; 0.999986;,
       0.034236; 0.000000; 0.999414;,
       0.063089; 0.000000; 0.998008;,
       0.063089; 0.000000; 0.998008;,
       0.000000; 1.000000; 0.000000;,
       0.000000; 1.000000; 0.000000;,
       0.000000; 1.000000; 0.000000;,
       0.000000; 1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.010296; 0.000000; -0.999947;,
       -0.002973; 0.000000; -0.999996;,
       0.002975; 0.000000; 0.999996;,
       -0.010293; 0.000000; 0.999947;,
       0.000000; 1.000000; 0.000000;,
       0.000000; 1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       -0.006947; 0.000000; -0.999976;,
       0.002347; 0.000000; -0.999997;,
       -0.002351; 0.000000; 0.999997;,
       0.006945; 0.000000; 0.999976;,
       0.000000; 1.000000; 0.000000;,
       0.000000; 1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       -0.010685; 0.000000; -0.999943;,
       -0.033016; 0.000000; -0.999455;,
       -0.055320; 0.000000; -0.998469;,
       -0.055320; 0.000000; -0.998469;,
       0.021853; 0.000000; 0.999761;,
       0.055326; 0.000000; 0.998468;,
       0.021853; 0.000000; 0.999761;,
       0.055326; 0.000000; 0.998468;,
       0.000000; 1.000000; 0.000000;,
       0.000000; 1.000000; 0.000000;,
       0.000000; 1.000000; 0.000000;,
       0.000000; 1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;,
       0.000000; -1.000000; 0.000000;;
       44;
       3;0, 1, 2;,
       3;1, 3, 2;,
       3;4, 5, 6;,
       3;5, 7, 6;,
       3;8, 9, 10;,
       3;9, 11, 10;,
       3;12, 13, 14;,
       3;13, 15, 14;,
       3;16, 17, 18;,
       3;17, 19, 18;,
       3;20, 21, 22;,
       3;21, 23, 22;,
       3;8, 10, 24;,
       3;10, 25, 24;,
       3;26, 27, 12;,
       3;27, 13, 12;,
       3;28, 29, 16;,
       3;29, 17, 16;,
       3;30, 31, 20;,
       3;31, 21, 20;,
       3;24, 25, 32;,
       3;25, 33, 32;,
       3;34, 35, 26;,
       3;35, 27, 26;,
       3;36, 37, 28;,
       3;37, 29, 28;,
       3;38, 39, 30;,
       3;39, 31, 30;,
       3;32, 33, 40;,
       3;33, 41, 40;,
       3;40, 41, 42;,
       3;41, 43, 42;,
       3;44, 45, 46;,
       3;45, 47, 46;,
       3;44, 46, 34;,
       3;46, 35, 34;,
       3;48, 49, 50;,
       3;49, 51, 50;,
       3;50, 51, 36;,
       3;51, 37, 36;,
       3;52, 53, 54;,
       3;53, 55, 54;,
       3;54, 55, 38;,
       3;55, 39, 38;;
      }

      MeshTextureCoords {
       56;
       0.483815; 0.537373;,
       0.483815; 0.461319;,
       0.456262; 0.537373;,
       0.456262; 0.461319;,
       0.483815; 0.616639;,
       0.483815; 0.540584;,
       0.456262; 0.616639;,
       0.456262; 0.540584;,
       0.485169; 0.554936;,
       0.485169; 0.475187;,
       0.455779; 0.554936;,
       0.455779; 0.475187;,
       0.485169; 0.393867;,
       0.455779; 0.393867;,
       0.485169; 0.473617;,
       0.455779; 0.473617;,
       0.576033; 0.820143;,
       0.508901; 0.820143;,
       0.582789; 0.995144;,
       0.515656; 0.995144;,
       0.427502; 0.195368;,
       0.494635; 0.195368;,
       0.434257; 0.020367;,
       0.501390; 0.020367;,
       0.485169; 0.648919;,
       0.455779; 0.648919;,
       0.485169; 0.299884;,
       0.455779; 0.299884;,
       0.582789; 0.613909;,
       0.515656; 0.613909;,
       0.434257; 0.401603;,
       0.501390; 0.401603;,
       0.485169; 0.760300;,
       0.455779; 0.760300;,
       0.485169; 0.188502;,
       0.455779; 0.188502;,
       0.582789; 0.369494;,
       0.515656; 0.369494;,
       0.434257; 0.646017;,
       0.501390; 0.646017;,
       0.485169; 0.853194;,
       0.455779; 0.853194;,
       0.485169; 0.919401;,
       0.455779; 0.919401;,
       0.485169; 0.095608;,
       0.485169; 0.029402;,
       0.455779; 0.095608;,
       0.455779; 0.029402;,
       0.582789; 0.020367;,
       0.515656; 0.020367;,
       0.587465; 0.165651;,
       0.520333; 0.165651;,
       0.434257; 0.995144;,
       0.501390; 0.995144;,
       0.438934; 0.849861;,
       0.506067; 0.849861;;
      }

      MeshVertexColors {
       56;
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
       55; 1.000000; 1.000000; 1.000000; 1.000000;;
      }

      MeshMaterialList {
       2;
       44;
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
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
         "medceiling1.dds";
        }
       }

       Material Material__1 {
        0.200000; 0.200000; 0.200000; 1.000000;;
        128.000000;
        0.200000; 0.200000; 0.200000;;
        0.000000; 0.000000; 0.000000;;
       }

      }

      XSkinMeshHeader {
       1;
       1;
       1;
      }

      SkinWeights {
       "Body";
       56;
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
       55;
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
