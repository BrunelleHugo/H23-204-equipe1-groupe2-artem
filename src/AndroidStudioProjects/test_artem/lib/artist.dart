import 'package:flutter/material.dart';
import 'package:test_artem/inscription.dart';
import 'package:test_artem/profil.dart';

class Artiste extends StatelessWidget {
  const Artiste({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
              child: Placeholder(), // Replace with your picture
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
            const SizedBox(height: 20),
            const Text(
              'Intérêts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Intérêt 1'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Intérêt 2'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Intérêt 3'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Palette de couleurs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 30,
                ),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 30,
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                ),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 30,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Placeholder(), // Replace with your picture
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Placeholder(), // Replace with your picture
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
