import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Artiste extends StatefulWidget {
  const Artiste({Key? key}) : super(key: key);

  @override
  _ArtisteState createState() => _ArtisteState();
}

class _ArtisteState extends State<Artiste> {
  final List<Color> _selectedColors = [
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.red
  ];
  List<String> choices1 = ['Contemporain', 'Moderne', 'Abstrait', 'Graffiti'];
  String selectedChoice1 = 'Contemporain';
  String selectedChoice2 = 'Contemporain';
  String selectedChoice3 = 'Contemporain';

  final List<Widget> _profileImageWidgets = [];
  final List<Widget> _artImageWidgets = [];

  Future<void> _checkPermission(BuildContext context) async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
      if (!status.isGranted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permissions insuffisantes'),
            content: const Text(
                'Veuillez autoriser l\'accès aux photos pour pouvoir ajouter des photos.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
    }
    // Ici, vous pouvez accéder à la galerie de photos car la permission est accordée.
  }


  void _addPhotoProfile() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImageWidgets.clear(); // remove any previous profile picture
          _profileImageWidgets.add(
            Stack(
              children: [
                Image.file(
                  File(pickedFile.path),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () => _deletePhotoProfile(),
                    icon: const Icon(Icons.delete,color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        });
      }
    }
  }

  void _addPhotoArt() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _artImageWidgets.add(
            Stack(
              children: [
                Image.file(
                  File(pickedFile.path),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () => _deletePhotoArt(_artImageWidgets.length - 1),
                    icon: const Icon(Icons.delete,color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        });
      }
    }
  }

  void _deletePhotoProfile() {
    setState(() {
      _profileImageWidgets.clear();
    });
  }

  void _deletePhotoArt(int index) {
    setState(() {
      _artImageWidgets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Profil d\'Artiste'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profil d\'Artiste',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Center(
              child: InkWell(
                onTap: () => _addPhotoProfile(),
                child: SizedBox(
                  height: 200.0,
                  width: 150.0,
                  child: _profileImageWidgets.isEmpty
                      ? const Icon(
                    Icons.add_a_photo,
                    color: Colors.black,
                    size: 40.0,
                  )
                      : _profileImageWidgets[0],
                ),
              ),
            ),



            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Nom complet',
                  hintStyle: TextStyle(color: Colors.black,),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Qui suis-je?',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Comment me joindre',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 10.0),
            const Text(
              'Intérets',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: selectedChoice1,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedChoice1 = newValue!;
                    });
                  },
                  items: choices1
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
                DropdownButton<String>(
                  value: selectedChoice2,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedChoice2 = newValue!;
                    });
                  },
                  items: choices1
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
                DropdownButton<String>(
                  value: selectedChoice3,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedChoice3 = newValue!;
                    });
                  },
                  items: choices1
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Couleurs',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _selectedColors.length,
                (index) => GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Choisis une couleur'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: _selectedColors[index],
                              onColorChanged: (Color color) {
                                setState(() {
                                  _selectedColors[index] = color;
                                });
                              },
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: _selectedColors[index],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 10.0),
            const Text(
              'Oeuvres d\'art',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _checkPermission(context);
                _addPhotoArt();
              },
              child: const Text('Ajouter une photo'),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _artImageWidgets
                  .asMap()
                  .map(
                    (index, widget) => MapEntry(
                      index,
                      Stack(
                        children: [
                          widget,
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete,color: Colors.white,),
                              onPressed: () => _deletePhotoArt(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
