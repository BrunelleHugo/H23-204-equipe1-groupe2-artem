import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:test_artem/artist.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body:SingleChildScrollView(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const SizedBox(height: 60.0),
            const Text(
              'Profil',
              style: TextStyle(
                fontSize: 66.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Nom:               ',style: TextStyle(fontSize: 22),),
                const SizedBox(width: 10.0),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Entrez votre nom',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Adresse courriel:',style: TextStyle(fontSize: 22),),
                const SizedBox(width: 10.0),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Entrez votre adresse courriel',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Intérets',
              style: TextStyle(
                fontSize: 28.0,
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
                fontSize: 28.0,
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
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 10.0),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Artiste()),
                );
              },
              child: const Text(
                'Devenir un artiste',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ],
        ),
      ),),
    );
  }
}