import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profil',
              style: TextStyle(
                fontSize: 56.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Nom:'),
                const SizedBox(width: 10.0),
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.grey[300],
                  child: const TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Adresse courriel:'),
                const SizedBox(width: 10.0),
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.grey[300],
                  child: const TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Intérêts',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.red,
                ),
                SizedBox(width: 10.0),
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 10.0),
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.purple,
                ),
                SizedBox(width: 10.0),
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.deepPurple,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Palette de couleurs',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                'Devenir un artiste',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
