// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gl/flutter_gl.dart';
// import 'package:three_dart/three_dart.dart' as THREE;
// import 'package:three_dart/extra/loaders/OBJLoader.dart';
//
// class MugTextureApp extends StatefulWidget {
//   const MugTextureApp({super.key});
//
//   @override
//   State<MugTextureApp> createState() => _MugTextureAppState();
// }
//
// class _MugTextureAppState extends State<MugTextureApp> {
//   late FlutterGlPlugin renderer;
//   THREE.WebGLRenderer? threeRenderer;
//   THREE.Scene? scene;
//   THREE.Camera? camera;
//   THREE.Mesh? mesh;
//   double width = 300;
//   double height = 300;
//
//   late Size screenSize;
//   bool isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, initRenderer);
//   }
//
//   Future<void> initRenderer() async {
//     screenSize = MediaQuery.of(context).size;
//     width = screenSize.width;
//     height = screenSize.height;
//
//     renderer = FlutterGlPlugin();
//     await renderer.initialize(options: {
//       "antialias": true,
//       "alpha": true,
//       "width": width.toInt(),
//       "height": height.toInt(),
//       "dpr": MediaQuery.of(context).devicePixelRatio
//     });
//
//     setState(() {});
//     await renderer.prepareContext();
//
//     setupScene();
//     animate();
//   }
//
//   Future<void> setupScene() async {
//     final gl = renderer.gl;
//     threeRenderer = THREE.WebGLRenderer({"canvas": renderer.element, "gl": gl});
//     threeRenderer!.setSize(width, height);
//
//     scene = THREE.Scene();
//     camera = THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
//     camera!.position.z = 2;
//
//     final loader = GLTFLoader();
//     final bytes = await rootBundle.load('assets/white_mug.glb');
//     final gltf = await loader.parseAsync(bytes.buffer.asUint8List());
//
//     final textureLoader = THREE.TextureLoader();
//     final texture = await textureLoader.loadAsync('assets/mug_logo.png');
//
//     gltf.scene.traverse((child) {
//       if (child is THREE.Mesh) {
//         child.material.map = texture;
//         child.material.needsUpdate = true;
//       }
//     });
//
//     scene!.add(gltf.scene);
//   }
//
//   void animate() {
//     Future.doWhile(() async {
//       render();
//       await Future.delayed(const Duration(milliseconds: 16));
//       return true;
//     });
//   }
//
//   void render() {
//     if (scene != null && camera != null) {
//       threeRenderer?.render(scene!, camera!);
//       renderer.gl.flush();
//     }
//   }
//
//   @override
//   void dispose() {
//     renderer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: renderer.isInitialized
//             ? Texture(textureId: renderer.textureId!)
//             : const CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//
// void main() => runApp(const MaterialApp(home: MugTextureApp()));
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';


class CupScene extends StatefulWidget {
  const CupScene({super.key});

  @override
  State<CupScene> createState() => _CupSceneState();
}

class _CupSceneState extends State<CupScene> {
  bool changeModel = false;

  /// new jitaku models
  String cup1 = 'assets/jitaku/Heart_Boolean.obj';
  String lid1 = 'assets/jitaku/lid.obj';
  String canister = 'assets/jitaku/Canister.obj';
  String newHandle1 = 'assets/jitaku/handle-01.obj';
  String newHandle2 = 'assets/jitaku/handle-02.obj';
  String newHeartHandle = 'assets/jitaku/Heart.obj';
  String normal = 'assets/jitaku/Nomal.obj';

  String srcObj = '';

  @override
  void initState() {
    super.initState();
    srcObj = cup1;
  }
  double angleY = 0;

  double posX = 0;

  void rotateObject() {
    setState(() {
      angleY += 10; // increase by 10°
    });
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('angleY: $angleY');
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter cube')),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child:
            Cube(
              key: ValueKey("$srcObj-$angleY-$posX"),
              onSceneCreated: (Scene scene) {
                final obj = Object(fileName: srcObj);
                obj.position.setValues(posX, 0, 0);
                obj.rotation.setValues(0, angleY, 0);
                scene.world.add(obj);
                scene.camera.zoom = 5;
              },
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'cup obj',
                onPressed: () {
                  setState(() {
                    srcObj = cup1;
                    angleY += 30;
                    posX += 1;
                    rotateObject();
                  });
                },
                icon: const Icon(Icons.looks_one),
              ),
              IconButton(
                tooltip: 'canister obj',
                onPressed: () {
                  setState(() {
                    srcObj = canister;
                  });
                },
                icon: const Icon(Icons.looks_two),
              ),
              IconButton(
                tooltip: 'lid obj',
                onPressed: () {
                  setState(() {
                    srcObj = lid1;
                  });
                },
                icon: const Icon(Icons.looks_3),
              ),
              IconButton(
                tooltip: 'normal obj',
                onPressed: () {
                  setState(() {
                    srcObj = normal;
                  });
                },
                icon: const Icon(Icons.looks_4),
              ),
              IconButton(
                tooltip: 'Heart obj',
                onPressed: () {
                  setState(() {
                    srcObj = newHeartHandle;
                  });
                },
                icon: const Icon(Icons.looks_5),
              ),
              IconButton(
                tooltip: changeModel ? 'handle 1 obj' : 'handle 2 obj',
                onPressed: () {
                  setState(() {
                    changeModel = !changeModel;
                    srcObj = changeModel ? newHandle1 : newHandle2;
                  });
                },
                icon: const Icon(Icons.looks_6, size: 30),
              ),
            ],
          )
        ],
      ),
    );
  }
}
