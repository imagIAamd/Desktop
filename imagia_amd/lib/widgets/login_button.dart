import 'package:flutter/material.dart';
import 'package:imagia_amd/other/app_pages.dart';
import 'package:imagia_amd/other/appdata.dart';
import 'package:imagia_amd/other/user.dart';
import 'package:imagia_amd/widgets/base_text_field.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.appData,
    required TextEditingController controllerUrl,
    required this.controllerUser,
    required this.controllerPasswd,
  }) : _controllerUrl = controllerUrl;

  final AppData appData;
  final TextEditingController _controllerUrl;
  final TextEditingController controllerUser;
  final TextEditingController controllerPasswd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue[900]!, Colors.blue[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        appData.listUsers.add(User("pepe", "Premium"));
        appData.listUsers.add(User("Jaimito", "Free"));

        appData.setInfo(
            _controllerUrl.text, controllerUser.text, controllerPasswd.text);
        appData.saveURL();
        appData.login();
      },
    );
  }
}
