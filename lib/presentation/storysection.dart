import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wathsapp/storycreate.dart';
import '../main.dart';
import '../storyvisuel.dart';

class StorySection extends StatelessWidget {
  StorySection({super.key});

  final List<Map<String, dynamic>> favoriteContacts = [
    {
      "name": "Votre Story",
      "profile": "images/avatar/profile1.png",
      "stories": [
        {"type": "image", "url": "images/avatar/profile2.jpg"},
        {"type": "video", "url": "assets/videos/reel1.mp4"},
        {"type": "image", "url": "images/avatar/profile4.jpg"},
      ],
    },
    {
      "name": "Raion",
      "profile": "images/avatar/profile2.jpg",
      "stories": [
        {"type": "video", "url": "assets/videos/reel2.mp4"},
        {"type": "image", "url": "images/avatar/profile3.jpg"},
      ],
    },
    {
      "name": "Senshi",
      "profile": "images/avatar/profile3.jpg",
      "stories": [
        {"type": "image", "url": "images/avatar/profile5.jpeg"},
        {"type": "image", "url": "images/avatar/profile1.png"},
        {"type": "video", "url": "assets/videos/reel3.mp4"},
      ],
    },
    {
      "name": "Lamine",
      "profile": "images/avatar/profile4.jpg",
      "stories": [
        {"type": "image", "url": "images/avatar/profile6.jpg"},
      ],
    },
    {
      "name": "Diassy",
      "profile": "images/avatar/profile5.jpeg",
      "stories": [
        {"type": "video", "url": "assets/videos/reel4.mp4"},
        {"type": "video", "url": "assets/videos/reel5.mp4"},
      ],
    },
    {
      "name": "Mamadou",
      "profile": "images/avatar/profile6.jpg",
      "stories": [
        {"type": "image", "url": "images/avatar/profile7.jpeg"},
        {"type": "image", "url": "images/avatar/profile1.png"},
        {"type": "video", "url": "assets/videos/reel6.mp4"},
        {"type": "image", "url": "images/avatar/profile2.jpg"},
      ],
    },
    {
      "name": "Atomik",
      "profile": "images/avatar/profile7.jpeg",
      "stories": [
        {"type": "video", "url": "assets/videos/reel7.mp4"},
        {"type": "image", "url": "images/avatar/profile3.jpg"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarSize = screenWidth * 0.23;
    double borderWidth = screenWidth * 0.01;
    double fontSize = screenWidth * 0.030;

    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
      height: avatarSize + fontSize + 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favoriteContacts.length,
        padding: EdgeInsets.only(left: screenWidth * 0.03),
        itemBuilder: (context, index) {
          final favorite = favoriteContacts[index];

          return Container(
            margin: EdgeInsets.only(right: screenWidth * 0.04),
            width: avatarSize,
            child: Column(
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: index == 0
                          ? null
                          : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryViewScreen(
                              allContactsWithStories: favoriteContacts,
                              initialUserIndex: index,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(borderWidth),
                        height: avatarSize,
                        width: avatarSize,
                        decoration: const BoxDecoration(
                          gradient: color_insta,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: borderWidth),
                            image: DecorationImage(
                              image: AssetImage(favorite['profile']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (index == 0)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StoryCreatorScreen()),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(screenWidth * 0.012),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.015),
                Text(
                  favorite['name'],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
