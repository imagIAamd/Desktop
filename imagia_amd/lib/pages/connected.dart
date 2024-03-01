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
        body: Center(
            child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: ListView.builder(
              itemCount: appData.listUsers.length,
              itemBuilder: (context, index) {
                print(index);
                Color c = appData.listUsers[index].plan == "Premium"
                    ? const Color.fromARGB(255, 241, 189, 0)
                    : Colors.black;

                return Container(
                  child: Row(
                    children: [
                      Text(
                        appData.listUsers[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        appData.listUsers[index].plan,
                        style: TextStyle(color: c),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white, // White background color
                    borderRadius: BorderRadius.circular(
                        10), // Adjust border radius as needed
                    border: Border.all(color: Colors.grey), // Border line
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2), // Shadow offset
                      ),
                    ],
                  ),
                );
              }),
        )));
  }
}
