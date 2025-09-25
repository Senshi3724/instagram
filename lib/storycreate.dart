import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'appareilphoto.dart';
import 'dart:io';

class StoryCreatorScreen extends StatefulWidget {
  const StoryCreatorScreen({super.key});

  @override
  State<StoryCreatorScreen> createState() => _StoryCreatorScreenState();
}

class _StoryCreatorScreenState extends State<StoryCreatorScreen> {
  final List<File> _galleryFiles = [];
  final ImagePicker _picker = ImagePicker();

  String dropdownValue = 'Récent';

  // Ta liste fixe 11 fois le même chemin
  final List<String> _assetImages = [
    'images/avatar/profile1.png',
    'images/avatar/profile2.jpg',
    'images/avatar/profile3.jpg',
    'images/avatar/profile4.jpg',
    'images/avatar/profile5.jpeg',
    'images/avatar/profile6.jpg',
    'images/avatar/profile7.jpg',
    'images/avatar/profile1.png',
    'images/avatar/profile2.jpg',
    'images/avatar/profile3.jpg',
    'images/avatar/profile4.jpg',
    'images/avatar/profile5.jpeg',
    'images/avatar/profile6.jpg',
    'images/avatar/profile7.jpg',
    'images/avatar/profile1.png',
    'images/avatar/profile2.jpg',
    'images/avatar/profile3.jpg',
    'images/avatar/profile4.jpg',
    'images/avatar/profile5.jpeg',
    'images/avatar/profile6.jpg',
    'images/avatar/profile7.jpg',
  ];

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _galleryFiles.addAll(pickedFiles.map((xfile) => File(xfile.path)));
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        _galleryFiles.add(File(pickedVideo.path));
      });
    }
  }

  void _onMediaPick() {
    if (dropdownValue == "Vidéos") {
      _pickVideo();
    } else if (dropdownValue == "Récent" || dropdownValue == "Photos") {
      _pickImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ajouter à la story',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _buildStoryOption(
                    icon: Icons.bubble_chart,
                    label: 'Modèles',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStoryOption(
                    icon: Icons.music_note,
                    label: 'Musique',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    dropdownColor: Colors.grey[800],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      }
                    },
                    items: <String>['Récent', 'Galerie', 'Photos', 'Vidéos']
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library_outlined, color: Colors.white),
                  onPressed: _onMediaPick,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: _galleryFiles.isEmpty
                  ? _assetImages.length + 1
                  : _galleryFiles.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CameraPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                }

                if (_galleryFiles.isNotEmpty) {
                  final file = _galleryFiles[index - 1];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(file),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  final assetPath = _assetImages[index - 1];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(assetPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
