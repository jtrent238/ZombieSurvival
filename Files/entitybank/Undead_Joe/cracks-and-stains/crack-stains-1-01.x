xof 0303txt 0032

Frame Root {
  FrameTransformMatrix {
     1.000000, 0.000000, 0.000000, 0.000000,
     0.000000,-0.000000, 1.000000, 0.000000,
     0.000000, 1.000000, 0.000000, 0.000000,
     0.000000, 0.000000, 0.000000, 1.000000;;
  }
  Frame Box01 {
    FrameTransformMatrix {
      -0.009048, 0.000000,-0.999959, 0.000000,
       0.999959,-0.000016,-0.009048, 0.000000,
      -0.000016,-1.000000, 0.000000, 0.000000,
      -1.019086, 0.090625, 2.604197, 1.000000;;
    }
    Mesh { // Box01 mesh
      6;
       2.595000; 0.000000;-2.595000;,
      -2.595000; 0.000000;-2.595000;,
      -2.595000; 0.000000; 2.595000;,
      -2.595000; 0.000000; 2.595000;,
       2.595000; 0.000000; 2.595000;,
       2.595000; 0.000000;-2.595000;;
      2;
      3;2,1,0;,
      3;5,4,3;;
      MeshNormals { // Box01 normals
        6;
         0.000000; 1.000000; 0.000000;,
         0.000000; 1.000000; 0.000000;,
         0.000000; 1.000000; 0.000000;,
         0.000000; 1.000000; 0.000000;,
         0.000000; 1.000000; 0.000000;,
         0.000000; 1.000000; 0.000000;;
        2;
        3;2,1,0;,
        3;5,4,3;;
      } // End of Box01 normals
      MeshTextureCoords { // Box01 UV coordinates
        6;
         0.999500; 0.999500;,
         0.000500; 0.999500;,
         0.000500; 0.000500;,
         0.000500; 0.000500;,
         0.999500; 0.000500;,
         0.999500; 0.999500;;
      } // End of Box01 UV coordinates
      MeshMaterialList { // Box01 material list
        1;
        2;
        0,
        0;
        Material DefaultMaterial {
           0.640000; 0.640000; 0.640000; 1.000000;;
           96.078431;
           0.500000; 0.500000; 0.500000;;
           0.000000; 0.000000; 0.000000;;
        }
      } // End of Box01 material list
    } // End of Box01 mesh
  } // End of Box01
} // End of Root
