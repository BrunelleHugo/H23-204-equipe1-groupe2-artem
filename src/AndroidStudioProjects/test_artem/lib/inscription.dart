import 'package:flutter/material.dart';
import 'package:test_artem/profil.dart';

class Inscription extends StatelessWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Inscription',
              style: TextStyle(
                fontSize: 58.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 300.0,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Nom d\'utilisateur',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 300.0,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Adresse courriel',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 300.0,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Mot de passe',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              onPressed: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profil()),
              );},
              label: const Text(
                'Suivant',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
