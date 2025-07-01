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
