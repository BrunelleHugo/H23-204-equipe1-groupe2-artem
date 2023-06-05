import 'package:flutter/material.dart';
import 'package:test_artem/gallery.dart';
import 'package:test_artem/inscription.dart';
import 'package:test_artem/profil.dart';
import 'package:postgres/postgres.dart';

final connect_computer = PostgreSQLConnection(
  '::1',
  5432,
  'postgres',
  username: 'postgres',
  password: 'root',
);

class Connexion extends StatelessWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController(),
        mdpController = new TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Connexion',
            style: TextStyle(
              fontSize: 68.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: SizedBox(
              width: 300.0,
              child: TextField(
                controller: emailController,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          SizedBox(
            width: 300.0,
            child: TextField(
              controller: mdpController,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Mot de passe',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 13.0,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              await connect_computer.open();
              var utilis = await connect_computer
                  .query('SELECT id, email, mdp FROM users_compatible');
              var email = utilis.map((row) => row[0]).toList();
              if (email.contains(emailController.text)) {
                int f = email.indexOf(emailController.text);
                var mdp = utilis.map((row) => row[0]).toList();
                if (mdp.contains(mdpController.text)) {}
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Gallery()),
              );
              await connect_computer.close();
            },
            child: const Text(
              'Se connecter',
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Inscription()),
              );
            },
            child: const Text(
              'Crée un compte',
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
