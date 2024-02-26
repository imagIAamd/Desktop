import 'package:flutter/material.dart';
import 'package:imagia_amd/other/appdata.dart';
import 'package:provider/provider.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField(
      {super.key,
      required TextEditingController controllerUrl,
      required String this.label,
      required bool this.secretField,
      required AppData this.appData})
      : _controllerUrl = controllerUrl;

  final TextEditingController _controllerUrl;
  final String label;
  final bool secretField;
  final AppData appData;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        obscureText: secretField,
        enabled: !appData.isCharging,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
        controller: _controllerUrl,
      ),
    );
  }
}
