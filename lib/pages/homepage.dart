import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/crud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    notifications();
  }

  bool isloading = false;
  void logout() async {
    isloading = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    prefs.remove('token');
    final response = await Crud().getRequest(route: "/logout", headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final responsebody = jsonDecode(response.body);
    isloading = false;
    setState(() {});
    if (responsebody['status'] == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(responsebody['message'])));
      Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(responsebody['message'])));
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 48, 38, 135)),
            )
          : Container(
              child: Row(children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          "Main Page",
                          style: TextStyle(
                              color: Color.fromARGB(255, 48, 38, 135),
                              fontWeight: FontWeight.w900,
                              fontSize: 40),
                        ),
                      ),
                      Divider(
                        thickness: 5,
                        color: Color.fromARGB(255, 48, 38, 135),
                      ),
                      Container(
                        height: 50,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed('add');
                        },
                        leading: const Icon(Icons.add_box_outlined,
                            color: Color.fromARGB(229, 139, 139, 139)),
                        title: const Text(
                          "Add New Medicine",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(229, 139, 139, 139)),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed('category');
                        },
                        leading: const Icon(Icons.view_comfy_alt_outlined,
                            color: Color.fromARGB(229, 139, 139, 139)),
                        title: const Text(
                          "View Available Medicines",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(229, 139, 139, 139)),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed('order');
                        },
                        leading: const Icon(Icons.cases_outlined,
                            color: Color.fromARGB(229, 139, 139, 139)),
                        title: const Text(
                          "Orders",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(229, 139, 139, 139)),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: FutureBuilder(
                          future: notifications(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListTile(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('notification');
                                },
                                leading: const Icon(Icons.notifications_none,
                                    color: Color.fromARGB(229, 139, 139, 139)),
                                title: const Text(
                                  "Notifications",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(229, 139, 139, 139)),
                                ),
                                trailing: Text(
                                  "${snapshot.data['data']['counter'] == 0 ? "" : "+${snapshot.data['data']['counter']}"}",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              );
                            }
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed('notification');
                              },
                              leading: const Icon(Icons.notifications_none,
                                  color: Color.fromARGB(229, 139, 139, 139)),
                              title: const Text(
                                "Notifications",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(229, 139, 139, 139)),
                              ),
                            );
                          },
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed('report');
                        },
                        leading: const Icon(Icons.fact_check_outlined,
                            color: Color.fromARGB(229, 139, 139, 139)),
                        title: const Text(
                          "Report",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(229, 139, 139, 139)),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          logout();
                        },
                        leading: Icon(Icons.logout,
                            color: Color.fromARGB(229, 139, 139, 139)),
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(229, 139, 139, 139)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(20, 20))),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/1703057726807.png",
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        Text("DrugSwift",
                            style: TextStyle(
                                fontSize: 60,
                                fontFamily: "Lobster",
                                color: Color.fromARGB(229, 139, 139, 139))),
                        Container(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
    );
  }
}
