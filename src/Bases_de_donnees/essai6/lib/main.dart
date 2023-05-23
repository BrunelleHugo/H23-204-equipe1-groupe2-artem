// @dart=2.9

import 'dart:collection';
import 'dart:ffi';
import 'dart:io';
import 'dart:core';

import 'package:essai6/compatibilityimage.dart';
import 'package:googleapis/datastream/v1.dart';
import 'package:postgres/postgres.dart';

import 'package:flutter/services.dart';

import 'package:chalkdart/chalk.dart';

import 'package:palette_generator/palette_generator.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:googleapis/vision/v1.dart' as vis;

import 'compatibilityusers.dart';

import 'dart:convert';

// Connexion à PostgreSQL
final connect_computer = PostgreSQLConnection(
  '::1',
  5432,
  'postgres',
  username: 'postgres',
  password: 'root',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await connect_computer.open(); // Ouverture de la connexion

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green[100],
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PaletteGenerator _paletteGenerator;

  List<Color> colorPaletteUser;

// Strings to store the extracted Article titles
  String result1 = 'Result 1';

// boolean to show CircularProgressIndication
// while Web Scraping awaits
  bool isLoading = false;

  Uint8List uint;
  File imageFile;

// Liste des différents utilisateurs de SaatchiArt auxquelles nous allons prendre les données
  List<int> users = [
    236057,
    405418,
    283153,
    42651,
    8102,
    18401,
    726323,
    302,
    618199,
    503,
    400553
  ];

  Future<List> saveNetworkImageToFile(String imageUrl) async {
    // Prise de données d'une image par un site internet
    final response = await http.get(Uri.parse(imageUrl));
    // Conversion de l'image en Uint8List
    uint = ((response.statusCode == 200) ? response.bodyBytes : null);

    Image im = Image.memory(
      uint,
      scale: 2.0,
    );
    ImageProvider imPro = im.image;

    //Considère les cinq couleurs principales de l'image
    var paletteGenerator =
        await PaletteGenerator.fromImageProvider(imPro, maximumColorCount: 5);
    var colors = paletteGenerator.colors;
    var collist = [];

    // Liste des cinq couleurs principales en RGB
    for (Color color in colors) {
      var red = color.red, green = color.green, blue = color.blue;
      collist.add([red, green, blue]);
    }

    // Ajoute la couleur principale de chaque image à une liste associée à
    // l'utilisateur
    var col = paletteGenerator.dominantColor.color;
    colorPaletteUser.add(col);

    return collist;
  }

  Future<List<String>> extractData(int k) async {
    // Getting the response from the targeted url
    colorPaletteUser = [];
    List list = [];
    final response = await http.Client().get(Uri.parse(
        'http://www.saatchiart.com/account/artworks/${users.elementAt(k)}'));

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {
      // Getting the html document from the response
      var document = parser.parse(response.body);
      try {
        // Scraping the first article title
        var classlor = document
            .getElementsByClassName("sc-1ypbzzj-4 sc-9pmg3r-2 cgnOZJ kpSjBp");
        var usagers = document.getElementsByTagName('img');
        var nom, avatar;

        for (var usager in usagers) {
          var fl = usager.attributes['src'];

          if (fl != null && fl.contains(RegExp(r'^http.*\.(jpg|png|jpeg)'))) {
            nom = usager.attributes['alt'];
            avatar = usager.attributes['src'];
            break;
          }
        }

        for (var h = 0; h < classlor.length; h++) {
          // Cherche les informations précises une image à la fois
          var oeuvre, dimension, imageUrl;
          var case1 = classlor[h].children[0];
          var img = case1.getElementsByTagName("img");
          var h2 = case1.getElementsByTagName("h2");
          var h4 = case1.getElementsByTagName("h4")[0].children;

          for (var image in img) {
            imageUrl = (image.attributes['src'] != null)
                ? image.attributes['src']
                : image.attributes['data-src'];
          }

          for (var h21 in h2) {
            oeuvre ??= h21.text;
          }

          for (var h41 in h4) {
            dimension ??= h41.text;
          }

          // S'il s'agit d'une image, on rajoute l'image en fichier Uint8List,
          // le nom de l'oeuvre, les 5 couleurs dominantes de l'image et les
          // dimensions de l'oeuvre
          if (imageUrl != null) {
            if (imageUrl.startsWith(RegExp(r'^http.*\.(jpg|png|jpeg)'))) {
              var c5 = await saveNetworkImageToFile(imageUrl);
              list.add([uint, oeuvre.toString(), c5, dimension]);
            }
          }
        }

        List c = colorPaletteUser;
        List compar = [];

        // Prend 5 couleurs de la liste des couleurs dominantes de chaque images
        // de l'utilisateur
        List ind = [
          0,
          (c.length / 4).floor(),
          (c.length / 2).floor(),
          (3 * c.length / 4).floor(),
          (c.length - 1)
        ];

        for (int j = 0; j < ind.length; j++) {
          compar.add([c[ind[j]].red, c[ind[j]].green, c[ind[j]].blue]);
        }

        // Transformation d'une image web en fichier Uint8List
        final r1 = await http.get(Uri.parse(avatar));
        final tuint = ((r1.statusCode == 200) ? r1.bodyBytes : null);

        // Encodage des listes en JSONB
        final h = jsonEncode(compar);
        final li = jsonEncode(list);

        // Rajout des données dans le tableau de users_compatible
        await connect_computer.execute(
            'INSERT INTO users_compatible (id, email, mdp, nom, avatar, lien, palette, oeuvres) VALUES (@id, @email, @mdp, @nom, ARRAY $tuint, @lien, @palette, @oeuvres)',
            substitutionValues: {
              'id': k,
              'email':
                  "${nom.toString().replaceAll(' ', '.').toLowerCase()}@gmail.com",
              'mdp': k.toString(),
              'nom': nom.toString(),
              'lien':
                  'http://www.saatchiart.com/account/artworks/${users.elementAt(k)}',
              'palette': h,
              'oeuvres': li,
            });
      } catch (Exception) {
        print(Exception.toString());
      }
    }
    return ['', '', 'ERROR STATUS CODE WASNT 200!'];
  }

  Future<List<String>> images_aimees() async {
    // Sélection des oeuvres et des palettes de couleurs des utilisateurs et on
    // la transforme en liste
    var o = await connect_computer
        .query('SELECT ALL oeuvres FROM users_compatible');
    var p = await connect_computer
        .query('SELECT ALL palette FROM users_compatible');

    final oeuvres = o.map((row) => row[0]).toList();
    final palette = p.map((row) => row[0]).toList();

    Map<List, double> toile = {};

    // Liste des id dans l'ordre donné par le tableau
    var ild = await connect_computer.query('SELECT id FROM users_compatible');
    var id = ild.map((row) => row[0]).toList();

    for (int i in id) {
      toile.clear();
      for (int j in id) {
        if (j != i) {
          for (int l = 0; l < oeuvres[j].length; l++) {
            // Ajout du calcul de compatibilité entre les oeuvres en fonction
            // des palettes de couleurs des utilisateurs et des palettes de
            // couleurs de l'image
            toile[oeuvres[j][l]] = (CompatibilityImage.total(
                (palette[i]).toSet(), (oeuvres[j][l][2]).toSet()));
          }
        }
      }

      // Mise en ordre de la liste pour avoir ceux ayant un niveau de
      // compatibilité maximale en haut de la liste
      var sortedMap = SplayTreeMap<List, double>.from(
          toile, (a, b) => toile[a].compareTo(toile[b]));

      List jasd = sortedMap.keys.toList();
      jasd.reversed;

      jasd = jasd.take(10).toList();
      // Encodage de la liste des dix premières oeuvres de la liste ayant un
      // grand niveau de compatibilité avec la palette de l'utilisateur
      var l = jsonEncode(jasd);

      // Ajout de la liste encodées dans la colonne aimées à un id spécifique
      await connect_computer.execute(
          'UPDATE users_compatible SET aimees = @aimees WHERE id = @id',
          substitutionValues: {'aimees': l, 'id': i});
    }
  }

  Future<List<String>> interets_communs() async {
    // Sélection des palettes de couleurs et des images aimées de l'utilisateur
    // et on la transforme en liste
    final p = await connect_computer
        .query('SELECT ALL palette FROM users_compatible');
    final a =
        await connect_computer.query('SELECT ALL aimees FROM users_compatible');

    final palette = p.map((row) => row[0]).toList();
    final aimees = a.map((row) => row[0]).toList();

    Map<int, double> match = {};

    // Liste des id dans l'ordre donné par le tableau
    var ild = await connect_computer.query('SELECT id FROM users_compatible');
    var id = ild.map((row) => row[0]).toList();

    for (int i in id) {
      match.clear();
      for (int j in id) {
        if (j != i) {
          // Ajout du résultat au calcul de la compatibilité entre les
          // utilisateurs
          match[j] = (CompatibilityUsers.ensemble((palette[i]).toSet(),
              (palette[j]).toSet(), aimees[i], aimees[j]));
        }
      }

      // Mise en ordre de la liste pour avoir ceux ayant un niveau de
      // compatibilité maximale en haut de la liste
      var sortedMap = SplayTreeMap<int, double>.from(
          match, (a, b) => match[a].compareTo(match[b]));

      List mat = sortedMap.keys.toList();

      mat = mat.reversed.take(10).toList();
      // Encodage de la liste des dix premiers utilisateurs de la liste ayant un
      // grand niveau de compatibilité avec l'utilisateur
      var m = jsonEncode(mat);

      // Ajout de la liste encodées dans la colonne aimées à un id spécifique
      await connect_computer.execute(
          'UPDATE users_compatible SET compat = @compat WHERE id = @id',
          substitutionValues: {'compat': m, 'id': i});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if isLoading is true show loader
            // else show Column of Texts
            isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Text(result1,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            MaterialButton(
              onPressed: () async {
                // Setting isLoading true to show the loader
                setState(() {
                  isLoading = true;
                });

                final response = [];
                // Awaiting for web scraping function
                // to return list of strings
                for (int k = 0; k < users.length; k++) {
                  response.add(await extractData(k));
                }
                await images_aimees();
                await interets_communs();
                await connect_computer.close();
                print("finito");

                // Setting the received strings to be
                // displayed and making isLoading false
                // to hide the loader
                setState(() {
                  result1 = "response[0]";
                  isLoading = false;
                });
              },
              color: Colors.green,
              child: const Text(
                'Scrap Data',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )),
      ),
    );
  }
}
