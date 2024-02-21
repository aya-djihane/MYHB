import 'dart:ui'as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  double imageX = 0.0;
  double imageY = 0.0;
  double boxWidth = 200.0;
  double boxHeight = 300.0;
  double modelScale = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      const CameraDescription(
        name: "0",
        lensDirection: CameraLensDirection.front,
        sensorOrientation: 1,
      ),
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    imageX = 0.0;
    imageY = 0.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _globalKey = GlobalKey();
    void _captureScreenshot() async {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(pngBytes);
      if ( result['isSuccess']) {
        print('Image saved to gallery');
      } else {
        print('Failed to save image: ${result['errorMessage']}');
      }
    }
    var media = MediaQuery.of(context).size;
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RepaintBoundary(
            key: _globalKey,
            child: Stack(
              children: [
                Expanded(child:

                CameraPreview(_controller)
                ),
                SizedBox(
                  width: media.width,
                  height: media.height,
                  child: const ModelViewer(
                    backgroundColor: Colors.transparent,
                    src: 'images/Wood_Table.glb',
                    alt: 'A 3D model of an astronaut',
                    ar: false,
                    autoRotate: false,
                    iosSrc: 'images/Wood_Table.glb',
                    disableZoom: false,
                    maxFieldOfView: '100deg',
                    minFieldOfView: '100deg',
                    cameraOrbit: '0deg 0deg 0.5m',
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
