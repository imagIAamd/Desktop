import 'dart:io';

import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  String url = "";
  bool isCharging = false;

  void setUrl(String URL) {
    url = URL;
  }

  //Funcion para recuperar el url de un fichero
  void recoverURL(TextEditingController controller) async {
    try {
      final file = File("assets/save.txt");
      //Si existe pone el url, si no crea el archivo
      if (await file.exists()) {
        final content = await file.readAsString();
        controller.text = content;
      } else {
        file.create();
        controller.text = "";
      }
    } catch (e) {
      print("Error loading file: $e");
      controller.text = "";
    }
    notifyListeners();
  }

  //Funcion para guardar el url a un fichero
  void saveURL() async {
    try {
      final file = File("assets/save.txt");
      //Si existe el fila lo elimina para crear uno vacio y poner el url
      if (await file.exists()) {
        file.delete();
      }
      await file.writeAsString(url);
    } catch (e) {
      print("Error saving file: $url");
    }
    notifyListeners();
  }

  //Funció per logearse'n
  void login() async {
    isCharging = true;
    notifyListeners();
  }
}
