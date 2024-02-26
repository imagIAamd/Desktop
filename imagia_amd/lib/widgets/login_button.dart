import 'package:flutter/material.dart';
import 'package:imagia_amd/other/appdata.dart';
import 'package:imagia_amd/widgets/base_text_field.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.appData,
    required TextEditingController controllerUrl,
  }) : _controllerUrl = controllerUrl;

  final AppData appData;
  final TextEditingController _controllerUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text("Login"),
      elevation: 5,
      onPressed: () {
        appData.setUrl(_controllerUrl.text);
        appData.saveURL();
        appData.login();
      },
    );
  }
}
