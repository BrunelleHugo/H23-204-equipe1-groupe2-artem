import 'package:flutter/material.dart';
import 'package:test_artem/menu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Gallery extends StatefulWidget {
  @override
  _Gallery createState() => _Gallery();
}
class _Gallery extends State<Gallery>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color:Colors.black),
          ),

      body: MasonryGridView.builder(
        itemCount: 60,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context,i) =>
            Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(8)),
      child: GestureDetector(
        onTap: () {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => details("lib/images/$i.jpg")),);},
                child: Image.asset("lib/images/$i.jpg")
      ),
            ),
        ),
      )
      );
  }
}

class details extends StatelessWidget {
  details(this.image);

  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Image.asset(image),
    );
  }
}







/*Align(
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
      ),*/





