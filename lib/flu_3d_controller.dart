import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class GLBTextureChangeExample extends StatefulWidget {
  const GLBTextureChangeExample({super.key});

  @override
  State<GLBTextureChangeExample> createState() => _GLBTextureChangeExampleState();
}

class _GLBTextureChangeExampleState extends State<GLBTextureChangeExample> {
  Flutter3DController? _controller;
  List<String> _textures = [];
  String? _selectedMaterial;

  Future<void> _loadTextures() async {
    if (_controller != null) {
      List<String> availableTextures = await _controller!.getAvailableTextures();
      setState(() {
        _textures = availableTextures;
        _selectedMaterial = availableTextures.isNotEmpty ? availableTextures.first : null;
      });
      debugPrint("Available Textures: $_textures");
    }
  }

  Future<void> _changeSpecificTexture(String materialName) async {
    if (_controller != null) {
      ByteData data = await rootBundle.load("assets/image3.png");
      Uint8List bytes = data.buffer.asUint8List();

       _controller!.setTexture(
        textureName: 'Material.007',
      );
    } else {
      debugPrint("Material $materialName not found in model");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GLB - Change image")),
      body: Column(
        children: [
          Expanded(
            child: Flutter3DViewer(
              src:'assets/jitaku/canister.glb',
              onLoad: (controller) async {
                _controller = controller as Flutter3DController?;
                await _loadTextures();
              },
            ),
          ),
          ElevatedButton(onPressed: (){
            _changeSpecificTexture('Material.008');
          }, child: Text('change texture'))
        ],
      ),
    );
  }
}
