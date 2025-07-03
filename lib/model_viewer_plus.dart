import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ModelViewerClass extends StatefulWidget {
  ModelViewerClass({super.key});

  @override
  State<ModelViewerClass> createState() => _ModelViewerClassState();
}

class _ModelViewerClassState extends State<ModelViewerClass> {
  late WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _setTextureOnMaterial('mug','');
    super.initState();
  }

  // Changes the base color using RGBA values (0–1)
  void _changeColor(List<double> rgba) {
    final js =
        '''
        
        console.log("✅ _changeColor called.");
      modelViewer = document.querySelector("model-viewer");
        console.log("✅ modelViewer found.");
      materials = modelViewer.model.materials;
      // for (mat of materials) {
      //   mat.pbrMetallicRoughness.setBaseColorFactor(${rgba.toString()});
      // }
          insideMat = materials.find(m => m.name === "mug");
    if (insideMat) {
    
        console.log("✅ insideMat found.");
      insideMat.pbrMetallicRoughness.setBaseColorFactor(${rgba.toString()});
      
        console.log("✅ colour");
    }
    if (insideMat) {
    
        console.log("✅ insideMat apply image.");
  image = new Image();
  image.crossOrigin = "anonymous";
  
        console.log("✅ cross origin fine ");
  image.src = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Hopetoun_falls.jpg/640px-Hopetoun_falls.jpg";
  
        console.log("✅ img fine ", image.src);
  // image.onload = function () {
  //   console.log("✅ Image loaded");
  //   const texture = modelViewer.createTexture(image);
  //   insideMat.pbrMetallicRoughness.baseColorTexture.texture = texture;
  //   console.log("🧵 Texture applied to material");
  //   modelViewer.scene.requestUpdate();
  // };
  setTimeout(() => {
  try{
  console.log("✅ Image loaded (after delay)");
  const texture = modelViewer.createTexture(image);
  insideMat.pbrMetallicRoughness.baseColorTexture.texture = texture;
  if (texture === insideMat.pbrMetallicRoughness.baseColorTexture.texture  ){
  console.log("🧵 Texture applied to material");
  }
  else {
   console.log("🧵 Texture not applied to material");
  }}
  catch (error){
   console.error("❌ Error applying texture:", error);
  }
  
}, 10000); 

  image.onerror = function (e) {
    console.error("❌ Image failed to load", e);
  };
}
    ''';
    _controller.runJavaScript(js);
  }

  void _setTextureOnMaterial(String materialName, String imageUrl) async{
    final bytes = await rootBundle.load(imageUrl);
    final buffer = bytes.buffer;
    final base64String = base64Encode(buffer.asUint8List());

    // 🔥 Escape the base64 string to safely inject in JS
    // final dataUrl = jsonEncode('data:image/png;base64,$base64String');
    final dataUrl = jsonEncode('https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Hopetoun_falls.jpg/640px-Hopetoun_falls.jpg');
  //   final js = '''
  //    modelViewer = document.querySelector("model-viewer");
  //    mat = modelViewer.model.materials.find(m => m.name === "$materialName");
  //   if (!mat) {
  //     console.warn("Material '$materialName' not found");
  //   } else {
  //     const image = new Image();
  //     image.crossOrigin = "anonymous";
  //     image.src = 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Hopetoun_falls.jpg/640px-Hopetoun_falls.jpg';
  //     image.onload = () => {
  //       const texture = modelViewer.createTexture(image);
  //       mat.pbrMetallicRoughness.baseColorTexture.texture = texture;
  //
  //        assignedTexture = mat.pbrMetallicRoughness.baseColorTexture.texture;
  //       if (assignedTexture === texture) {
  //         console.log("✅ Texture successfully applied to material:", mat.name);
  //       } else {
  //         console.warn("⚠️ Texture was not set correctly.");
  //       }
  //     };
  //     image.onerror = (e) => {
  //       console.error("❌ Image failed to load", e);
  //     };
  //   }
  // ''';

    final js = '''
console.log("_setTextureOnMaterial called");

const modelViewer = document.querySelector("model-viewer");
console.log("✅ modelViewer found.");
modelViewer.loaded.then(() => {
  const mat = modelViewer.model.materials.find(m => m.name === "mug");
  if (!mat) {
    console.warn("❌ Material not found.");
    return;
  }
  console.log("✅ Material found.");

  const image = new Image();
  console.log("🖼️ Image created.");
  image.crossOrigin = "anonymous";
  image.src = "https://upload.wikimedia.org/wikipedia/commons/3/36/Hopetoun_falls.jpg";
  console.log("📸 Image src set:", image.src);

  image.onload = () => {
    console.log("🖼️ Image loaded.");
    const texture = modelViewer.createTexture(image);
    mat.pbrMetallicRoughness.setBaseColorFactor([1, 1, 1, 1]);
    mat.pbrMetallicRoughness.baseColorTexture.texture = texture;
    modelViewer.scene.requestUpdate();
    console.log("✅ Texture applied and scene updated.");
  };

  image.onerror = () => {
    console.error("❌ Failed to load image.");
  };
});
''';
    debugPrint(js.toString());

    _controller.runJavaScript(js);
  }

  void _printMaterialNames() {
    const js = '''
    modelViewer = document.querySelector("model-viewer");
    modelViewer.model.materials.forEach(m => console.log(m.name));
  ''';
    _controller.runJavaScript(js);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Model Viewer')),
        body: Column(
          children: [
            Flexible(
              flex: 4,
              child: ModelViewer(
                backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                src:  'assets/white_mug.glb',//'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
                alt: 'A 3D model of an astronaut',
                // ar: true,
                arModes: const ['scene-viewer', 'webxr', 'quick-look'],
                autoRotate: false,
                iosSrc:
                    'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
                disableZoom: false,
                onWebViewCreated: (controller) {
                  _controller = controller;
                  setState(() {});
                },
  //                 onWebViewCreated: (controller) {
  //                   _controller = controller;
  //
  //                   _controller.runJavaScript('''
  //    modelViewer = document.querySelector("model-viewer");
  //   modelViewer.addEventListener("load", () => {
  //     console.log("Model loaded, ready for texture");
  //     // We'll inject base64 from Dart now
  //   });
  // ''');
  //
  //                   // Wait just a bit and inject base64
  //                   // Future.delayed(Duration(milliseconds: 500), () {
  //                   //   _loadTextureFromAsset(_controller);
  //                   // });
  //                 }

              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _printMaterialNames();
                    },
                    child: Text('Get material name'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _setTextureOnMaterial(
                           'mug',// 'Astronaut_mat',
                            // 'https://images.unsplash.com/photo-1624555130581-1d9cca783bc0?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          // 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Hopetoun_falls.jpg/640px-Hopetoun_falls.jpg'
                            'assets/image3.png'
                          ); _changeColor([1.0, 0.0, 0.0, 1.0]);
                          setState(() {});
                        }, // Red
                        child: Text("Red"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _changeColor([0.0, 1.0, 0.0, 1.0]);
                          setState(() {});
                        }, // Green
                        child: Text("Green"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _changeColor([0.0, 0.0, 1.0, 1.0]);
                          setState(() {});
                        }, // Blue
                        child: Text("Blue"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
