// @dart=2.9

import 'dart:js_util';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green[100],
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),
      home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// Strings to store the extracted Article titles
  String result1 = 'Result 1';

// boolean to show CircularProgressIndication
// while Web Scraping awaits
  bool isLoading = false;

  Future<List<String>> extractData() async {
    // Getting the response from the targeted url
    var http1 = 'http://www.saatchiart.com/account/artworks/726323';
    final response = await http.Client().get(Uri.parse(http1));

    // Status Code 200 means response has been received successfully

    if (response.statusCode == 200) {
      // Getting the html document from the response
      var document = parser.parse(response.body);
      int counter = 0;
      try {
        // Scraping the first article title
        List list = new List();
        var classlor = document
            .getElementsByClassName("sc-1ypbzzj-4 sc-9pmg3r-2 cgnOZJ kpSjBp");
        var usagers = document.getElementsByTagName('img');
        var nom, avatar;

        for (var usager in usagers) {
          var fl = usager.attributes['src'];
          if (notEqual(fl, null))
          if (fl.contains(RegExp(r'^http.*\.(jpg|png|jpeg)'))) {
            nom = usager.attributes['alt'];
            avatar = usager.attributes['src'];
            break;
          }
        }
        // print("nom: " + nom);
        // print("avatar: " + avatar);
        // print(
        //     "****----****----****----****\n****----****----****----****\n****----****----****----****");
        list.add(nom);
        list.add(avatar);

        for (var h = 0; h < classlor.length; h++) {
          var oeuvre, dimension, imageUrl;
          var case1 = classlor[h].children[0];
          var img = case1.getElementsByTagName("img");
          var h2 = case1.getElementsByTagName("h2");
          var h4 = case1.getElementsByTagName("h4")[0].children;

          for (var image in img) {
            imageUrl = notEqual(image.attributes['src'], null)
                ? image.attributes['src']
                : image.attributes['data-src'];
            // if (notEqual(image.attributes['src'], null)) {
            //   imageUrl = image.attributes['src'];
            // } else {
            //   imageUrl = image.attributes['data-src'];
            // }
          }

          for (var h21 in h2) {
            if (equal(oeuvre, null)) oeuvre = h21.text;
          }

          for (var h41 in h4) {
            if (equal(dimension, null)) dimension = h41.text;
          }

          if (notEqual(imageUrl, null)) {
            if (imageUrl.startsWith(RegExp(r'^http.*\.(jpg|png|jpeg)'))) {
              counter++;
              // print(counter);
              // print("oeuvre: " + oeuvre);
              // print("imageUrl: " + imageUrl.toString());
              // print("dimension: " + dimension);
              // print("****----****----****----****");
              list.add(counter);
              list.add(oeuvre);
              list.add(imageUrl.toString());
              list.add(dimension);
            }
          }

        }

        print(list.toString());

        return [nom.toString()];
      } catch (Exception) {
        return ['', '', 'ERROR!'];
      }
    }
  }

  // Future<void> downloadAndSaveImage(String url, String fileName) async {
  //   final response = await http.get(Uri.parse(url));
  //   final file = File('$fileName.glb');
  //   await file.writeAsBytes(response.bodyBytes);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GeeksForGeeks')),
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

                // Awaiting for web scraping function
                // to return list of strings
                final response = await extractData();

                // Setting the received strings to be
                // displayed and making isLoading false
                // to hide the loader
                setState(() {
                  result1 = response[0];
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
