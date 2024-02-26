import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  String url = "";
  String user = "";
  String passwd = "";
  bool isCharging = false;

  void setInfo(String URL, String USER, String Password) {
    url = URL;
    user = USER;
    passwd = Password;
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
    loadHttpPostByChunks(url, user, passwd);
    notifyListeners();
  }

  //Fer un POST
  Future<void> loadHttpPostByChunks(String link, String User, String Passwd) async {
    String responseMsn = "";
    isCharging = true;
    var completer = Completer<void>();
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add JSON data as part of the form
    request.fields['data'] = '{"type":"conversa","text":"$User"}';

    try {
      var response = await request.send();

      // Listen to each chunk of data
      response.stream.transform(utf8.decoder).listen(
        (data) {},
        onDone: () async {
          for (int i = 0; i < responseMsn.length - 1; i++) {
            notifyListeners();
            await Future.delayed(Duration(milliseconds: 50));
          }
          isCharging = false;
          if (response.statusCode == 200) {
            // La solicitud ha sido exitosa
            isCharging = false;
            completer.complete();
          } else {
            //addErrorMessage();
            // La solicitud ha fallado
            completer.completeError(
                "Error del servidor (appData/loadHttpPostByChunks): ${response.reasonPhrase}");
            isCharging = false;
          }
        },
        onError: (error) {
          isCharging = false;
          completer.completeError(
              "Error del servidor (appData/loadHttpPostByChunks): $error");
        },
      );
    } catch (e) {
      completer.completeError("Excepción (appData/loadHttpPostByChunks): $e");
    }

    isCharging = false;
    return completer.future;
  }
}
