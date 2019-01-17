xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.18
// Time: Fri Sep 11 10:37:59 2009

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
    20;
    16.520100; 73.750397; -0.551406;,
    -16.520100; 73.750397; -0.551406;,
    16.520100; 73.750397; 0.570042;,
    -16.520100; 73.750397; 0.570042;,
    16.520100; 47.590000; -0.551406;,
    16.520100; 47.590000; 0.570042;,
    -16.520100; 47.590000; -0.551406;,
    -16.520100; 47.590000; 0.570042;,
    -11.794900; 52.315300; 0.570042;,
    -11.794900; 69.025200; 0.570042;,
    11.794900; 52.315300; 0.570042;,
    11.794900; 69.025200; 0.570042;,
    11.794900; 69.025200; -0.570042;,
    -11.794900; 69.025200; -0.570042;,
    11.794900; 52.315300; -0.570042;,
    -11.794900; 52.315300; -0.570042;,
    -11.794900; 69.025200; -0.570042;,
    -11.794900; 52.315300; -0.570042;,
    11.794900; 69.025200; -0.570042;,
    11.794900; 52.315300; -0.570042;;
    28;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 0, 5;,
    3;0, 2, 5;,
    3;6, 4, 7;,
    3;4, 5, 7;,
    3;1, 6, 3;,
    3;6, 7, 3;,
    3;4, 6, 0;,
    3;6, 1, 0;,
    3;8, 9, 7;,
    3;9, 3, 7;,
    3;10, 8, 5;,
    3;8, 7, 5;,
    3;11, 10, 2;,
    3;10, 5, 2;,
    3;9, 11, 3;,
    3;11, 2, 3;,
    3;12, 13, 14;,
    3;13, 15, 14;,
    3;16, 9, 17;,
    3;9, 8, 17;,
    3;18, 11, 16;,
    3;11, 9, 16;,
    3;17, 8, 19;,
    3;8, 10, 19;,
    3;19, 10, 18;,
    3;10, 11, 18;;

   MeshNormals {
    20;
    0.666667; 0.333333; -0.666667;,
    -0.408248; 0.816497; -0.408248;,
    0.267261; 0.534522; 0.801784;,
    -0.534522; 0.267261; 0.801784;,
    0.408248; -0.816497; -0.408248;,
    0.534522; -0.267261; 0.801784;,
    -0.666667; -0.333333; -0.666667;,
    -0.267261; -0.534522; 0.801784;,
    0.267261; 0.534522; 0.801784;,
    0.534522; -0.267261; 0.801784;,
    -0.534522; 0.267261; 0.801784;,
    -0.267261; -0.534522; 0.801784;,
    0.000000; 0.000000; 1.000000;,
    0.000000; 0.000000; 1.000000;,
    0.000000; 0.000000; 1.000000;,
    0.000000; 0.000000; 1.000000;,
    0.447214; -0.894427; 0.000000;,
    0.894427; 0.447214; 0.000000;,
    -0.894427; -0.447214; 0.000000;,
    -0.447214; 0.894427; 0.000000;;
    28;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 0, 5;,
    3;0, 2, 5;,
    3;6, 4, 7;,
    3;4, 5, 7;,
    3;1, 6, 3;,
    3;6, 7, 3;,
    3;4, 6, 0;,
    3;6, 1, 0;,
    3;8, 9, 7;,
    3;9, 3, 7;,
    3;10, 8, 5;,
    3;8, 7, 5;,
    3;11, 10, 2;,
    3;10, 5, 2;,
    3;9, 11, 3;,
    3;11, 2, 3;,
    3;12, 13, 14;,
    3;13, 15, 14;,
    3;16, 9, 17;,
    3;9, 8, 17;,
    3;18, 11, 16;,
    3;11, 9, 16;,
    3;17, 8, 19;,
    3;8, 10, 19;,
    3;19, 10, 18;,
    3;10, 11, 18;;
   }

   MeshTextureCoords {
    20;
    0.919351; 0.165671;,
    0.080649; 0.165671;,
    0.931210; 0.153946;,
    0.068790; 0.153946;,
    0.919351; 0.834330;,
    0.931210; 0.846055;,
    0.080649; 0.834330;,
    0.068790; 0.846055;,
    0.182616; 0.731050;,
    0.182615; 0.266002;,
    0.815911; 0.731049;,
    0.815910; 0.266001;,
    0.809580; 0.278912;,
    0.190421; 0.278911;,
    0.809579; 0.721090;,
    0.190420; 0.721089;,
    0.175680; 0.262696;,
    0.175679; 0.734356;,
    0.822846; 0.262697;,
    0.822846; 0.734357;;
   }

   MeshVertexColors {
    20;
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
    19; 1.000000; 1.000000; 1.000000; 1.000000;;
   }

   MeshMaterialList {
    1;
    28;
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
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

    Material ec_wallpicture3 {
     1.000000; 1.000000; 1.000000; 1.000000;;
     128.000000;
     1.000000; 1.000000; 1.000000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "wallpicture3.dds";
     }
    }

   }
  }
}
