// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gl/flutter_gl.dart';
// import 'package:three_dart/three_dart.dart' as THREE;
//
// import 'package:flutter/material.dart';
//
// import 'package:flutter/services.dart';
// import 'htmlThreeDModel.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// // Setup FlutterGL and Three.js runtime
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
//
// / try three
// / Web rencering the 3d model
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