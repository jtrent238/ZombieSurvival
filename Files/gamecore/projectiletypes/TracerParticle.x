xof 0303txt 0032
template XSkinMeshHeader {
 <3cf169ce-ff7c-44ab-93c0-f78f62d172e2>
 WORD nMaxSkinWeightsPerVertex;
 WORD nMaxSkinWeightsPerFace;
 WORD nBones;
}

template VertexDuplicationIndices {
<b8d65549-d7c9-4995-89cf-53a9a8b031e3>
 DWORD nIndices;
 DWORD nOriginalVertices;
 array DWORD indices[nIndices];
}

template SkinWeights {
 <6f0d123b-bad2-4167-a0d0-80224f25fabb>
 STRING transformNodeName;
 DWORD nWeights;
 array DWORD vertexIndices[nWeights];
 array FLOAT weights[nWeights];
 Matrix4x4 matrixOffset;
}


Frame Scene_Root {


 FrameTransformMatrix {
  1.000000, 0.000000, 0.000000, 0.000000,
  0.000000, 1.000000, 0.000000, 0.000000,
  0.000000, 0.000000, 1.000000, 0.000000,
  0.000000, 0.000000, 0.000000, 1.000000;;
 }

  Frame Regroup00 {

   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh {
    8;
    0.500000;0.000000;-0.500000;,
    0.500000;0.000000;0.500000;,
    -0.500000;0.000000;0.500000;,
    -0.500000;0.000000;-0.500000;,
    0.000000;0.500000;-0.500000;,
    0.000000;0.500000;0.500000;,
    0.000000;-0.500000;0.500000;,
    0.000000;-0.500000;-0.500000;;
    4;
    3;0,2,1;,
    3;0,3,2;,
    3;4,6,5;,
    3;4,7,6;;

    MeshNormals {
     8;
     0.000000;1.000000;-0.000000;,
     0.000000;1.000000;-0.000000;,
     0.000000;1.000000;-0.000000;,
     0.000000;1.000000;-0.000000;,
     -1.000000;0.000000;-0.000000;,
     -1.000000;0.000000;-0.000000;,
     -1.000000;0.000000;-0.000000;,
     -1.000000;0.000000;-0.000000;;
     4;
     3;0,2,1;,
     3;0,3,2;,
     3;4,6,5;,
     3;4,7,6;;
    }

    MeshTextureCoords {
     8;
     0.000000;0.000000;,
     0.000000;1.000000;,
     1.000000;1.000000;,
     1.000000;0.000000;,
     0.000000;0.000000;,
     0.000000;1.000000;,
     1.000000;1.000000;,
     1.000000;0.000000;;
    }

    VertexDuplicationIndices {
     8;
     8;
     0,
     1,
     2,
     3,
     4,
     5,
     6,
     7;
    }

    MeshMaterialList {
     1;
     4;
     0,
     0,
     0,
     0;

     Material DefaultMat {
      0.800000;0.800000;0.800000;0.000000;;
      0.000000;
      0.000000;0.000000;0.000000;;
      0.000000;0.000000;0.000000;;
     }
    }

   }
 }
 }
}
