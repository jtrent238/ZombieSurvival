xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.15
// Time: Mon Aug 10 19:36:37 2009

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
    24;
    0.932750; 0.249500; -2.363258;,
    0.932750; 0.129303; -2.363953;,
    -0.981450; 0.249401; -2.336853;,
    -0.981450; 0.129200; -2.337456;,
    -1.269051; 0.051601; -2.232857;,
    -1.313650; 0.025402; -2.165756;,
    -1.269051; 0.348499; -2.231155;,
    -1.313650; 0.374001; -2.163757;,
    1.222549; 0.051800; -2.259354;,
    1.268450; 0.025501; -2.192253;,
    1.222549; 0.348602; -2.257652;,
    1.268450; 0.374100; -2.190254;,
    -1.268450; 0.348602; 2.299042;,
    -1.268450; 0.000000; 2.297043;,
    1.313650; 0.348801; 2.272545;,
    1.313650; 0.000099; 2.270546;,
    -1.313650; 0.025402; -2.165756;,
    1.268450; 0.025501; -2.192253;,
    -1.268450; 0.000000; 2.297043;,
    1.313650; 0.000099; 2.270546;,
    -1.230451; 0.322800; 2.363945;,
    -1.230451; 0.025002; 2.362244;,
    1.276950; 0.323002; 2.338242;,
    1.276950; 0.025200; 2.336548;;
    36;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;5, 7, 6;,
    3;8, 9, 4;,
    3;9, 5, 4;,
    3;6, 7, 10;,
    3;7, 11, 10;,
    3;10, 11, 8;,
    3;11, 9, 8;,
    3;3, 4, 2;,
    3;4, 6, 2;,
    3;2, 6, 0;,
    3;6, 10, 0;,
    3;1, 8, 3;,
    3;8, 4, 3;,
    3;0, 10, 1;,
    3;10, 8, 1;,
    3;7, 5, 12;,
    3;5, 13, 12;,
    3;11, 7, 14;,
    3;7, 12, 14;,
    3;9, 11, 15;,
    3;11, 14, 15;,
    3;16, 17, 18;,
    3;17, 19, 18;,
    3;20, 21, 22;,
    3;21, 23, 22;,
    3;12, 13, 20;,
    3;13, 21, 20;,
    3;21, 13, 23;,
    3;13, 15, 23;,
    3;14, 12, 22;,
    3;12, 20, 22;,
    3;15, 14, 23;,
    3;14, 22, 23;;

   MeshNormals {
    24;
    0.116069; 0.265385; -0.957130;,
    0.120249; -0.300044; -0.946316;,
    -0.132127; 0.264925; -0.955174;,
    -0.135869; -0.299528; -0.944364;,
    -0.368462; -0.538853; -0.757544;,
    -0.652570; -0.685154; -0.323600;,
    -0.364093; 0.509665; -0.779537;,
    -0.652504; 0.688225; -0.317152;,
    0.359517; -0.539119; -0.761642;,
    0.647175; -0.684961; -0.334654;,
    0.354530; 0.510024; -0.783699;,
    0.647115; 0.688136; -0.328196;,
    -0.659158; 0.683014; 0.314646;,
    -0.659169; -0.686667; 0.306568;,
    0.665320; 0.683076; 0.301258;,
    0.665310; -0.686589; 0.293186;,
    -0.652570; -0.685154; -0.323600;,
    0.647175; -0.684961; -0.334654;,
    -0.659169; -0.686667; 0.306568;,
    0.665310; -0.686589; 0.293186;,
    -0.377129; 0.409023; 0.830948;,
    -0.377215; -0.418718; 0.826065;,
    0.393915; 0.409036; 0.823116;,
    0.393997; -0.418641; 0.818234;;
    36;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;5, 7, 6;,
    3;8, 9, 4;,
    3;9, 5, 4;,
    3;6, 7, 10;,
    3;7, 11, 10;,
    3;10, 11, 8;,
    3;11, 9, 8;,
    3;3, 4, 2;,
    3;4, 6, 2;,
    3;2, 6, 0;,
    3;6, 10, 0;,
    3;1, 8, 3;,
    3;8, 4, 3;,
    3;0, 10, 1;,
    3;10, 8, 1;,
    3;7, 5, 12;,
    3;5, 13, 12;,
    3;11, 7, 14;,
    3;7, 12, 14;,
    3;9, 11, 15;,
    3;11, 14, 15;,
    3;16, 17, 18;,
    3;17, 19, 18;,
    3;20, 21, 22;,
    3;21, 23, 22;,
    3;12, 13, 20;,
    3;13, 21, 20;,
    3;21, 13, 23;,
    3;13, 15, 23;,
    3;14, 12, 22;,
    3;12, 20, 22;,
    3;15, 14, 23;,
    3;14, 22, 23;;
   }

   MeshTextureCoords {
    24;
    0.482577; 0.081027;,
    0.482577; 0.080905;,
    0.150582; 0.085663;,
    0.150582; 0.085557;,
    0.100701; 0.103920;,
    0.092965; 0.115699;,
    0.100701; 0.104218;,
    0.092965; 0.116050;,
    0.532840; 0.099268;,
    0.540800; 0.111048;,
    0.532840; 0.099567;,
    0.540800; 0.111399;,
    0.100805; 0.899511;,
    0.100805; 0.899160;,
    0.548640; 0.894860;,
    0.548640; 0.894509;,
    0.698138; 0.141801;,
    0.931013; 0.137196;,
    0.702215; 0.917427;,
    0.935089; 0.912822;,
    0.107395; 0.910905;,
    0.107395; 0.910607;,
    0.542275; 0.906393;,
    0.542275; 0.906096;;
   }

   MeshVertexColors {
    24;
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
    23; 1.000000; 1.000000; 1.000000; 1.000000;;
   }

   MeshMaterialList {
    1;
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

    Material def_surf_mat {
     0.992157; 0.992157; 0.992157; 1.000000;;
     128.000000;
     0.150000; 0.150000; 0.150000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "cellphone.dds";
     }
    }

   }
  }
}
