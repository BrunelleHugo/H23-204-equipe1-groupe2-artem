import 'package:flutter/material.dart';
import 'package:test_artem/connexion.dart';
import 'package:test_artem/inscription.dart';

final ThemeData myTheme = ThemeData( fontFamily: 'Oswald',
  primarySwatch: MaterialColor(
    0xFFDECEB4,
    <int, Color>{
      50: Color.fromRGBO(222, 206, 180, 0.1),
      100: Color.fromRGBO(222, 206, 180, 0.2),
      200: Color.fromRGBO(222, 206, 180, 0.3),
      300: Color.fromRGBO(222, 206, 180, 0.4),
      400: Color.fromRGBO(222, 206, 180, 0.5),
      500: Color.fromRGBO(222, 206, 180, 0.6),
      600: Color.fromRGBO(222, 206, 180, 0.7),
      700: Color.fromRGBO(222, 206, 180, 0.8),
      800: Color.fromRGBO(222, 206, 180, 0.9),
      900: Color.fromRGBO(222, 206, 180, 1.0),
    },
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,

      home: Connexion(),
    );
  } 
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [Connexion(), Inscription()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Connexion'),
      // ),
      body: pages[0],



      floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('Floating action button');
          },
          child: Icon(Icons.home)),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}