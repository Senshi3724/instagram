import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  final List<Map<String, dynamic>> reelsData = List.generate(12, (index) {
    final profiles = [
      "images/avatar/profile1.png",
      "images/avatar/profile2.jpg",
      "images/avatar/profile3.jpg",
      "images/avatar/profile4.jpg"
    ];

    final descriptions = [
      "Discours pour les femmes ou hommes mariés 😂😂😂🤣🤣🤣",
      "Je fume tout vos joueurs au sniper 😒😒😎😎🤴👊",
      "Aujourd’hui pas de live, rdv demain",
      "Elle croyait quoi ? 😒😂🤣😎"
    ];

    return {
      "profile": profiles[index % profiles.length],
      "post": "assets/videos/video${(index % 6) + 1}.mp4",
      "name": ["Mamadou", "Raion", "Senshi", "Lamine"][index % 4],
      "audio": ["Dip Doundou Guisse", "Beat Street", "", "Wally Seck"][index % 4],
      "like": "${100 + index * 20}",
      "comment": "${10 + index * 2}",
      "partage": "${5 + index}",
      "description": descriptions[index % descriptions.length],
      "date": "il y a ${index + 1}h",
      "sertifier": index % 2 == 0
    };
  });

  late PageController _pageController;
  int currentIndex = 0;
  final List<VideoPlayerController?> _controllers = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    for (var item in reelsData) {
      final controller = VideoPlayerController.asset(item['post']);
      _controllers.add(controller);
    }
    _initializeController(currentIndex);
  }

  Future<void> _initializeController(int index) async {
    for (int i = 0; i < _controllers.length; i++) {
      if (i == index) {
        await _controllers[i]?.initialize();
        _controllers[i]?.setLooping(true);
        _controllers[i]?.play();
      } else {
        _controllers[i]?.pause();
      }
    }
    setState(() {});
  }

  void _onPageChanged(int index) {
    setState(() => currentIndex = index);
    _initializeController(index);
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller?.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            Text("Reels", style: TextStyle(color: Colors.white, fontSize: 20)),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
        actions: const [
          Icon(Icons.photo_camera, color: Colors.white),
          SizedBox(width: 16)
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: reelsData.length,
        itemBuilder: (context, index) {
          final reel = reelsData[index];
          final controller = _controllers[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6), // Bande noire
            color: Colors.black,
            child: Stack(
              children: [
                controller != null && controller.value.isInitialized
                    ? SizedBox.expand(child: VideoPlayer(controller))
                    : const Center(child: CircularProgressIndicator()),
                Positioned(
                  right: 16,
                  bottom: 30,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Icon(Icons.favorite, color: Colors.white),
                      Text(reel['like'], style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 12),
                      Image.asset(
                        'images/avatar/comme.png',
                        width: 26,
                        height: 26,
                      ),
                      Text(reel['comment'], style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 12),
                      Image.asset(
                        'images/avatar/share.png',
                        width: 26,
                        height: 26,
                      ),
                      Text(reel['partage'], style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 12),
                      Icon(Icons.more_vert, color: Colors.white)
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 20,
                  right: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(reel['profile']),
                          ),
                          const SizedBox(width: 8),
                          Text('@${reel['name']}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          if (reel['sertifier'])
                            const Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Icon(Icons.verified, size: 16, color: Colors.blue),
                            ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text("Suivre", style: TextStyle(color: Colors.white, fontSize: 12)),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(reel['description'], style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
