import 'package:flutter/material.dart';
import 'package:imagia_amd/other/appdata.dart';
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
    return MaterialButton(
      child: Text("Login"),
      elevation: 5,
      onPressed: () {
        appData.setInfo(
          _controllerUrl.text,
          controllerUser.text,
          controllerPasswd.text
        );
        appData.saveURL();
        appData.login();
      },
    );
  }
}
