import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wathsapp/presentation/poste.dart';
import 'package:wathsapp/presentation/storysection.dart';
import '../messages.dart';
import '../notification.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.black,
          elevation: 0,
          toolbarHeight: 50,
          title: Container(
            margin: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 120,
              child: Image.asset('images/avatar/inst.png'),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 4, right: 3),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationSection()),
                      );
                    },
                    icon: const Icon(Icons.favorite_outline, color: Colors.white, size: 26),
                  ),
                  Positioned(
                    top: 7,
                    right: 10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MessagePage()),
                    );
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.facebookMessenger,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 25,
                    height: 20,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SliverToBoxAdapter(child: StorySection()),
        SliverToBoxAdapter(child: PostSection()),
      ],
    );
  }
}