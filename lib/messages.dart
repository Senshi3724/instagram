import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
const LinearGradient color_insta = LinearGradient(
  colors: [
    Color(0xFFFEDA75),
    Color(0xFFFA7E1E),
    Color(0xFFD62976),
    Color(0xFF962FBF),
    Color(0xFF4F5BD5),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  final List<Map<String, dynamic>> messages = const [
    {
      "profile": "images/avatar/profile1.png",
      "name": "Ousman",
      "time": "43 min",
      "messageCount": 4,
    },
    {
      "profile": "images/avatar/profile2.jpg",
      "name": "Lamine😎😎",
      "time": "55 min",
      "messageCount": 5,
      "muted": true,
    },
    {
      "profile": "images/avatar/profile3.jpg",
      "name": "Raion",
      "time": "2 h",
      "messageCount": 5,
      "muted": true,
    },
    {
      "profile": "images/avatar/profile4.jpg",
      "name": "LamineDiassy😒🤴⛩️",
      "time": "12 h",
      "messageCount": 5,
      "photo": true,
    },
    {
      "profile": "images/avatar/profile5.jpeg",
      "name": "Mouha Salam",
      "time": "13 h",
      "messageCount": 2,
      "photo": true,
    },
    {
      "profile": "images/avatar/profile6.jpg",
      "name": "Le Bosse 🇸🇳★",
      "time": "13 h",
      "messageCount": 5,
      "photo": true,
    },
    {
      "profile": "images/avatar/profile7.jpg",
      "name": "Ousman",
      "time": "43 min",
      "messageCount": 4,
      "photo": true,
    },
    {
      "profile": "images/avatar/profile1.png",
      "name": "Lamine😎😎",
      "time": "55 min",
      "messageCount": 5,
      "muted": true,
    },
    {
      "profile": "images/avatar/profile2.jpg",
      "name": "Raion",
      "time": "2 h",
      "messageCount": 5,
      "muted": true,
      "photo": true,
    },
    {
      "profile": "images/avatar/profile3.jpg",
      "name": "LamineDiassy😒🤴⛩️",
      "time": "12 h",
      "messageCount": 5,
    },
    {
      "profile": "images/avatar/profile4.jpg",
      "name": "Mouha Salam",
      "time": "13 h",
      "messageCount": 2,
      "photo": true,
    },
    {
      "profile": "images/avatar/profile5.jpeg",
      "name": "Le Bosse 🇸🇳★",
      "time": "13 h",
      "messageCount": 5,
      "photo": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back, color: Colors.white)),
        title: Row(
          children: [
            Text("momo__s...", style: GoogleFonts.poppins(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold)),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
        actions: [
          Icon(Icons.format_list_bulleted, color: Colors.white),
          SizedBox(width: 10),
          Icon(Icons.trending_up, color: Colors.white),
          SizedBox(width: 10),
          Icon(Icons.edit_square, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SizedBox(
              height: width * 0.12,
              child: Row(
                children: [
                  const AnimatedGradientRing(size: 25, strokeWidth: 3),
                  const SizedBox(width: 10),
                  Text("Demender a Meta AI ou rechercher", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
          ),
          const MessageNoteSection(),
          const MessageFiltersBar(),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final item = messages[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: width * 0.07,
                        backgroundImage: AssetImage(item["profile"]),
                      ),
                      title: Text(
                        item["name"],
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        "${item["messageCount"]} nouveaux messages",
                        style: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item["time"],
                            style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (item["muted"] == true)
                                const Icon(Icons.volume_off, color: Colors.grey, size: 16),
                              if (item["photo"] == true)
                                const Icon(Icons.circle, color: Colors.blue, size: 10),
                                const Icon(Icons.photo_camera_outlined, color: Colors.white, size: 28),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class MessageNoteSection extends StatelessWidget {
  const MessageNoteSection({super.key});

  final List<Map<String, String>> notes = const [
    {
      "text": "Qu’y a-t-il\nsur votre\nplaylist ?",
      "image": "images/avatar/profile3.jpg",
      'name': 'Votre note',
    },
    {
      "text": "Je suis en\nmission",
      "image": "images/avatar/profile1.png",
      'name': 'Mamadou',
    },
    {
      "text": "9faza\nel patron",
      "image": "images/avatar/profile2.jpg",
      'name': 'Raion',
    },
    {
      "text": "Une vibe 💯",
      "image": "images/avatar/profile4.jpg",
      'name': 'Lamine',
    },
    {
      "text": "Pas dispo !",
      "image": "images/avatar/profile5.jpeg",
      'name': 'Diassy',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: width * 0.27 + 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: notes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final note = notes[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: width * 0.2,
                    height: width * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(note["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: width * 0.2,
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        note["text"]!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 5),
              Text(
                note["name"]!,
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          );
        },
      ),
    );
  }
}
class MessageFiltersBar extends StatelessWidget {
  const MessageFiltersBar({super.key});

  final List<Map<String, dynamic>> filters = const [
    {'option': 'Principale', 'nombre': '10', 'disponible': true},
    {'option': 'Général', 'nombre': '', 'disponible': false},
    {'option': 'Invitation', 'nombre': '10', 'disponible': true},
    {'option': 'Story', 'nombre': '', 'disponible': false},
    {'option': 'Favoris', 'nombre': '1', 'disponible': true},
    {'option': 'Demandes', 'nombre': '', 'disponible': false},
    {'option': 'Spam', 'nombre': '', 'disponible': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final filter = filters[index];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (filter['disponible'] == true)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                Text(
                  filter['option'],
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                if (filter['nombre'] != '')
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      "${filter['nombre']}",
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
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
class AnimatedGradientRing extends StatefulWidget {
  final double size;
  final double strokeWidth;

  const AnimatedGradientRing({
    super.key,
    this.size = 25,
    this.strokeWidth = 3.0,
  });

  @override
  State<AnimatedGradientRing> createState() => _AnimatedGradientRingState();
}

class _AnimatedGradientRingState extends State<AnimatedGradientRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(); // Boucle infinie
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: RotationTransition(
        turns: _controller,
        child: CustomPaint(
          painter: GradientRingPainter(
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class GradientRingPainter extends CustomPainter {
  final double strokeWidth;

  GradientRingPainter({this.strokeWidth = 3.0});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final gradient = SweepGradient(
      colors: [
        Color(0xFF00FFFF),
        Color(0xFF0000FF),
        Color(0xFF8A2BE2),
        Color(0xFFDA70D6),
        Color(0xFF00FFFF),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
