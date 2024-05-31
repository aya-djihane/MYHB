import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui'as ui;
import 'package:myhb_app/models/item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/item_controller.dart';

class CameraScreen extends StatefulWidget {
  final String file;
  final List<String>? colors;
  final Type type ;
  CameraScreen({required this.file, required this.colors,required this.type, Key? key})
      : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final GlobalKey _screenshotKey = GlobalKey();
  final ItemController controller = Get.find();
  List<String> matchingColors = [];
  bool _isDetecting = false;
  Color _containerColor = Colors.grey;
  int colorIndex = 0;
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
      _timer = Timer.periodic(const Duration(seconds: 3), (_) {
        if (!_isDetecting) {
          _captureImage();
        }
      });
    });
  }
  Future<void> _takeScreenshotAndSaveToGallery(GlobalKey screenshotKey) async {
    try {
      RenderRepaintBoundary boundary = screenshotKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);

      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        Get.snackbar("Error", "Failed to capture screenshot");
        return;
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      final imageFile = File(imagePath);

      await imageFile.writeAsBytes(pngBytes);
      final result = await ImageGallerySaver.saveFile(imageFile.path);
      if (result != null && result["isSuccess"]) {
        Get.snackbar("Success", "Image saved to gallery: ${result["filePath"]}");
        await Share.shareFiles([imageFile.path], text: 'Check out this ${widget.type.toString().replaceAll("Type.", "")} available in ${widget.colors!.length} colors. What do you think?');
      } else {
        Get.snackbar("Error", "Failed to save image to gallery");
      }
    } catch (e) {
      Get.snackbar("Error", "Error taking screenshot and saving to gallery: $e");
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    Tflite.close();
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
        if (_containerColor != getColorForLabel(labelIndex)) {
          setState(() {
            _containerColor = getColorForLabel(labelIndex);
            colorIndex = labelIndex;
            print("detecting objects: $_containerColor");
            isMatchingColorFound(widget.colors!, matchingColors);
          });
        }
      }
    } catch (e) {
      print("Error detecting objects: $e");
    }
  }
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
                top: 5,
                left: media.width / 2 - 75.w,
                child: Container(
                  width: 150.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(20)),
                  child:  Center(
                    child: Text(
                      "Local AR View",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10.w,
                bottom: 55.h,
                child: Container(
                  width: 100.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(20)),
                  child:  Center(
                    child: Text(
                      "AR Service",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10.w,
                bottom: 10.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(20)),
                      child:  Center(
                        child: Text(
                          " AI Matching Colors ",
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Row(
                        children: [...findMatchingColors(colorIndex)],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 100.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Available Colors ",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: widget.colors!.asMap().entries.map((entry) {
                          final String item = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              width: 20.w,
                              height: 17.h,
                              decoration: BoxDecoration(
                                  color: Color(int.parse("0xFF$item")),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    ),
                                  ]),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      width: 100.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Detecting BG",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 5),
                      child: Container(
                        width: 40.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                            color: _containerColor,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: RepaintBoundary(
                  key: _screenshotKey,
                  child: SizedBox(
                    width: media.width,
                    height: media.height,
                    child: ModelViewer(
                      backgroundColor: Colors.transparent,
                      src: widget.file,
                      alt: 'A 3D model of an astronaut',
                      ar: true,
                      autoRotate: true,
                      iosSrc: widget.file,
                      disableZoom: false,
                      maxFieldOfView: '50deg',
                      minFieldOfView: '60deg',
                      cameraOrbit: '42deg 90deg 0.5m',
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80.h,
                right: 10.w,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(20)),
                      child:  Center(
                        child: Text(
                          "Share Element",
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6,),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: GestureDetector(
                        onTap:(){
                           _takeScreenshotAndSaveToGallery(_screenshotKey);
                        },
                        child: Container(

                        width: 40.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(50)),
                                child:   Center(
                                      child: IconButton(onPressed: ()async{
                                        _takeScreenshotAndSaveToGallery(_screenshotKey);
                                      },    icon:const Icon(Icons.share,color: AppColors.black,),),
                                ),
                        ),
                      ),
                    ),
                  ],
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

      return true;
    }else{

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
List<Padding> findMatchingColors(int labelIndex) {
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
  return matchingColors.map((e) => Padding(
    padding: const EdgeInsets.only(left: 2.0),
    child: Container(
      width: 20.w,height: 17.h,decoration:  BoxDecoration(color: getColorForLabel(e),borderRadius: BorderRadius.circular(50)),
      ),
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
