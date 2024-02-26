
import 'package:flutter/material.dart';
import 'package:imagia_amd/other/appdata.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hola'),
              
            ],
          ),
        ),
      ),
    );
  }
}