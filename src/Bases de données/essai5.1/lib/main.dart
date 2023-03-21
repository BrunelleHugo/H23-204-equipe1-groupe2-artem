// @dart=2.9

import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
    theme: ThemeData(
      accentColor: Colors.green,
      scaffoldBackgroundColor: Colors.green[100],
      primaryColor: Colors.green,
    ),
    home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// Strings to store the extracted Article titles
  String result1 = 'Result 1';
  String imageUrl;

// boolean to show CircularProgressIndication
// while Web Scraping awaits
  bool isLoading = false;

  Future<List<String>> extractData() async {
    // Getting the response from the targeted url
    var http1 = 'http://www.saatchiart.com/account/artworks/742148?page=2';
    var http2 = 'https://arttocanvas.com/shop/?tx_pa_artist=Mark%20Rothko';
    var http3 = 'https://www.artfinder.com/artist/monika-luniak';
    var http4 = 'https://www.prints.com/art.php/W_Michael_Frye/?artist_id=6448';
    var http5 = 'https://www.fulcrumgallery.com/a37870/W-Michael-Frye.htm';
    var http6 = 'https://www.etsy.com/ca/market/local_montreal_art';
    var http7 = 'https://artmatch.ca/canadian-art-for-sale/';
    var http8 = 'https://www.artsy.net/artist/jean-dubuffet/works-for-sale';
    var http9 = 'https://loriginal.org/product-category/pascal-2/';
    final response = await http.Client().get(Uri.parse(http9));

    // Status Code 200 means response has been received successfully

    if (response.statusCode == 200) {
      // Getting the html document from the response
      var document = parser.parse(response.body);
      int counter = 0;
      try {
        // Scraping the first article title
        print("1");
        var idElement = document.getElementsByTagName('img');
        print(idElement.length);
        for (var image in idElement) {
          var name = image.attributes['alt'];

          if (notEqual(image.attributes['src'], null)) {
            imageUrl = image.attributes['src'];
          } else {
            imageUrl = image.attributes['data-src'];
          }

          if (notEqual(imageUrl, null) && notEqual(name, null)) {
            if (imageUrl.startsWith(RegExp(r'^http.*\.(jpg|png|jpeg)'))) {
              counter++;
              print(counter);
              print(name);
              print(imageUrl.toString());
            }
          }
        }

        return [result1];
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
      appBar: AppBar(title: Text('GeeksForGeeks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if isLoading is true show loader
            // else show Column of Texts
            isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Text(result1,
                          style: TextStyle(
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
              child: Text(
                'Scrap Data',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            )
          ],
        )),
      ),
    );
  }
}
