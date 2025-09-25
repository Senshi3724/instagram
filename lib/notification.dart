import 'package:flutter/material.dart';

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  static const List<Map<String, dynamic>> notif = [
    {
      "date": "aujourd'hui",
      "list": [
        {
          "name": "Raion",
          "profile": "images/avatar/profile2.jpg",
          "message": "a aimé votre vidéo"
        },
        {
          "name": "Lamine",
          "profile": "images/avatar/profile4.jpg",
          "message": "a commencé à vous suivre"
        },
        {
          "name": "Tafa",
          "profile": "images/avatar/profile6.jpg",
          "message": "a commenté votre post"
        },
      ]
    },
    {
      "date": "hier",
      "list": [
        {
          "name": "Mamadou",
          "profile": "images/avatar/profile1.png",
          "message": "que vous connaissez peut-être est sur Instagram"
        },
        {
          "name": "Senshi",
          "profile": "images/avatar/profile3.jpg",
          "message": "a commencé à vous suivre"
        },
        {
          "name": "Rama",
          "profile": "images/avatar/profile5.jpeg",
          "message": "a réagi à votre story"
        },
      ]
    },
    {
      "date": '7 derniers jours',
      "list": [
        {
          "name": "Diassy",
          "profile": "images/avatar/profile5.jpeg",
          "message": "a aimé votre commentaire"
        },
        {
          "name": "Atomik, Momo, Ousmane, Mamadou et 8 autres",
          "profile1": "images/avatar/profile7.jpeg",
          "profile2": "images/avatar/profile6.jpg",
          "profile3": "images/avatar/profile5.jpeg",
          "profile4": "images/avatar/profile4.jpg",
          "profile5": "images/avatar/profile3.jpg",
          "message": "ont aimé votre commentaire"
        },
        {
          "name": "Fatou",
          "profile": "images/avatar/profile2.jpg",
          "message": "vous a mentionné dans un commentaire"
        },
      ]
    },
    {
      "date": "Suggestions",
      "list": [
        {
          "name": "Khadim",
          "profile": "images/avatar/profile3.jpg",
          "message": "nouveau sur Instagram"
        },
        {
          "name": "Ismaël",
          "profile": "images/avatar/profile4.jpg",
          "message": "personne que vous pourriez connaître"
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: notif.length,
        itemBuilder: (context, sectionIndex) {
          final section = notif[sectionIndex];
          final title = section['date'] as String;
          final List list = section['list'] as List;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              ...list.map<Widget>((item) {
                if (item.containsKey('profile1')) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: Stack(
                            children: [
                              for (int i = 1; i <= 5; i++)
                                if (item.containsKey('profile$i') && item['profile$i'] != null)
                                  Positioned(
                                    left: (i - 1) * 20.0,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(item['profile$i']),
                                      radius: 16,
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${item["name"]} ${item["message"]}',
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  );
                }

                return NotificationItem(
                  name: item['name'],
                  profile: item['profile'],
                  message: item['message'],
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}

class NotificationItem extends StatefulWidget {
  final String name;
  final String profile;
  final String message;

  const NotificationItem({
    super.key,
    required this.name,
    required this.profile,
    required this.message,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(widget.profile),
            radius: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.name} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: widget.message,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing ? Colors.grey[800] : Colors.blue.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: toggleFollow,
              child: FittedBox(
                child: Text(
                  isFollowing ? 'Suivi(e)' : 'Suivre',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
