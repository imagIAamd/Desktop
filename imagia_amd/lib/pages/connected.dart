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
            child: appData.isCharging
                ? chargingContainer()
                : usersList(context, appData)));
  }

  Container chargingContainer() => Container(
        child: Text(
          'Loading...',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      );

  Container usersList(BuildContext context, AppData appData) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: ListView.builder(
          itemCount: appData.listUsers.length,
          itemBuilder: (context, index) {
            Color c = appData.listUsers[index].plan == "Premium"
                ? Color.fromARGB(255, 161, 137, 0)
                : const Color.fromARGB(255, 20, 20, 20);

            return GestureDetector(
                behavior: appData.isCharging
                    ? HitTestBehavior.translucent
                    : HitTestBehavior.opaque,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
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
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return showAlertDialog(index, appData, context);
                      });
                });
          }),
    );
  }
}

AlertDialog showAlertDialog(int id, AppData data, BuildContext context) {
  return AlertDialog(
    title: Text("Selecciona un pla"),
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
    actionsOverflowButtonSpacing: 20,
    actions: [
      ElevatedButton(
          onPressed: () {
            data.sendChangePlanMsn(id, "Free");
            Navigator.of(context).pop();
          },
          child: Text("Free")),
      ElevatedButton(
          onPressed: () {
            data.sendChangePlanMsn(id, "Premium");
            Navigator.of(context).pop();
          },
          child: Text("Premium")),
    ],
    content: Container(
        child: Row(
      children: [
        Text("Que pla vols que tingui "),
        Text(
          "${data.listUsers[id].name}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("? Actualment té el pla "),
        Text("${data.listUsers[id].plan}",
            style: TextStyle(
                color: data.listUsers[id].plan == "Premium"
                    ? Color.fromARGB(255, 161, 137, 0)
                    : const Color.fromARGB(255, 20, 20, 20)))
      ],
    )),
  );
}
