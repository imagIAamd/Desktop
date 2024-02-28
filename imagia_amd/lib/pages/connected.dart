import 'package:flutter/material.dart';
import 'package:imagia_amd/other/app_pages.dart';
import 'package:imagia_amd/other/appdata.dart';
import 'package:provider/provider.dart';

class Connected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);

    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
            onPressed: () {
              appData.currentPage = AppPages.Home;
              appData.doNotifyListeners();
            },
            child: Icon(Icons.arrow_back_rounded)),
      ),
      body: Center(child: Text('Connected')),
    );
  }
}
