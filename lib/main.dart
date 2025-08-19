/// flutter gl working code for rendering 3d model and showing
// import 'dart:convert';
// import 'dart:io' as controller;

import 'dart:math' as Math;

import 'package:dummy_model/htmlThreeDModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

import 'flutter_cube.dart';
import 'model_viewer_plus.dart';

void main() {
  runApp(MyApp());
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
      home: MyHomePage(title: 'Flutter 3D Controller Example'),
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
  String srcObj = '';

  /// obj files
  String cup = 'assets/mug/base.obj';
  String lid = 'assets/mug/lid.obj';
  String handle1 = 'assets/mug/handle-01.obj';
  String handle2 = 'assets/mug/handle-02.obj';
  String shirtObj = 'assets/shirt/Shirt_on_Hanger.obj';
  String sportShirt = 'assets/shirt/Tshirt3.obj';
  String spidyShirtObj = 'assets/spidyShirt/objShirt.obj';
  String mugObj = 'assets/black_mug.obj';
  String myMugObj = 'assets/my3dMug5.obj';

  /// new jitaku models
  String cup1 = 'assets/jitaku/base.obj';
  String lid1 = 'assets/jitaku/lid.obj';
  String canister = 'assets/jitaku/Canister.obj';
  String newHandle1 = 'assets/jitaku/handle-01.obj';
  String newHandle2 = 'assets/jitaku/handle-02.obj';
  String newHeartHandle = 'assets/jitaku/Heart.obj';
  String normal = 'assets/jitaku/Nomal.obj';

  ///glb files
  String handle1glb =  'assets/jitaku/handle-1.glb';
  String lidglb =  'assets/jitaku/lid.glb';
  String canisterglb =  'assets/jitaku/canister.glb';
  String srcGlb =  'assets/jitaku/lid.glb';
  // String srcGlb =  'assets/jitaku/lid.glb';
  // String srcGlb =  'assets/jitaku/lid.glb';
  String myMugGlb = 'assets/untitled.glb';

  @override
  void initState() {
    super.initState();
    srcObj = 'assets/mug/myCupHandle.obj';
    controller.onModelLoaded.addListener(() {
      debugPrint('model is loaded : ${controller.onModelLoaded.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2039),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'cup obj',
            onPressed: () {
              setState(() {
                srcObj = cup1;
              });
            },
            icon: const Icon(Icons.looks_one),
          ),
          IconButton(
            tooltip: 'canister obj',
            onPressed: () {
              // controller.playAnimation();
              setState(() {
                srcObj = canister;
              });
            },
            icon: const Icon(Icons.looks_two),
          ),
          const SizedBox(height: 4),
          IconButton(
            tooltip: 'lid obj',
            onPressed: () {
              setState(() {
                srcObj = lid1;
              });
              // controller.pauseAnimation();
              //controller.stopAnimation();
            },
            icon: const Icon(Icons.looks_3),
          ),
          const SizedBox(height: 4),
          IconButton(
            tooltip: 'normal obj',
            onPressed: () {
              setState(() {
                srcObj = normal;
              });
              // controller.resetAnimation();
            },
            icon: const Icon(Icons.looks_4),
          ),
          const SizedBox(height: 4),
          IconButton(
            tooltip: 'Heart obj',
            onPressed: () async {
              List<String> availableAnimations = await controller
                  .getAvailableAnimations();
              debugPrint(
                'Animations : $availableAnimations --- Length : ${availableAnimations.length}',
              );
              chosenAnimation = await showPickerDialog(
                'Animations',
                availableAnimations,
                chosenAnimation,
              );
              //Play animation with loop count
              controller.playAnimation(
                animationName: chosenAnimation,
                loopCount: 2,
              );
              setState(() {
                srcObj = newHeartHandle;
              });
            },
            icon: const Icon(Icons.looks_5),
          ),
          const SizedBox(height: 4),
          IconButton(
            tooltip: 'normal obj',
            onPressed: () async {
              List<String> availableTextures = await controller
                  .getAvailableTextures();
              debugPrint(
                'Textures : $availableTextures --- Length : ${availableTextures.length}',
              );
              chosenTexture = await showPickerDialog(
                'Textures',
                availableTextures,
                chosenTexture,
              );
              controller.setTexture(textureName: 'assets/jitaku/image.jpg');
            },
            icon: const Icon(Icons.list_alt_rounded),
          ),
          const SizedBox(height: 4),
          IconButton(
            onPressed: () {
              controller.setCameraOrbit(20, 20, 5);
              controller.setCameraTarget(0.3, 0.2, 0.4);
            },
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          const SizedBox(height: 4),
          IconButton(
            onPressed: () {
              controller.resetCameraOrbit();
              controller.resetCameraTarget();
            },
            icon: const Icon(Icons.cameraswitch_outlined),
          ),
          const SizedBox(height: 4),

          /// on click of this button it will toggle the handle 1 and handle 2 obj files
          IconButton(
            tooltip: changeModel? 'handle 1 obj':'handle 2 obj',
            onPressed: () async {
              List<String> availableTextures = await controller
                  .getAvailableTextures();
              debugPrint(
                'Textures : $availableTextures --- Length : ${availableTextures.length}',
              );
              chosenTexture = await showPickerDialog(
                'Material.008',
                availableTextures,
                chosenTexture,
              );
              controller.setTexture(textureName: 'assets/jitaku/image.jpg');

              setState(() {
                changeModel = !changeModel;
                chosenAnimation = null;
                chosenTexture = null;
                if (changeModel) {
                  srcObj = newHandle1;
                  srcGlb = canisterglb;
                } else {
                  srcObj = newHandle2;
                  srcGlb = lidglb;
                }
              });
            },
            icon: const Icon(Icons.looks_6, size: 30),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 7,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                gradient: RadialGradient(
                  colors: [Color(0xff919ded), Colors.grey],
                  stops: [0.1, 1.0],
                  radius: 0.7,
                  center: Alignment.center,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  /// obg file rendered
                  // Flexible(
                  //   flex: 1,
                  //   child: Flutter3DViewer.obj(
                  //     src: srcObj,
                  //     //src : 'assets/flutter_dash.obj',
                  //     //src: 'https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/flutter_dash_model/flutter_dash.obj',
                  //     scale: 5,
                  //     cameraX: cameraX* Math.cos(0),
                  //     cameraY: cameraY* Math.sin(0),
                  //     cameraZ: cameraZ,
                  //     //Initial cameraZ position of obj model
                  //     //This callBack will return the loading progress value between 0 and 1.0
                  //     onProgress: (double progressValue) {
                  //       debugPrint('model loading progress : $progressValue');
                  //     },
                  //     //This callBack will call after model loaded successfully and will return model address
                  //     onLoad: (String modelAddress) {
                  //       debugPrint('model loaded : $modelAddress');
                  //     },
                  //     //this callBack will call when model failed to load and will return failure erro
                  //     onError: (String error) {
                  //       debugPrint('model failed to load : $error');
                  //     },
                  //   ),
                  // ),
                  /// glb file rendered
                  Flexible(
                    flex: 1,
                    child: Flutter3DViewer(
                      //If you pass 'true' the flutter_3d_controller will add gesture interceptor layer
                      //to prevent gesture recognizers from malfunctioning on iOS and some Android devices.
                      // the default value is true.
                      activeGestureInterceptor: true,
                      //If you don't pass progressBarColor, the color of defaultLoadingProgressBar will be grey.
                      //You can set your custom color or use [Colors.transparent] for hiding loadingProgressBar.
                      progressBarColor: Colors.orange,
                      //You can disable viewer touch response by setting 'enableTouch' to 'false'
                      enableTouch: true,
                      //This callBack will return the loading progress value between 0 and 1.0
                      onProgress: (double progressValue) {
                        debugPrint('model loading progress : $progressValue');
                      },
                      //This callBack will call after model loaded successfully and will return model address
                      onLoad: (String modelAddress) {
                        debugPrint('model loaded : $modelAddress');
                        controller.playAnimation();
                      },
                      //this callBack will call when model failed to load and will return failure error
                      onError: (String error) {
                        debugPrint('model failed to load : $error');
                      },
                      //You can have full control of 3d model animations, textures and camera
                      controller: controller,
                      src: srcGlb,
                      // src: 'assets/business_man.glb', //3D model with different animations
                      //src: 'assets/sheen_chair.glb', //3D model with different textures
                      //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // 3D model from URL
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// model viewer flutter package example code
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ModelViewerClass()),
                );
              },
              child: Text('model viewer package screen'),
            ),
          ),
          // Flexible(
          //   flex: 1,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 12.0),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => ThreeDViewerPage()),
          //         );
          //       },
          //       child: Text('three js package screen'),
          //     ),
          //   ),
          // ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => CupScene()));
                },
                child: Text('Flutter cube package screen '),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> showPickerDialog(
    String title,
    List<String> inputList, [
    String? chosenItem,
  ]) async {
    return await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 250,
          child: inputList.isEmpty
              ? Center(child: Text('$title list is empty'))
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
                            ),
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
