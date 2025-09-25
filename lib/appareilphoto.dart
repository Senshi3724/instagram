import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wathsapp/storycreate.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int _currentIndex = 0;
  final List<String> filtres = [
    'images/avatar/profile1.png',
    'images/avatar/profile2.jpg',
    'images/avatar/profile3.jpg',
    'images/avatar/profile4.jpg',
    'images/avatar/profile5.jpeg',
    'images/avatar/profile1.png',
    'images/avatar/profile2.jpg',
    'images/avatar/profile3.jpg',
    'images/avatar/profile4.jpg',
    'images/avatar/profile5.jpeg',
  ];

  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isReady = false;
  bool isRearCameraSelected = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      // Gérer le cas où la permission est refusée
      return;
    }

    cameras = await availableCameras();

    final selectedCamera = cameras!.firstWhere(
          (camera) =>
      camera.lensDirection ==
          (isRearCameraSelected
              ? CameraLensDirection.back
              : CameraLensDirection.front),
    );

    controller = CameraController(selectedCamera, ResolutionPreset.high);

    await controller!.initialize();

    if (!mounted) return;

    setState(() {
      isReady = true;
    });
  }

  Future<void> switchCamera() async {
    setState(() {
      isReady = false;
      isRearCameraSelected = !isRearCameraSelected;
    });

    await controller?.dispose();
    await _initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady || controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: 630,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CameraPreview(controller!),
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: screenWidth / 2 - 12,
                  child: const Icon(Icons.flash_off, color: Colors.white),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: const Icon(Icons.settings, color: Colors.white),
                ),
                // Menu vertical gauche
                const Positioned(
                  top: 300,
                  left: 20,
                  child: Column(
                    children: [
                      Text(
                        "Aa",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Icon(Icons.all_inclusive, color: Colors.white),
                      SizedBox(height: 20),
                      Icon(Icons.grid_on, color: Colors.white),
                      SizedBox(height: 20),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: screenWidth * 0.9,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 100,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.3,
                          initialPage: 0,
                        ),
                        items: filtres.map((path) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                image: AssetImage(path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 75,
                  right: screenWidth / 2 - 45,
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const StoryCreatorScreen()),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Image(
                            image: AssetImage('images/avatar/profile1.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 60,
                            viewportFraction: 0.4,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: ['STORY', 'PUBLIER', 'LIVE', 'REELS']
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            String text = entry.value;

                            bool isSelected = _currentIndex == index;

                            return AnimatedOpacity(
                              opacity: isSelected ? 1.0 : 0.3,
                              duration: const Duration(milliseconds: 300),
                              child: Center(
                                child: Text(
                                  text,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 90,
                        child: IconButton(
                          icon:
                          const Icon(Icons.cached, color: Colors.white, size: 30),
                          onPressed: switchCamera,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
