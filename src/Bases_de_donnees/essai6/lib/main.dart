// @dart=2.9

import 'dart:io';
import 'dart:core';

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

final connect_computer = PostgreSQLConnection(
  '::1',
  5432,
  'postgres',
  username: 'postgres',
  password: 'root',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await connect_computer.open();

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

  final String url =
      'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/51fidJPxdzL._AC_SX466_.jpg';

// boolean to show CircularProgressIndication
// while Web Scraping awaits
  bool isLoading = false;

  Uint8List uint;
  File imageFile;

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

  Future<void> saveNetworkImageToFile(String imageUrl, String fileName) async {
    final response = await http.get(Uri.parse(imageUrl));
    uint = ((response.statusCode == 200) ? response.bodyBytes : null);

    Image im = Image.memory(
      uint,
      scale: 2.0,
    );
    ImageProvider imPro = im.image;

    var paletteGenerator =
        await PaletteGenerator.fromImageProvider(imPro, maximumColorCount: 5);
    var colors = paletteGenerator.colors;

    var col = paletteGenerator.dominantColor.color;
    colorPaletteUser.add(col);
  }

  Future<void> _myGeneratePalette(int counter) async {
    Image im = Image(
      image: AssetImage("images/chat1.jpg"),
      height: 2048,
      width: 2048,
    );

    ImageProvider imPro = im.image;

    _paletteGenerator =
        await PaletteGenerator.fromImageProvider(imPro, maximumColorCount: 5);

    var colors = _paletteGenerator.colors;

    for (Color col in colors) {
      print(chalk.rgb(col.red, col.green, col.blue)("YES"));
    }
  }

  Future<List<String>> extractData(int k) async {
    // Getting the response from the targeted url
    colorPaletteUser = [];
    final response = await http.Client().get(Uri.parse(
        'http://www.saatchiart.com/account/artworks/${users.elementAt(k)}'));

    /* DatabaseReference db =
        FirebaseDatabase.instance.ref("users/" + users.elementAt(k).toString()); */

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {
      // Getting the html document from the response
      var document = parser.parse(response.body);
      int counter = 0;
      try {
        // Scraping the first article title
        List list = [];
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
        list.add(nom);
        list.add(avatar);

        for (var h = 0; h < classlor.length; h++) {
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

          if (imageUrl != null) {
            if (imageUrl.startsWith(RegExp(r'^http.*\.(jpg|png|jpeg)'))) {
              counter++;

              await connect_computer.execute(
                  'INSERT INTO users_compatible (id, avatar, palette, oeuvres, aimees, compat) VALUES (@id, @avatar, @palette, @oeuvres, @aimees, @compat)',
                  substitutionValues: {'id': k, 'avatar': avatar, 'palette': , 'oeuvres': , 'aimees': , 'compat': 0.1});

              await saveNetworkImageToFile(imageUrl, "image${k}_$counter");

              //await _myGeneratePalette(counter);

              //await _detectObjects();

              list.add(counter); //nombre de l'image (1ere image = 0)
              list.add(oeuvre); //description de l'image
              list.add(imageUrl.toString()); //l'image
              list.add(dimension); //dimensions de l'image
            }
          }
        }

        List c = colorPaletteUser;
        String cc = "";
        List compar = [];

        List ind = [
          0,
          (c.length / 4).floor(),
          (c.length / 2).floor(),
          (3 * c.length / 4).floor(),
          (c.length - 1)
        ];

        for (int i = 0; i < c.length; i++) {
          cc += (chalk.rgb(c[i].red, c[i].green, c[i].blue)("ff "));
          if (ind.contains(i)) {
            compar.add([c[i].red, c[i].green, c[i].blue]);
          }
        }

        print(cc);

        List lor = [
          [255, 0, 0],
          [0, 255, 0],
          [0, 0, 255],
          [0, 0, 0],
          [255, 255, 255],
        ];

        List d = [];
        var m = 0;

        for (List x in compar) {
          d = [];
          for (List f in lor) {
            int counter = 0;
            for (int i = 0; i < f.length; i++) {
              counter += (f[i] - x[i]).abs();
            }
            d.add(counter);
          }
          d.sort();
          m += d[0];
        }

        String kad = "", kaf = "";

        for (List vf in lor) {
          kaf += (chalk.rgb(vf[0], vf[1], vf[2])("gg "));
        }

        print(kaf);

        for (List vh in compar) {
          kad += (chalk.rgb(vh[0], vh[1], vh[2])("gg "));
        }

        print(kad);

        print(m);
        /* print(chalk.rgb(239, 255, 61)("gg"));
        print(chalk.rgb(61, 255, 81)("gg"));
        print(chalk.rgb(61, 255, 242)("gg")); */

        //print(list.toString());
      } catch (Exception) {
        print('ERROR!');
      }
    }
    return ['', '', 'ERROR STATUS CODE WASNT 200!'];
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
