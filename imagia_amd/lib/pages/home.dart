import 'package:flutter/material.dart';
import 'package:imagia_amd/other/appdata.dart';
import 'package:imagia_amd/widgets/base_text_field.dart';
import 'package:imagia_amd/widgets/login_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerUrl = TextEditingController();
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPasswd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    appData.recoverURL(_controllerUrl);

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseTextField(
                  controllerUrl: _controllerUrl,
                  label: "Url",
                  secretField: false,
                  appData: appData),
              SizedBox(height: 16),
              BaseTextField(
                  controllerUrl: _controllerUser,
                  label: "Usuari",
                  secretField: false,
                  appData: appData),
              SizedBox(height: 16),
              BaseTextField(
                controllerUrl: _controllerPasswd,
                label: "Contrasenya",
                secretField: true,
                appData: appData,
              ),
              SizedBox(height: 28),
              Container(
                  child: appData.isCharging
                      ? Text('Charging...')
                      : LoginButton(
                          appData: appData, controllerUrl: _controllerUrl))
            ],
          ),
        ),
      ),
    );
  }
}
