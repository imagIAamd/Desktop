import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:imagia_amd/other/app_pages.dart';
import 'package:imagia_amd/other/user.dart';

class AppData with ChangeNotifier {
  //Variables
  String url = "";
  String user = "";
  String passwd = "";
  String responseMsn = "";
  String errorMsn = "Connection Error";
  bool isCharging = false;
  bool isInvalid = false;
  AppPages currentPage = AppPages.Home;
  List<User> listUsers = [];

  //NotifyListeners des d'un altre arxiu
  void doNotifyListeners() {
    notifyListeners();
  }

  //Modificar les variables del formulari
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
    errorMsn = "Connection Error";
    isInvalid = false;
    notifyListeners();
    //Validar si ha posat tot els camps
    if (url == "" || user == "" || passwd == "") {
      isInvalid = true;
      errorMsn = "Comproba els camps";
      notifyListeners();
      return;
    }
    loginHttpPostByChunks(url, user, passwd);
    notifyListeners();
  }

  //Fer login amb POST
  Future<void> loginHttpPostByChunks(
      String link, String User, String Passwd) async {
    isCharging = true;

    try {
      var response = await http.post(
        Uri.parse(link),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': User, 'password': Passwd}),
      );

      if (response.statusCode == 200) {
        try {
          //Map<String, dynamic> jsonMap = json.decode(response.body);
          //if (jsonMap["status"] == "OK") {
          currentPage = AppPages.Connected;
          isInvalid = false;
          //} else {
          //  isInvalid = true;
          //}
        } catch (e) {
          isInvalid = true;
          print("Error --------------------------------");
          print(e);
          print("-------------------------------------");
        }
      } else {
        isInvalid = true;
        throw "Error del servidor (appData/loadHttpPostByChunks): ${response.reasonPhrase}";
      }
    } catch (e) {
      isInvalid = true;
      throw "Excepción (appData/loadHttpPostByChunks): $e";
    } finally {
      isCharging = false;
      notifyListeners();
    }
  }

  //Cambiar pla del usuari
  void changePlan(int userNum, String plan) {
    listUsers[userNum].plan = "" + plan;
  
  }
}
