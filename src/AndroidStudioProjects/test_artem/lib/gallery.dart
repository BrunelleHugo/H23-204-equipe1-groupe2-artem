import 'package:flutter/material.dart';
import 'package:test_artem/menu.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color:Colors.black),
          ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 320,
          height: 50,
        child: TextField(
            decoration: InputDecoration(
                prefix: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "Rechercher",
            ),
          ),
        ),
        ),
      ),
      );
  }
}



