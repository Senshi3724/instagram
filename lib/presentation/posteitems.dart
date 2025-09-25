import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostItem extends StatefulWidget {
  final Map item;

  const PostItem({super.key, required this.item});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  VideoPlayerController? _videoController;
  bool isLiked = false;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = int.tryParse(widget.item['like']) ?? 0;

    if (widget.item['post'].endsWith('.mp4')) {
      _videoController = VideoPlayerController.asset(widget.item['post'])
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_videoController != null && _videoController!.value.isInitialized) {
      if (info.visibleFraction > 0.7 && !_videoController!.value.isPlaying) {
        _videoController!.play();
      } else if (info.visibleFraction < 0.3 &&
          _videoController!.value.isPlaying) {
        _videoController!.pause();
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: _videoController?.value.aspectRatio ?? 16 / 9,
              child:
                  item['post'].endsWith('.mp4')
                      ? (_videoController != null &&
                              _videoController!.value.isInitialized)
                          ? VisibilityDetector(
                            key: Key(item['post']),
                            onVisibilityChanged: _onVisibilityChanged,
                            child: VideoPlayer(_videoController!),
                          )
                          : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                      : Image.asset(
                        item['post'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(item['profile']),
                    radius: screenWidth * 0.04,
                  ),
                  SizedBox(width: screenWidth * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            item['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          if (item['sertifier'])
                            Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: screenWidth * 0.03,
                            ),
                        ],
                      ),
                      if (item['audio'] != '')
                        Row(
                          children: [
                            Icon(
                              Icons.music_note,
                              color: Colors.grey,
                              size: screenWidth * 0.03,
                            ),
                            Text(
                              item['audio'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: screenWidth * 0.030,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: screenWidth * 0.05,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          color: Colors.black87,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenWidth * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Bouton Like
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isLiked ? likeCount-- : likeCount++;
                        isLiked = !isLiked;
                      });
                    },
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_outline,
                      color: isLiked ? Colors.red : Colors.white,
                      size: screenWidth * 0.06,
                    ),
                  ),
                  Text(
                    likeCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.025),
                  GestureDetector(
                    onTap: () {
                      List<Map<String, String>> comments =
                          List<Map<String, String>>.from(
                            widget.item['comments'] ?? [],
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentPage(comments: comments),
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        final rawComments = widget.item['comments'];
                        if (rawComments != null && rawComments is List) {
                          try {
                            List<Map<String, String>> comments =
                                List<Map<String, String>>.from(rawComments);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        CommentPage(comments: comments),
                              ),
                            );
                          } catch (e) {
                            if (kDebugMode) {
                              print(
                                'Erreur lors de la conversion des commentaires : $e',
                              );
                            }
                          }
                        } else {
                          if (kDebugMode) {
                            print(
                              'Aucun commentaire trouvé ou format invalide.',
                            );
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'images/avatar/comme.png',
                            width: screenWidth * 0.06,
                          ),
                          SizedBox(width: screenWidth * 0.015),
                          Text(
                            item['comment'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //partage
                  SizedBox(width: screenWidth * 0.015),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.black,
                        isScrollControlled: true,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.55,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => ShareModal(),
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'images/avatar/share.png',
                          width: screenWidth * 0.06,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.item['partage'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.bookmark_outline,
                    color: Colors.white,
                    size: screenWidth * 0.06,
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.015),
              Text(
                item['description'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.035,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                item['date'],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.03,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CommentPage extends StatefulWidget {
  final List<Map<String, dynamic>> comments;

  const CommentPage({super.key, required this.comments});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<bool> liked = [];

  @override
  void initState() {
    super.initState();
    liked = List.generate(widget.comments.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final _ = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Commentaires",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.comments.length,
              itemBuilder: (context, index) {
                final comment = widget.comments[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(comment['avatar']),
                        radius: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${comment['name']} ",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  TextSpan(
                                    text: comment['text'],
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              comment['date'] ?? "2 h",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            liked[index] = !liked[index];
                            if (liked[index]) {
                              comment['likes'] = (comment['likes'] ?? 0) + 1;
                            } else {
                              comment['likes'] = (comment['likes'] ?? 1) - 1;
                            }
                          });
                        },
                        child: Icon(
                          liked[index] ? Icons.favorite : Icons.favorite_border,
                          color: liked[index] ? Colors.red : Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Zone de réaction et de saisie
          const Divider(color: Colors.grey, thickness: 0.2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("images/avatar/ton_avatar.png"),
                  radius: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Lancez la conversation...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Row(
                  children: const [
                    Text("❤", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 5),
                    Text("🙌", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 5),
                    Text("🔥", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 5),
                    Text("👏", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 5),
                    Text("😢", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 5),
                    Text("😍", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 5),
                    Text("😮", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 5),
                    Text("😂", style: TextStyle(fontSize: 18)),
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

class ShareModal extends StatelessWidget {
  final List<Map<String, String>> friends = [
    {"name": "Mouhamed", "avatar": "images/avatar/profile1.png"},
    {"name": "Mouha Salam", "avatar": "images/avatar/profile2.jpg"},
    {"name": "MamadouNdir", "avatar": "images/avatar/profile3.jpg"},
    {"name": "Sall Ngary", "avatar": "images/avatar/profile4.jpg"},
    {"name": "kamou_badji", "avatar": "images/avatar/profile5.jpeg"},
    {"name": "Awa", "avatar": "images/avatar/profile6.jpg"},
    {"name": "Binta", "avatar": "images/avatar/profile7.jpeg"},
    {"name": "Sidy", "avatar": "images/avatar/profile2.jpg"},
  ];

  final List<Map<String, dynamic>> shareOptions = [
    {"icon": Icons.add_circle_outline, "label": "Ajouter à la story"},
    {"icon": Icons.update, "label": "Statut WhatsApp"},
    {"icon": FontAwesomeIcons.squareWhatsapp, "label": "WhatsApp"},
    {"icon": Icons.share, "label": "Partager"},
    {"icon": Icons.link, "label": "Copier le lien"},
    {"icon": Icons.email_outlined, "label": "Email"},
    {"icon": Icons.facebook, "label": "Facebook"},
    {"icon": Icons.message, "label": "Messages"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Rechercher",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.grey[900],
                radius: 22,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_add_alt_1,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// GridView pour amis
          SizedBox(
            height: 200,
            child: GridView.builder(
              itemCount: friends.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,      // Signifie 2 lignes puisque scrollDirection est horizontal
                mainAxisSpacing: 12,    // Espacement horizontal entre les colonnes d'items
                crossAxisSpacing: 12,   // Espacement vertical entre les items dans une colonne
                childAspectRatio: 0.8,  // (Largeur d'un item) / (Hauteur d'un item PAR LIGNE)
              ),
              itemBuilder: (context, index) {
                final friend = friends[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(friend['avatar']!),
                      radius: 30,
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        friend['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis, // Gère le texte trop long
                        textAlign: TextAlign.center,
                        maxLines: 2, // Permet au nom de s'étendre sur 2 lignes si besoin
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          /// Options de partage
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: shareOptions.length,
              itemBuilder: (context, index) {
                final option = shareOptions[index];
                final String label = option['label'] as String;

                Color iconColor = Colors.white;
                Color avatarBackgroundColor = Colors.grey.withOpacity(0.3);

                if (label == "Statut WhatsApp" || label == "WhatsApp") {
                  avatarBackgroundColor = Colors.green.withOpacity(0.8);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: avatarBackgroundColor,
                        child: Icon(
                          option['icon'] as IconData?,
                          color: iconColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 70,
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },

            ),
          ),
        ],
      ),
    );
  }
}
