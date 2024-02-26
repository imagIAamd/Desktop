import 'dart:io';

import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  String url = "";

  //Funcion para recuperar el url de un fichero
  void recoverURL() async {
    try {
      final file = File("assets/save.txt");
      final content = await file.readAsString();
      url = "" + content;
    } catch (e) {
      print("Error loading file: $e");
    }
  }

  //Funcion para guardar el url a un fichero
  void saveURL() async {
    try {
      final file = File("assets/save.txt");
      if (file.exists() == true) {
        file.delete();
      }
      await file.writeAsString(url);
    } catch (e) {
      print("Error saving file: $url");
    }
  }
}
