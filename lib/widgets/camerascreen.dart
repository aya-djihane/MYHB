import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:myhb_app/controller/item_controller.dart';
class CameraScreen extends StatefulWidget {
  final String file;
  final List<String>? colors;


  CameraScreen({required this.file, required this.colors, Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}
class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final ItemController controller = Get.find();
  List<String> matchingColors=[];
  bool _isDetecting = false;
  Color _containerColor = Colors.grey;
  int colorIndex = 0;
  Color _containerColorMatching = Colors.grey;
  bool _isMatchingColorDetectionEnabled = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      const CameraDescription(
        name: "0",
        lensDirection: CameraLensDirection.front,
        sensorOrientation: 1,
      ),
      ResolutionPreset.high,
    );
    _controller.setFlashMode(FlashMode.off);
    _controller.setExposureMode(ExposureMode.locked);
    _controller.setFocusMode(FocusMode.locked);
    _initializeControllerFuture = _controller.initialize().then((_) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!_isDetecting) {
          _captureImage();
        }
      });
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
  Future<void> _captureImage() async {
    if (!_controller.value.isInitialized) {
      return;
    }
    if (_controller.value.isTakingPicture) {
      return;
    }
    try {
      setState(() {
        _isDetecting = true;
      });
      final XFile imageFile = await _controller.takePicture();
      await _detectObjects(imageFile.path);
    } catch (e) {
      print("Error capturing image: $e");
    } finally {
      setState(() {
        _isDetecting = false;
      });
    }
  }
  Future<void> _detectObjects(String imagePath) async {
    try {
      final interpreter = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
      );
      if (interpreter == null) {
        print("Error: Interpreter is null");
        return;
      }
      final File image = File(imagePath);
      final Uint8List imageBytes = await image.readAsBytes();
      final List<dynamic>? recognitions = await Tflite.runModelOnImage(
        path: imagePath,
        numResults: 9,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      if (recognitions != null && recognitions.isNotEmpty) {
        final labelIndex = recognitions[0]['index'];
        print(_containerColor);
        print(getColorForLabel(labelIndex));
        if( _containerColor != getColorForLabel(labelIndex)){
          setState(() {
            _containerColor = getColorForLabel(labelIndex);
            colorIndex = labelIndex;
            _containerColorMatching = getColorForLabel(findMatchingColors(labelIndex).first);
            print("detecting objects: $_containerColor");
            String text = "Hello,Iman Good Morning You can ask the company for more colors. ";
            double volume = 1.0;
            // tts.setVolume(volume);
            // tts.speak(text);

          });
          isMatchingColorFound(widget.colors!,matchingColors);
        }

      }
    } catch (e) {
      print("Error detecting objects: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              CameraPreview(_controller),
              Positioned(
                top: 100,
                right: 20,
                child: Column(
                  children: [
                    // const Text("detecting Color"),
                    Container(
                      width: 30,
                      height: 30,
                      color: _containerColor,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 20,
                child: Column(
                  children: [
                    // const Text("Predicting Matching Color"),
                    ...findMatchingColors(colorIndex),
                  ],
                ),
              ),
              SizedBox(
                width: media.width,
                height: media.height,
                child: ModelViewer(
                  backgroundColor: Colors.transparent,
                  src: widget.file,
                  alt: 'A 3D model of an astronaut',
                  ar: true,
                  autoRotate: false,
                  iosSrc: widget.file,
                  disableZoom: false,
                  maxFieldOfView: '100deg',
                  minFieldOfView: '100deg',
                  cameraOrbit: '0deg 0deg 0.5m',
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
bool isMatchingColorFound(List<String> cardColors, List<String> matchingColors) {
  List<String> cardColorNames = cardColors.map((colorCode) =>
      getColorNameFromCode(colorCode)).toList();

  for(String cardColor in cardColorNames){
    print("cardColorNames ${cardColor}");
  }
  for(String cardColor in matchingColors){
    print("matchingColors ${cardColor}");
  }
  for (String cardColor in cardColorNames) {
    if (matchingColors.contains(cardColor.toLowerCase())) {
      print ("exist ");
      Get.snackbar("exist", "exist");
      return true;
    }else{
      Get.snackbar("dosent exist", "dosent exist");
      print ("dosent exist ");
    }
  }
  return true ;
}
String getColorNameFromCode(String colorCode) {
  Map<String, String> colorCodeToName = {
    "efa4c4": "pink",
    "aabbcc": "blue",
    "ff0000": "red",
    "00ff00": "green",
    "0000ff": "blue",
    "ffff00": "yellow",
    "ff00ff": "purple",
    "ffa500": "orange",
    "800080": "purple",
    "008000": "green",
    "000000": "black",
    "ffffff": "white",
    "c0c0c0": "silver",
    "808080": "gray",
    "800000": "maroon",
    "808000": "olive",
    "008080": "teal",
    "ffd700": "gold",
    "ff69b4": "hotpink",
    "000080": "navy",
    "00ffff": "cyan",
    "ff7f50": "coral",
    "8a2be2": "blueviolet",
    "a52a2a": "brown",
    "b0c4de": "lightsteelblue",
    "d2b48c": "tan",
    "ff6347": "tomato",
    "00ced1": "darkturquoise",
    "dda0dd": "plum",
    "4682b4": "steelblue",
    "20b2aa": "lightseagreen",
    "9932cc": "darkorchid",
    "2e8b57": "seagreen",
    "8b4513": "saddlebrown",
    "9370db": "mediumpurple",
    "ff4500": "orangered",
    "da70d6": "orchid",
    "32cd32": "limegreen",
    "ff8c00": "darkorange",
    "9400d3": "darkviolet",
    "b8860b": "darkgoldenrod",
    "adff2f": "greenyellow",
    "8b0000": "darkred",
    "b22222": "firebrick",
    "cd5c5c": "indianred",
    "f08080": "lightcoral",
    "ffb6c1": "lightpink",
    "ff1493": "deeppink",
    "FFEE58":"yellow"
  };
  String lowercaseColorCode = colorCode.toLowerCase();
  Map<String, String> updatedColorCodeToName = colorCodeToName.map(
        (key, value) => MapEntry("0xff$key", value),
  );
  if (colorCodeToName.containsKey(lowercaseColorCode)) {
    return colorCodeToName[lowercaseColorCode]!;

  } else {
    return "unknown";
  }
}
List<Container> findMatchingColors(int labelIndex) {
  final Map<int, List<String>> colorAssociations = {
    0: ["blue", "beige", "white"],
    1: ["yellow", "blue", "red", "black"],
    2: ["red", "black", "green"],
    3: ["violet", "white", "yellow", "green", "blue", "pink"],
    4: ["brown", "white", "yellow", "orange"],
    5: ["green", "blue", "yellow", "white", "brown", "violet"],
    6: ["black", "white", "red", "yellow", "grey"],
    7: ["orange", "red", "brown", "black"],
    8: ["grey ", "black", "Blue", "violet"],
    9: ["white  ", "black", "Yellow", "Blue", "Red"],
  };
  List<String> matchingColors = colorAssociations[labelIndex] ?? [];
  matchingColors.removeWhere((color) => color.toLowerCase() == getColorName(labelIndex).toLowerCase());
  matchingColors = matchingColors.toSet().toList();
  matchingColors = matchingColors;
  return matchingColors.map((e) => Container(
      width: 20,
      height: 50,
      color: getColorForLabel(e),
    ),
  ).toList();
}
String getColorName(int labelIndex) {
  switch (labelIndex) {
    case 0:
      return "blue";
    case 1:
      return "yellow";
    case 2:
      return "red";
    case 3:
      return "violet";
    case 4:
      return "brown";
    case 5:
      return "green";
    case 6:
      return "black";
    case 7:
      return "orange";
    case 8:
      return "white";
    default:
      return "grey";
  }
}
Color getColorForLabel(dynamic label) {
  int labelIndex;
  if (label is int) {
    labelIndex = label;
  } else if (label is String) {
    labelIndex = getColorIndex(label);
  } else {
    return Colors.grey;
  }
  switch (labelIndex) {
    case 0:
      return Colors.blue;
    case 1:
      return Colors.yellow;
    case 2:
      return Colors.red;
    case 3:
      return Colors.purple;
    case 4:
      return Colors.brown;
    case 5:
      return Colors.green;
    case 6:
      return Colors.black;
    case 7:
      return Colors.orange;
    case 8:
      return Colors.white;
    default:
      return Colors.grey;
  }
}
int getColorIndex(String colorName) {
  switch (colorName.toLowerCase()) {
    case "blue":
      return 0;
    case "yellow":
      return 1;
    case "red":
      return 2;
    case "violet":
      return 3;
    case "brown":
      return 4;
    case "green":
      return 5;
    case "black":
      return 6;
    case "orange":
      return 7;
    case "white":
      return 8;
    default:
      return -1;
  }
}
