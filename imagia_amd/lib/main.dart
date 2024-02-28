import 'package:flutter/material.dart';
import 'package:imagia_amd/other/app_pages.dart';
import 'package:imagia_amd/other/appdata.dart';
import 'package:imagia_amd/pages/connected.dart';
import 'package:imagia_amd/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppData(),
    child: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Consumer<AppData>(
        builder: (context, appData, child) => _buildPage(appData.currentPage),
      ),
    );
  }

  Widget _buildPage(AppPages currentPage) {
    switch (currentPage) {
      case AppPages.Home:
        return Home();
      case AppPages.Connected:
        return Connected();
      default:
        return Center(child: Text("Error: Unknown Page"));
    }
  }
}

