import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> _gridData = [
    {"url": "assets/videos/reel1.mp4", "isVideo": true},
    {"url": "images/avatar/momo.png", "isVideo": false},
    {"url": "assets/videos/reel2.mp4", "isVideo": true},
    {"url": "images/avatar/profile1.png", "isVideo": false},
    {"url": "assets/videos/reel3.mp4", "isVideo": true},
    {"url": "assets/videos/reel4.mp4", "isVideo": true},
    {"url": "images/avatar/profile2.jpg", "isVideo": false},
    {"url": "assets/videos/reel5.mp4", "isVideo": true},
    {"url": "assets/videos/reel6.mp4", "isVideo": true},
    {"url": "images/avatar/profile3.jpg", "isVideo": false},
    {"url": "assets/videos/reel7.mp4", "isVideo": true},
    {"url": "assets/videos/reel8.mp4", "isVideo": true},
    {"url": "images/avatar/profile4.jpg", "isVideo": false},
    {"url": "assets/videos/reel9.mp4", "isVideo": true},
    {"url": "assets/videos/reel10.mp4", "isVideo": true},
    {"url": "assets/videos/reel11.mp4", "isVideo": true},
    {"url": "assets/videos/reel12.mp4", "isVideo": true},
    {"url": "images/avatar/profile5.jpeg", "isVideo": false},
  ];

  final List<VideoPlayerController?> _videoControllers = [];

  @override
  void initState() {
    super.initState();
    _initVideoControllers();
  }

  void _initVideoControllers() {
    for (var item in _gridData) {
      if (item['isVideo'] == true) {
        _initializeController(item['url']);
      } else {
        _videoControllers.add(null);
      }
    }
  }

  void _initializeController(String url) {
    final controller = VideoPlayerController.asset(url);
    controller
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        if (mounted) setState(() {});
        controller.play();
      });
    _videoControllers.add(controller);
  }


  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: 1.0,
        ),
        itemCount: _gridData.length,
        itemBuilder: (context, index) {
          final item = _gridData[index];
          final isVideo = item['isVideo'];
          final controller = _videoControllers[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: isVideo
                    ? (controller != null && controller.value.isInitialized
                    ? VideoPlayer(controller)
                    : const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ))
                    : Image.asset(
                  item['url'],
                  fit: BoxFit.cover,
                ),
              ),
              if (isVideo)
                const Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    Icons.play_circle,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
