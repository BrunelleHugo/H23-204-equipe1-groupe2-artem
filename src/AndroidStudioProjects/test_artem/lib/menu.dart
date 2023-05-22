import 'package:flutter/material.dart';
import 'package:test_artem/connexion.dart';
import 'package:test_artem/profil.dart';
import 'package:test_artem/portfolio.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.home),
            iconColor: Colors.black,
            title: Text('Accueil'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            iconColor: Colors.black,
            title: Text('Profil'),
            onTap: () => {Navigator.of(context).pop(),
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profil())),},
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            iconColor: Colors.black,
            title: Text('Portfolio'),
            onTap: () => {Navigator.of(context).pop(),
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Portfolio())),},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            iconColor: Colors.black,
            title: Text('Déconnexion'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => Connexion())),
            },
          ),
        ],
      ),
    );
  }
}