import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryViewScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allContactsWithStories;
  final int initialUserIndex;

  const StoryViewScreen({
    super.key,
    required this.allContactsWithStories,
    this.initialUserIndex = 0,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen>
    with TickerProviderStateMixin {
  late int userIndex;
  int storyIndex = 0;
  Timer? timer;
  bool isPaused = false;
  VideoPlayerController? _videoController;
  late AnimationController _progressController;
  final ValueNotifier<double> progressValue = ValueNotifier(0.0);

  List<Map<String, dynamic>> get users => widget.allContactsWithStories;

  @override
  void initState() {
    super.initState();
    userIndex = widget.initialUserIndex;

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      progressValue.value = _progressController.value;
    });

    _startStory();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    timer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  void _startStory() {
    timer?.cancel();
    _videoController?.dispose();
    final currentStory = users[userIndex]['stories'][storyIndex];

    _progressController.reset();

    if (currentStory['type'] == 'video') {
      _videoController = VideoPlayerController.asset(currentStory['url'])
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
          final duration = _videoController!.value.duration;
          _progressController.duration = duration;
          _progressController.forward();
          timer = Timer(duration, _nextStory);
        });
    } else {
      _progressController.duration = const Duration(seconds: 5);
      _progressController.forward();
      timer = Timer(const Duration(seconds: 5), _nextStory);
    }
  }

  void _nextStory() {
    if (storyIndex < users[userIndex]['stories'].length - 1) {
      setState(() {
        storyIndex++;
      });
      _startStory();
    } else if (userIndex < users.length - 1) {
      setState(() {
        userIndex++;
        storyIndex = 0;
      });
      _startStory();
    } else {
      Navigator.pop(context); // Fin des stories
    }
  }

  void _previousStory() {
    if (storyIndex > 0) {
      setState(() {
        storyIndex--;
      });
      _startStory();
    } else if (userIndex > 0) {
      setState(() {
        userIndex--;
        storyIndex = users[userIndex]['stories'].length - 1;
      });
      _startStory();
    }
  }

  void _togglePause(bool pause) {
    setState(() {
      isPaused = pause;
    });

    if (_videoController != null && _videoController!.value.isInitialized) {
      pause ? _videoController!.pause() : _videoController!.play();
    }

    pause ? _progressController.stop() : _progressController.forward();

    if (pause) {
      timer?.cancel();
    } else {
      final currentStory = users[userIndex]['stories'][storyIndex];
      final duration = currentStory['type'] == 'video'
          ? _videoController!.value.duration
          : const Duration(seconds: 5);
      timer = Timer(duration, _nextStory);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = users[userIndex];
    final story = user['stories'][storyIndex];

    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (details) {
                final width = MediaQuery.of(context).size.width;
                if (details.globalPosition.dx < width / 3) {
                  // TAP GAUCHE → story suivante
                  _nextStory();
                } else if (details.globalPosition.dx > 2 * width / 3) {
                  // TAP DROITE → story précédente
                  _previousStory();
                }
              },
              onLongPressStart: (_) => _togglePause(true),
              onLongPressEnd: (_) => _togglePause(false),
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0 && userIndex < users.length - 1) {
                  // SWIPE GAUCHE → utilisateur suivant
                  setState(() {
                    userIndex++;
                    storyIndex = 0;
                  });
                  _startStory();
                } else if (details.primaryVelocity! > 0 && userIndex > 0) {
                  // SWIPE DROITE → utilisateur précédent
                  setState(() {
                    userIndex--;
                    storyIndex = 0;
                  });
                  _startStory();
                }
              },
            ),
          ),
          // Media (image ou vidéo)
          Container(
            color: Colors.black,
            child: Center(
              child: story['type'] == 'image'
                  ? Image.asset(
                story['url'],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
                  : (_videoController != null && _videoController!.value.isInitialized)
                  ? AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              )
                  : const CircularProgressIndicator(),
            ),
          ),
          // Barre du haut
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: users[userIndex]['stories'].asMap().entries.map<Widget>(
                        (entry) {
                      final index = entry.key;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: index == storyIndex
                              ? ValueListenableBuilder<double>(
                            valueListenable: progressValue,
                            builder: (context, value, _) {
                              return LinearProgressIndicator(
                                value: value,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                minHeight: 2,
                              );
                            },
                          )
                              : LinearProgressIndicator(
                            value: index < storyIndex ? 1 : 0,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            minHeight: 2,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(user['profile']),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      user['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Icônes + TextField en bas
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Like icon (resté en Icon)
                Icon(Icons.favorite_border, color: Colors.white, size: 24),

                // TextField au centre
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Envoyer un message...",
                        hintStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black54,
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),

                // Commentaire et partage en images
                Row(
                  children: [
                    Image.asset(
                      'images/avatar/comme.png',
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                    SizedBox(width: 16),
                    Image.asset(
                      'images/avatar/share.png',
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
