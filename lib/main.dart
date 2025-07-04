/// flutter gl working code for rendering 3d model and showing
// import 'dart:convert';
// import 'dart:io' as controller;

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

// import 'htmlThreeDModel.dart';

// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// Setup FlutterGL and Three.js runtime


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 3D Controller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home:
      // const MugTextureApp(),
      // const WebViewExample(),
      MyHomePage(title: 'Flutter 3D Controller Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Flutter3DController controller = Flutter3DController();
  String? chosenAnimation;
  String? chosenTexture;
  bool changeModel = false;
  String shirtObj = 'assets/shirt/Shirt_on_Hanger.obj';
  String SPORTSHIRT = 'assets/sportsShirt/SPORTSHIRT.obj';
    String spidyShirtObj = 'assets/spidyShirt/objShirt.obj';
  String mugObj = 'assets/black_mug.obj';
  String srcGlb = 'assets/white_mug.glb';
  String srcObj = '';

  @override
  void initState() {
    super.initState();
    srcObj = shirtObj;
    controller.onModelLoaded.addListener(() {
      debugPrint('model is loaded : ${controller.onModelLoaded.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2039),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// not needed for obj file
          /// this functions are for glb file
          // IconButton(
          //   onPressed: () {
          //     // controller.playAnimation();
          //   },
          //   icon: const Icon(Icons.next_plan_outlined),
          // ),
          // IconButton(
          //   onPressed: () {
          //     controller.playAnimation();
          //   },
          //   icon: const Icon(Icons.play_arrow),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // IconButton(
          //   onPressed: () {
          //     controller.pauseAnimation();
          //     //controller.stopAnimation();
          //   },
          //   icon: const Icon(Icons.pause),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // IconButton(
          //   onPressed: () {
          //     controller.resetAnimation();
          //   },
          //   icon: const Icon(Icons.replay),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // IconButton(
          //   onPressed: () async {
          //     List<String> availableAnimations =
          //     await controller.getAvailableAnimations();
          //     debugPrint(
          //         'Animations : $availableAnimations --- Length : ${availableAnimations.length}');
          //     chosenAnimation = await showPickerDialog(
          //         'Animations', availableAnimations, chosenAnimation);
          //     //Play animation with loop count
          //     controller.playAnimation(
          //       animationName: chosenAnimation,
          //       loopCount: 2,
          //     );
          //   },
          //   icon: const Icon(Icons.format_list_bulleted_outlined),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // IconButton(
          //   onPressed: () async {
          //     List<String> availableTextures =
          //     await controller.getAvailableTextures();
          //     debugPrint(
          //         'Textures : $availableTextures --- Length : ${availableTextures.length}');
          //     chosenTexture = await showPickerDialog(
          //         'Textures', availableTextures, chosenTexture);
          //     controller.setTexture(textureName: chosenTexture ?? '');
          //   },
          //   icon: const Icon(Icons.list_alt_rounded),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // IconButton(
          //   onPressed: () {
          //     controller.setCameraOrbit(20, 20, 5);
          //     //controller.setCameraTarget(0.3, 0.2, 0.4);
          //   },
          //   icon: const Icon(Icons.camera_alt_outlined),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // IconButton(
          //   onPressed: () {
          //     controller.resetCameraOrbit();
          //     //controller.resetCameraTarget();
          //   },
          //   icon: const Icon(Icons.cameraswitch_outlined),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          IconButton(
            onPressed: () {
              setState(() {
                changeModel = !changeModel;
                chosenAnimation = null;
                chosenTexture = null;
                if (changeModel) {
                  srcObj = shirtObj;
                  srcGlb = 'assets/sheen_chair.glb';
                } else {
                  srcObj = spidyShirtObj;
                  srcGlb = 'assets/white_mug.glb';
                }
              });
            },
            icon: const Icon(
              Icons.restore_page_outlined,
              size: 30,
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          gradient: RadialGradient(
            colors: [
              Color(0xff919ded),
              Colors.grey,
            ],
            stops: [0.1, 1.0],
            radius: 0.7,
            center: Alignment.center,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Flutter3DViewer.obj(
                src: srcObj,
                //src : 'assets/flutter_dash.obj',
                //src: 'https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/flutter_dash_model/flutter_dash.obj',
                scale: 5,
                // Initial scale of obj model
                cameraX: 0,
                // Initial cameraX position of obj model
                cameraY: 0,
                //Initial cameraY position of obj model
                cameraZ: 10,
                //Initial cameraZ position of obj model
                //This callBack will return the loading progress value between 0 and 1.0
                onProgress: (double progressValue) {
                  debugPrint('model loading progress : $progressValue');
                },
                //This callBack will call after model loaded successfully and will return model address
                onLoad: (String modelAddress) {
                  debugPrint('model loaded : $modelAddress');
                },
                //this callBack will call when model failed to load and will return failure erro
                onError: (String error) {
                  debugPrint('model failed to load : $error');
                },
              ),
            ),
            // Flexible(
            //   flex: 1,
            //   child: Flutter3DViewer(
            //     //If you pass 'true' the flutter_3d_controller will add gesture interceptor layer
            //     //to prevent gesture recognizers from malfunctioning on iOS and some Android devices.
            //     // the default value is true.
            //     activeGestureInterceptor: true,
            //     //If you don't pass progressBarColor, the color of defaultLoadingProgressBar will be grey.
            //     //You can set your custom color or use [Colors.transparent] for hiding loadingProgressBar.
            //     progressBarColor: Colors.orange,
            //     //You can disable viewer touch response by setting 'enableTouch' to 'false'
            //     enableTouch: true,
            //     //This callBack will return the loading progress value between 0 and 1.0
            //     onProgress: (double progressValue) {
            //       debugPrint('model loading progress : $progressValue');
            //     },
            //     //This callBack will call after model loaded successfully and will return model address
            //     onLoad: (String modelAddress) {
            //       debugPrint('model loaded : $modelAddress');
            //       controller.playAnimation();
            //     },
            //     //this callBack will call when model failed to load and will return failure error
            //     onError: (String error) {
            //       debugPrint('model failed to load : $error');
            //     },
            //     //You can have full control of 3d model animations, textures and camera
            //     controller: controller,
            //     src: srcGlb,
            //     // src: 'assets/business_man.glb', //3D model with different animations
            //     //src: 'assets/sheen_chair.glb', //3D model with different textures
            //     //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // 3D model from URL
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Future<String?> showPickerDialog(String title, List<String> inputList,
      [String? chosenItem]) async {
    return await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 250,
          child: inputList.isEmpty
              ? Center(
            child: Text('$title list is empty'),
          )
              : ListView.separated(
            itemCount: inputList.length,
            padding: const EdgeInsets.only(top: 16),
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, inputList[index]);
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${index + 1}'),
                      Text(inputList[index]),
                      Icon(
                        chosenItem == inputList[index]
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider(
                color: Colors.grey,
                thickness: 0.6,
                indent: 10,
                endIndent: 10,
              );
            },
          ),
        );
      },
    );
  }
}



/// Try 2
/// flutter three code
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gl/flutter_gl.dart';
// import 'package:three_dart/three_dart.dart' as THREE;
// import 'package:three_dart_jsm/loaders/GLTFLoader.dart';
// import 'package:three_dart_jsm/controls/OrbitControls.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: MugViewer());
//   }
// }
//
// class MugViewer extends StatefulWidget {
//   const MugViewer({super.key});
//   @override
//   State<MugViewer> createState() => _MugViewerState();
// }
//
// class _MugViewerState extends State<MugViewer> {
//   late FlutterGlPlugin three3dRender;
//   THREE.WebGLRenderer? renderer;
//   late Size screenSize;
//   THREE.Scene? scene;
//   THREE.Camera? camera;
//   THREE.Object3D? mugModel;
//   late OrbitControls controls;
//
//   @override
//   void initState() {
//     super.initState();
//     initScene();
//   }
//
//   Future<void> initScene() async {
//     screenSize = const Size(400, 400);
//     three3dRender = FlutterGlPlugin();
//     await three3dRender.initialize(options: {
//       "width": screenSize.width.toInt(),
//       "height": screenSize.height.toInt(),
//       "antialias": true,
//       "alpha": false,
//     });
//
//     await three3dRender.prepareContext();
//
//     final gl = three3dRender.gl;
//     renderer = THREE.WebGLRenderer({
//       "canvas": three3dRender.element,
//       "gl": gl,
//       "antialias": true,
//       "alpha": false,
//     });
//     renderer!.setSize(screenSize.width, screenSize.height, false);
//
//     scene = THREE.Scene();
//
//     camera = THREE.PerspectiveCamera(75, screenSize.width / screenSize.height, 0.1, 1000);
//     camera!.position.set(0, 1, 3);
//
//     // Add light
//     final light = THREE.DirectionalLight(THREE.Color(0xffffff), 1);
//     light.position.set(5, 5, 5);
//     scene!.add(light);
//
//     controls = OrbitControls(camera, three3dRender.element);
//     controls.enableDamping = true;
//
//     await loadGLBModel();
//
//     animate();
//   }
//
//   Future<void> loadGLBModel() async {
//     final loader = GLTFLoader(null);
//     final glbData = await rootBundle.load('assets/white_mug.glb');
//     final blob = THREE.Uint8Buffer(glbData.buffer.asUint8List());
//     final gltf = await loader.parseAsync(blob, null, null);
//
//     mugModel = gltf["scene"];
//     final texture = THREE.TextureLoader().load('assets/design_image.png');
//
//     mugModel!.traverse((child) {
//       if (child is THREE.Mesh) {
//         child.material.map = texture;
//         child.material.needsUpdate = true;
//       }
//     });
//
//     scene!.add(mugModel!);
//   }
//
//   void animate() {
//     Future.delayed(const Duration(milliseconds: 16), () {
//       controls.update();
//       renderer!.render(scene!, camera);
//       three3dRender.gl.flush();
//       animate();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Mug with Texture")),
//       body: Center(
//         child: three3dRender.isInitialized
//             ? SizedBox(
//           width: screenSize.width,
//           height: screenSize.height,
//           child: Texture(textureId: three3dRender.textureId!),
//         )
//             : const CircularProgressIndicator(),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     renderer?.dispose();
//     three3dRender.dispose();
//     super.dispose();
//   }
// }


/// try three
/// Web rencering the 3d model
//
// class MugTextureApp extends StatefulWidget {
//   const MugTextureApp({super.key});
//   @override
//   State<MugTextureApp> createState() => _MugTextureAppState();
// }
//
// class _MugTextureAppState extends State<MugTextureApp> {
//
//   late final WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // #docregion platform_features
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }
//
//     final WebViewController controller =
//     WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features
//
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.prevent;
//             }
//             debugPrint('allowing navigation to ${request.url}');
//             return NavigationDecision.navigate;
//           },
//           onHttpError: (HttpResponseError error) {
//             debugPrint('Error occurred on page: ${error.response?.statusCode}');
//           },
//           onUrlChange: (UrlChange change) {
//             debugPrint('url change to ${change.url}');
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       );
//       // ..loadRequest(Uri.parse('https://flutter.dev'));
//
//     // #docregion platform_features
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//     // #enddocregion platform_features
//
//     _controller = controller;
//     _prepareLocalHTML();
//   }
//
//   Future<void> _prepareLocalHTML() async {
//     final htmlContent = await rootBundle.loadString('assets/mug_viewer.html');
//
//
//     final glbBase64 = await loadGLBAsBase64();
//     final pngBase64 = await loadPNGAsBase64();
//
//     final updatedHtml = htmlContent
//         .replaceAll('__GLB_BASE64__', glbBase64)
//         .replaceAll('__PNG_BASE64__', 'data:image/png;base64,$pngBase64');
//
//     final base64Html = base64Encode(utf8.encode(updatedHtml));
//     _controller.loadRequest(Uri.parse('data:text/html;base64,$base64Html'));
//   }
//
//   Future<String> loadGLBAsBase64() async {
//     final bytes = await rootBundle.load('assets/white_mug.glb');
//     return base64Encode(bytes.buffer.asUint8List());
//   }
//
//   Future<String> loadPNGAsBase64() async {
//     final bytes = await rootBundle.load('assets/image2.png');
//     return base64Encode(bytes.buffer.asUint8List());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Mug Viewer")),
//       body: WebViewWidget(
//       controller: _controller,
//       ),
//     );
//   }
// }

