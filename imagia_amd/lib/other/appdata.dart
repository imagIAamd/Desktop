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
  bool connected = false;
  bool isInvalid = false;

  void setInfo(String URL, String USER, String Password) {
    url = URL;
    user = USER;
    passwd = Password;
  }

  //Funcio per recuperar el url d'un ficher
  void recoverURL(TextEditingController controller) async {
    try {
      final file = File("assets/save.txt");
      //Si existeix posa el url, si no crea l'arxiu
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

  //Funcio per guardar el url a un ficher
  void saveURL() async {
    try {
      final file = File("assets/save.txt");
      //Si existeix el file l'elimina per crear un buit i posar el url
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
    isInvalid = false;
    notifyListeners();
    //Validar si ha posat tot els camps
    if (url == "" || user == "" || passwd == "") {
      isInvalid = true;
      notifyListeners();
      return;
    }
    loadHttpPostByChunks(url, user, passwd);
    notifyListeners();
  }

  //Fer un POST
  Future<void> loadHttpPostByChunks(
      String link, String User, String Passwd) async {
    String responseMsn = "";
    isCharging = true;
    var completer = Completer<void>();
    var request = http.MultipartRequest('POST', Uri.parse(link));

    // Add JSON data as part of the form
    request.fields['data'] =
        '{"type":"login","email":"$User", "password":"$Passwd"}';

    try {
      var response = await request.send();
      // Listen to each chunk of data
      response.stream.transform(utf8.decoder).listen(
        (data) {
          connected = true;
        },
        onDone: () async {
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
          isInvalid = true;
          completer.completeError(
              "Error del servidor (appData/loadHttpPostByChunks): $error");
        },
      );
    } catch (e) {
      isInvalid = false;
      completer.completeError("Excepción (appData/loadHttpPostByChunks): $e");
    }

    isCharging = false;
    notifyListeners();
    return completer.future;
  }
}
