xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.13
// Time: Sun Mar 22 17:51:39 2009

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
    48;
    4.949890; 0.194766; -2.857830;,
    5.715640; 0.194766; 0.000000;,
    4.632230; -0.173154; -2.674430;,
    5.348850; -0.173154; 0.000000;,
    2.857820; 0.194766; -4.949900;,
    2.674420; -0.173154; -4.632260;,
    -0.000009; 0.194766; -5.715650;,
    -0.000009; -0.173154; -5.348860;,
    -2.857840; 0.194766; -4.949900;,
    -2.674460; -0.173154; -4.632260;,
    -4.949900; 0.194766; -2.857840;,
    -4.632250; -0.173154; -2.674430;,
    -5.715650; 0.194766; 0.000000;,
    -5.348850; -0.173154; 0.000000;,
    -4.949900; 0.194766; 2.857830;,
    -4.632250; -0.173154; 2.674410;,
    -2.857840; 0.194766; 4.949900;,
    -2.674460; -0.173154; 4.632240;,
    -0.000009; 0.194766; 5.715650;,
    -0.000009; -0.173154; 5.348840;,
    2.857820; 0.194766; 4.949900;,
    2.674420; -0.173154; 4.632240;,
    4.949890; 0.194766; 2.857830;,
    4.632230; -0.173154; 2.674410;,
    5.348850; -0.173154; 0.000000;,
    4.632230; -0.173154; 2.674410;,
    4.632230; -0.173154; -2.674430;,
    2.674420; -0.173154; 4.632240;,
    2.674420; -0.173154; -4.632260;,
    -0.000009; -0.173154; 5.348840;,
    -0.000009; -0.173154; -5.348860;,
    -2.674460; -0.173154; 4.632240;,
    -2.674460; -0.173154; -4.632260;,
    -4.632250; -0.173154; 2.674410;,
    -4.632250; -0.173154; -2.674430;,
    -5.348850; -0.173154; 0.000000;,
    2.340510; 0.035457; -4.053940;,
    4.053910; 0.035457; -2.340520;,
    -0.000009; 0.035457; -4.681050;,
    -2.340550; 0.035457; -4.053940;,
    -4.053930; 0.035457; -2.340520;,
    -4.681040; 0.035457; 0.000000;,
    -4.053930; 0.035457; 2.340520;,
    -2.340550; 0.035457; 4.053890;,
    -0.000009; 0.035457; 4.681030;,
    2.340510; 0.035457; 4.053890;,
    4.053910; 0.035457; 2.340510;,
    4.681040; 0.035457; 0.000000;;
    68;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 0, 5;,
    3;0, 2, 5;,
    3;6, 4, 7;,
    3;4, 5, 7;,
    3;8, 6, 9;,
    3;6, 7, 9;,
    3;10, 8, 11;,
    3;8, 9, 11;,
    3;12, 10, 13;,
    3;10, 11, 13;,
    3;14, 12, 15;,
    3;12, 13, 15;,
    3;16, 14, 17;,
    3;14, 15, 17;,
    3;18, 16, 19;,
    3;16, 17, 19;,
    3;20, 18, 21;,
    3;18, 19, 21;,
    3;22, 20, 23;,
    3;20, 21, 23;,
    3;1, 22, 3;,
    3;22, 23, 3;,
    3;24, 25, 26;,
    3;25, 27, 26;,
    3;26, 27, 28;,
    3;27, 29, 28;,
    3;28, 29, 30;,
    3;29, 31, 30;,
    3;30, 31, 32;,
    3;31, 33, 32;,
    3;32, 33, 34;,
    3;33, 35, 34;,
    3;36, 37, 4;,
    3;37, 0, 4;,
    3;38, 36, 6;,
    3;36, 4, 6;,
    3;39, 38, 8;,
    3;38, 6, 8;,
    3;40, 39, 10;,
    3;39, 8, 10;,
    3;41, 40, 12;,
    3;40, 10, 12;,
    3;42, 41, 14;,
    3;41, 12, 14;,
    3;43, 42, 16;,
    3;42, 14, 16;,
    3;44, 43, 18;,
    3;43, 16, 18;,
    3;45, 44, 20;,
    3;44, 18, 20;,
    3;46, 45, 22;,
    3;45, 20, 22;,
    3;47, 46, 1;,
    3;46, 22, 1;,
    3;37, 47, 0;,
    3;47, 1, 0;,
    3;47, 37, 46;,
    3;37, 36, 46;,
    3;46, 36, 45;,
    3;36, 38, 45;,
    3;45, 38, 44;,
    3;38, 39, 44;,
    3;44, 39, 43;,
    3;39, 40, 43;,
    3;43, 40, 42;,
    3;40, 41, 42;;

   MeshNormals {
    48;
    0.761856; 0.475501; -0.439856;,
    0.879716; 0.475499; -0.000004;,
    0.436122; -0.863943; -0.251793;,
    0.503587; -0.863945; -0.000002;,
    0.439854; 0.475504; -0.761855;,
    0.251794; -0.863941; -0.436125;,
    0.000000; 0.475508; -0.879711;,
    0.000001; -0.863939; -0.503597;,
    -0.439857; 0.475511; -0.761850;,
    -0.251802; -0.863936; -0.436130;,
    -0.761848; 0.475511; -0.439860;,
    -0.436129; -0.863938; -0.251801;,
    -0.879716; 0.475500; 0.000000;,
    -0.503588; -0.863944; -0.000000;,
    -0.761860; 0.475495; 0.439856;,
    -0.436116; -0.863947; 0.251790;,
    -0.439857; 0.475497; 0.761859;,
    -0.251791; -0.863947; 0.436116;,
    -0.000003; 0.475495; 0.879718;,
    -0.000001; -0.863947; 0.503583;,
    0.439861; 0.475494; 0.761858;,
    0.251791; -0.863948; 0.436114;,
    0.761858; 0.475495; 0.439860;,
    0.436115; -0.863947; 0.251791;,
    0.503587; -0.863945; -0.000002;,
    0.436115; -0.863947; 0.251791;,
    0.436122; -0.863943; -0.251793;,
    0.251791; -0.863948; 0.436114;,
    0.251794; -0.863941; -0.436125;,
    -0.000001; -0.863947; 0.503583;,
    0.000001; -0.863939; -0.503597;,
    -0.251791; -0.863947; 0.436116;,
    -0.251802; -0.863936; -0.436130;,
    -0.436116; -0.863947; 0.251790;,
    -0.436129; -0.863938; -0.251801;,
    -0.503588; -0.863944; -0.000000;,
    -0.050847; 0.994816; 0.088071;,
    -0.088070; 0.994816; 0.050847;,
    -0.000001; 0.994815; 0.101696;,
    0.050848; 0.994816; 0.088071;,
    0.088072; 0.994815; 0.050847;,
    0.101695; 0.994816; 0.000000;,
    0.088070; 0.994816; -0.050847;,
    0.050847; 0.994816; -0.088069;,
    -0.000000; 0.994816; -0.101693;,
    -0.050846; 0.994816; -0.088068;,
    -0.088069; 0.994816; -0.050846;,
    -0.101695; 0.994816; -0.000000;;
    68;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 0, 5;,
    3;0, 2, 5;,
    3;6, 4, 7;,
    3;4, 5, 7;,
    3;8, 6, 9;,
    3;6, 7, 9;,
    3;10, 8, 11;,
    3;8, 9, 11;,
    3;12, 10, 13;,
    3;10, 11, 13;,
    3;14, 12, 15;,
    3;12, 13, 15;,
    3;16, 14, 17;,
    3;14, 15, 17;,
    3;18, 16, 19;,
    3;16, 17, 19;,
    3;20, 18, 21;,
    3;18, 19, 21;,
    3;22, 20, 23;,
    3;20, 21, 23;,
    3;1, 22, 3;,
    3;22, 23, 3;,
    3;24, 25, 26;,
    3;25, 27, 26;,
    3;26, 27, 28;,
    3;27, 29, 28;,
    3;28, 29, 30;,
    3;29, 31, 30;,
    3;30, 31, 32;,
    3;31, 33, 32;,
    3;32, 33, 34;,
    3;33, 35, 34;,
    3;36, 37, 4;,
    3;37, 0, 4;,
    3;38, 36, 6;,
    3;36, 4, 6;,
    3;39, 38, 8;,
    3;38, 6, 8;,
    3;40, 39, 10;,
    3;39, 8, 10;,
    3;41, 40, 12;,
    3;40, 10, 12;,
    3;42, 41, 14;,
    3;41, 12, 14;,
    3;43, 42, 16;,
    3;42, 14, 16;,
    3;44, 43, 18;,
    3;43, 16, 18;,
    3;45, 44, 20;,
    3;44, 18, 20;,
    3;46, 45, 22;,
    3;45, 20, 22;,
    3;47, 46, 1;,
    3;46, 22, 1;,
    3;37, 47, 0;,
    3;47, 1, 0;,
    3;47, 37, 46;,
    3;37, 36, 46;,
    3;46, 36, 45;,
    3;36, 38, 45;,
    3;45, 38, 44;,
    3;38, 39, 44;,
    3;44, 39, 43;,
    3;39, 40, 43;,
    3;43, 40, 42;,
    3;40, 41, 42;;
   }

   MeshTextureCoords {
    48;
    0.702574; 0.389096;,
    0.735667; 0.512600;,
    0.688846; 0.397022;,
    0.719815; 0.512600;,
    0.612163; 0.298685;,
    0.604237; 0.312413;,
    0.488659; 0.265593;,
    0.488659; 0.281444;,
    0.365155; 0.298685;,
    0.373080; 0.312413;,
    0.274744; 0.389096;,
    0.288472; 0.397022;,
    0.241651; 0.512600;,
    0.257503; 0.512600;,
    0.274744; 0.636105;,
    0.288472; 0.628179;,
    0.365155; 0.726516;,
    0.373080; 0.712788;,
    0.488659; 0.759609;,
    0.488659; 0.743757;,
    0.612163; 0.726516;,
    0.604237; 0.712788;,
    0.702574; 0.636105;,
    0.688846; 0.628179;,
    0.578410; 0.546623;,
    0.561996; 0.607879;,
    0.561996; 0.485366;,
    0.517153; 0.652722;,
    0.517153; 0.440523;,
    0.455897; 0.669136;,
    0.455897; 0.424110;,
    0.394640; 0.652722;,
    0.394640; 0.440523;,
    0.349798; 0.607879;,
    0.349798; 0.485366;,
    0.333384; 0.546623;,
    0.589807; 0.337406;,
    0.663853; 0.411452;,
    0.488659; 0.310304;,
    0.387510; 0.337406;,
    0.313464; 0.411452;,
    0.286363; 0.512600;,
    0.313464; 0.613749;,
    0.387510; 0.687794;,
    0.488659; 0.714897;,
    0.589807; 0.687794;,
    0.663853; 0.613748;,
    0.690955; 0.512600;;
   }

   MeshVertexColors {
    48;
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
    47; 1.000000; 1.000000; 1.000000; 1.000000;;
   }

   MeshMaterialList {
    1;
    68;
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
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

    Material ec_plate {
     1.000000; 1.000000; 1.000000; 1.000000;;
     128.000000;
     1.000000; 1.000000; 1.000000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "ec_plate.jpg";
     }
    }

   }
  }
}
