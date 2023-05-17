// @dart=2.9

import 'dart:collection';
import 'dart:core';
import 'dart:math';

import 'compatibilityimage.dart';

import 'package:flutter/material.dart';

class CompatibilityUsers extends StatefulWidget {
  static double ensemble(Set p1, Set p2, List aim1, List aim2) {
    double ort = CompatibilityImage.total(p1, p2);

    int counter = 0;

    for (int i = 0; i < aim2.length; i++) {
      if (aim1.contains(aim2[i])) {
        counter++;
      }
    }

    ort = (100 - (100 - (ort * 100)) * pow((0.85), counter)) / 100;

    return ort;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
    ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
