import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/crud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    Future notifications() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      var response = await Crud().getRequest(route: "/notification", headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == true) {
        return responsebody;
      }
    }

    return Scaffold(
      body: Container(
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/1703057726807.png",
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Text("DrugSwift",
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: "Lobster",
                            color: Color.fromARGB(229, 139, 139, 139))),
                  ],
                ),
              )),
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Text(
                    "Notifications",
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 38, 135),
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  ),
                ),
                Expanded(
                    child: FutureBuilder(
                  future: notifications(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data['data']['orders'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shadowColor: Color.fromARGB(255, 48, 38, 135),
                              elevation: 5,
                              child: ListTile(
                                onTap: () async {
                                  read() async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    String token =
                                        prefs.getString('token') ?? '';
                                    var data = {
                                      'order_id': snapshot.data['data']
                                              ['orders'][index]['order_id']
                                          .toString(),
                                      'status': snapshot.data['data']['orders']
                                              [index]['status']
                                          .toString()
                                    };
                                    var response = await Crud().postRequest(
                                        route: "/read",
                                        data: data,
                                        headers: {
                                          'Content-type': 'application/json',
                                          'Accept': 'application/json',
                                          'Authorization': 'Bearer $token'
                                        });
                                    var responsebody =
                                        jsonDecode(response.body);
                                    if (responsebody['status'] == true) {
                                      Navigator.of(context).pushNamed('order');
                                    } else {
                                      print(responsebody['message']);
                                    }
                                  }

                                  await read();
                                },
                                leading: Icon(
                                  Icons.notifications_active_outlined,
                                  color: Color.fromARGB(255, 48, 38, 135),
                                ),
                                title: Text(
                                    "There is a new order with number:${snapshot.data['data']['orders'][index]['order_id']} "),
                              ),
                              color: Color.fromARGB(255, 183, 151, 240),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 48, 38, 135)),
                    );
                  },
                )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
