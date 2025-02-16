xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.18
// Time: Fri Sep 11 10:51:41 2009

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
       52;
       50.586300; 99.890297; 3.464150;,
       50.586300; 99.866302; -3.467850;,
       22.061001; 99.890297; 3.464150;,
       22.061001; 99.866302; -3.467850;,
       -2.681980; 99.890297; 3.464150;,
       -2.681980; 99.866302; -3.467850;,
       -2.681980; 99.890297; 3.464150;,
       -2.681980; 99.866302; -3.467850;,
       -28.759001; 99.890297; 3.464150;,
       -28.759001; 99.866302; -3.467850;,
       -50.586300; 99.890297; 3.464150;,
       -50.586300; 99.866302; -3.467850;,
       50.586300; 93.746300; -3.464150;,
       50.586300; 93.770302; 3.467850;,
       22.061001; 91.571297; -3.464150;,
       22.061001; 91.595299; 3.467850;,
       -2.681980; 95.769302; -3.464150;,
       -2.681980; 95.793297; 3.467850;,
       -28.759001; 91.586304; -3.464150;,
       -28.759001; 91.610298; 3.467850;,
       -50.586300; 93.746300; -3.464150;,
       -50.586300; 93.770302; 3.467850;,
       50.586300; 99.890297; 3.464150;,
       50.586300; 93.770302; 3.467850;,
       50.586300; 99.866302; -3.467850;,
       50.586300; 93.746300; -3.464150;,
       50.586300; 99.866302; -3.467850;,
       50.586300; 93.746300; -3.464150;,
       22.061001; 99.866302; -3.467850;,
       22.061001; 91.571297; -3.464150;,
       -50.586300; 93.746300; -3.464150;,
       -50.586300; 93.770302; 3.467850;,
       -28.759001; 99.866302; -3.467850;,
       -28.759001; 91.586304; -3.464150;,
       -50.586300; 99.866302; -3.467850;,
       -50.586300; 93.746300; -3.464150;,
       -50.586300; 99.890297; 3.464150;,
       -50.586300; 93.770302; 3.467850;,
       -28.759001; 99.890297; 3.464150;,
       -28.759001; 91.610298; 3.467850;,
       22.061001; 99.890297; 3.464150;,
       22.061001; 91.595299; 3.467850;,
       50.586300; 99.890297; 3.464150;,
       50.586300; 93.770302; 3.467850;,
       -2.681980; 99.866302; -3.467850;,
       -2.681980; 95.769302; -3.464150;,
       -2.681980; 99.890297; 3.464150;,
       -2.681980; 95.793297; 3.467850;,
       -2.681980; 99.866302; -3.467850;,
       -2.681980; 95.769302; -3.464150;,
       -2.681980; 99.890297; 3.464150;,
       -2.681980; 95.793297; 3.467850;;
       36;
       3;0, 1, 2;,
       3;1, 3, 2;,
       3;2, 3, 4;,
       3;3, 5, 4;,
       3;6, 7, 8;,
       3;7, 9, 8;,
       3;8, 9, 10;,
       3;9, 11, 10;,
       3;12, 13, 14;,
       3;13, 15, 14;,
       3;14, 15, 16;,
       3;15, 17, 16;,
       3;16, 17, 18;,
       3;17, 19, 18;,
       3;18, 19, 20;,
       3;19, 21, 20;,
       3;22, 23, 24;,
       3;23, 25, 24;,
       3;26, 27, 28;,
       3;27, 29, 28;,
       3;11, 30, 10;,
       3;30, 31, 10;,
       3;32, 33, 34;,
       3;33, 35, 34;,
       3;36, 37, 38;,
       3;37, 39, 38;,
       3;40, 41, 42;,
       3;41, 43, 42;,
       3;28, 29, 44;,
       3;29, 45, 44;,
       3;46, 47, 40;,
       3;47, 41, 40;,
       3;48, 49, 32;,
       3;49, 33, 32;,
       3;38, 39, 50;,
       3;39, 51, 50;;

      MeshNormals {
       52;
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       0.000000; 0.999994; -0.003461;,
       -0.707107; 0.707103; -0.002448;,
       -0.707107; 0.707103; -0.002448;,
       0.076027; -0.997100; 0.003452;,
       0.076027; -0.997100; 0.003452;,
       -0.005107; -0.999981; 0.003462;,
       -0.086747; -0.996224; 0.003449;,
       -0.059425; -0.998227; 0.003456;,
       0.050429; -0.998722; 0.003457;,
       0.073303; -0.997304; 0.003452;,
       -0.012952; -0.999910; 0.003461;,
       -0.098477; -0.995133; 0.003445;,
       -0.098477; -0.995133; 0.003446;,
       1.000000; 0.000000; 0.000000;,
       1.000000; 0.000000; 0.000000;,
       1.000000; 0.000000; 0.000000;,
       1.000000; 0.000000; 0.000000;,
       0.000000; -0.000605; -1.000000;,
       0.000017; -0.000525; -1.000000;,
       0.000011; -0.000499; -1.000000;,
       -0.000040; -0.000598; -1.000000;,
       -1.000000; 0.000000; 0.000000;,
       -1.000000; 0.000000; 0.000000;,
       0.000024; -0.000599; -1.000000;,
       0.000004; -0.000499; -1.000000;,
       -0.000030; -0.000526; -1.000000;,
       -0.000060; -0.000605; -1.000000;,
       0.000000; 0.000605; 1.000000;,
       0.000022; 0.000526; 1.000000;,
       0.000015; 0.000499; 1.000000;,
       -0.000034; 0.000599; 1.000000;,
       0.000025; 0.000598; 1.000000;,
       0.000010; 0.000499; 1.000000;,
       -0.000023; 0.000525; 1.000000;,
       -0.000046; 0.000605; 1.000000;,
       -0.000077; -0.000675; -1.000000;,
       -0.000153; -0.000903; -1.000000;,
       0.000000; 0.000903; 1.000000;,
       0.000038; 0.000675; 1.000000;,
       0.000000; -0.000903; -1.000000;,
       0.000036; -0.000675; -1.000000;,
       -0.000072; 0.000675; 1.000000;,
       -0.000145; 0.000903; 1.000000;;
       36;
       3;0, 1, 2;,
       3;1, 3, 2;,
       3;2, 3, 4;,
       3;3, 5, 4;,
       3;6, 7, 8;,
       3;7, 9, 8;,
       3;8, 9, 10;,
       3;9, 11, 10;,
       3;12, 13, 14;,
       3;13, 15, 14;,
       3;14, 15, 16;,
       3;15, 17, 16;,
       3;16, 17, 18;,
       3;17, 19, 18;,
       3;18, 19, 20;,
       3;19, 21, 20;,
       3;22, 23, 24;,
       3;23, 25, 24;,
       3;26, 27, 28;,
       3;27, 29, 28;,
       3;11, 30, 10;,
       3;30, 31, 10;,
       3;32, 33, 34;,
       3;33, 35, 34;,
       3;36, 37, 38;,
       3;37, 39, 38;,
       3;40, 41, 42;,
       3;41, 43, 42;,
       3;28, 29, 44;,
       3;29, 45, 44;,
       3;46, 47, 40;,
       3;47, 41, 40;,
       3;48, 49, 32;,
       3;49, 33, 32;,
       3;38, 39, 50;,
       3;39, 51, 50;;
      }

      MeshTextureCoords {
       52;
       0.297227; 0.053925;,
       0.297227; 0.054363;,
       0.662825; 0.053925;,
       0.662825; 0.054363;,
       0.964319; 0.053925;,
       0.964319; 0.054363;,
       0.641964; 0.053925;,
       0.641964; 0.054363;,
       0.307729; 0.053925;,
       0.307729; 0.054363;,
       0.059879; 0.053925;,
       0.059879; 0.054363;,
       0.830413; 0.637188;,
       0.830413; 0.696702;,
       0.634125; 0.637188;,
       0.634125; 0.696702;,
       0.450313; 0.637188;,
       0.450313; 0.696702;,
       0.256580; 0.637188;,
       0.256580; 0.696702;,
       0.094427; 0.637188;,
       0.094427; 0.696702;,
       0.294785; 0.041718;,
       0.294785; 0.152427;,
       0.294785; 0.042156;,
       0.294785; 0.152861;,
       0.295159; 0.028569;,
       0.295159; 0.116026;,
       0.664414; 0.028569;,
       0.664414; 0.147116;,
       0.059879; 0.165068;,
       0.059879; 0.164631;,
       0.305767; 0.028569;,
       0.305767; 0.146900;,
       0.055119; 0.028569;,
       0.055119; 0.116026;,
       0.055119; 0.028224;,
       0.055119; 0.115681;,
       0.305767; 0.028224;,
       0.305767; 0.146554;,
       0.664414; 0.028224;,
       0.664414; 0.146773;,
       0.295159; 0.028224;,
       0.295159; 0.115684;,
       0.969079; 0.028569;,
       0.969079; 0.087124;,
       0.969079; 0.028224;,
       0.969079; 0.086778;,
       0.643344; 0.028569;,
       0.643344; 0.087124;,
       0.643344; 0.028224;,
       0.643344; 0.086778;;
      }

      MeshVertexColors {
       52;
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
       51; 1.000000; 1.000000; 1.000000; 1.000000;;
      }

      MeshMaterialList {
       2;
       36;
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
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

       Material inn_wood {
        0.820000; 0.830000; 0.870000; 1.000000;;
        128.000000;
        0.820000; 0.830000; 0.870000;;
        0.000000; 0.000000; 0.000000;;

        TextureFilename {
         "inn_wood.dds";
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
       52;
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
       51;
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
