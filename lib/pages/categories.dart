import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/crud.dart';
import 'package:flutter_application_1/pages/details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController search = TextEditingController();
  String? statusMedUI;

  List<dynamic> originalCategories = [];
  List<dynamic> filteredCategories = [];
  List<dynamic> filteredMedicines = [];

  @override
  void initState() {
    super.initState();
    getMedicines().then((data) {
      setState(() {
        originalCategories = data['data'];
        filteredCategories = List.from(originalCategories);
      });
    });
  }

  void filterCategories(String query) {
    setState(() {
      filteredCategories = originalCategories.where((category) {
        String categoryName = category['name'].toString().toLowerCase();
        List<dynamic> medicines = category['commercial'];
        List<dynamic> filteredMedicines = [];
        for (var medicine in medicines) {
          String commercialName =
              medicine['commercial_name'].toString().toLowerCase();
          List<dynamic> calibers = medicine['calibers'];

          for (var caliber in calibers) {
            String caliberValue = caliber['caliber'].toString().toLowerCase();
            if (commercialName.contains(query.toLowerCase()) ||
                caliberValue.contains(query.toLowerCase())) {
              filteredMedicines.add(medicine);
              break;
            }
          }
        }
        return categoryName.contains(query.toLowerCase()) ||
            filteredMedicines.isNotEmpty;
      }).toList();
    });
  }

  Future getMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await Crud().getRequest(route: "/all", headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final responsebody = jsonDecode(response.body);

    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Available Medicines",
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 38, 135),
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                      onChanged: (value) {
                        filterCategories(value);
                      },
                      controller: search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Colors.grey,
                      )),
                ),
                Divider(
                  color: Color.fromARGB(255, 48, 38, 135),
                  thickness: 5,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: getMedicines(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          itemCount: filteredCategories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) {
                            final List<dynamic> medicines =
                                filteredCategories[index]['commercial'];

                            return Card(
                              color: Color.fromARGB(255, 237, 217, 250),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "${filteredCategories[index]['name']}",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Color.fromARGB(
                                                255, 48, 38, 135),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: medicines.length,
                                      itemBuilder: (context, index) {
                                        List<dynamic> calibers =
                                            medicines[index]['calibers'];
                                        for (int caliberIndex = 0;
                                            caliberIndex < calibers.length;
                                            // ignore: dead_code
                                            caliberIndex++) {
                                          return Card(
                                              margin: EdgeInsets.all(15),
                                              child: Container(
                                                  color: Color.fromARGB(
                                                      255, 183, 151, 240),
                                                  height: 50,
                                                  child: ListTile(
                                                    title: Text(
                                                        "${medicines[index]['commercial_name']}"
                                                        "${calibers[caliberIndex]['caliber'] == null ? "" : calibers[caliberIndex]['caliber']}"),
                                                    trailing: Container(
                                                      width: 100,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  getDetails() async {
                                                                    String
                                                                        name =
                                                                        "${medicines[index]['commercial_name']}";
                                                                    String
                                                                        caliber;
                                                                    if (calibers[caliberIndex]
                                                                            [
                                                                            'caliber'] ==
                                                                        null) {
                                                                      caliber =
                                                                          " ";
                                                                    } else {
                                                                      caliber = calibers[caliberIndex]
                                                                              [
                                                                              'caliber']
                                                                          .toString();
                                                                    }
                                                                    SharedPreferences
                                                                        prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String
                                                                        token =
                                                                        prefs.getString('token') ??
                                                                            '';
                                                                    var data = {
                                                                      'commercial_name':
                                                                          name,
                                                                      'caliber':
                                                                          caliber
                                                                    };
                                                                    var response = await Crud().postRequest(
                                                                        route:
                                                                            "/details",
                                                                        data:
                                                                            data,
                                                                        headers: {
                                                                          'Content-type':
                                                                              'application/json',
                                                                          'Accept':
                                                                              'application/json',
                                                                          'Authorization':
                                                                              'Bearer $token'
                                                                        });
                                                                    var responsebody =
                                                                        jsonDecode(
                                                                            response.body);
                                                                    if (responsebody[
                                                                            'status'] ==
                                                                        true) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Details(
                                                                          name: responsebody['data']
                                                                              [
                                                                              'scientific_name'],
                                                                          company:
                                                                              responsebody['data']['company'],
                                                                          price:
                                                                              responsebody['data']['price'],
                                                                          quantity:
                                                                              responsebody['data']['quantity'],
                                                                          date: responsebody['data']
                                                                              [
                                                                              'expiration_date'],
                                                                          caliberData:
                                                                              caliber,
                                                                          comName:
                                                                              name,
                                                                        ),
                                                                      ));
                                                                    } else {
                                                                      print(responsebody[
                                                                          'message']);
                                                                    }
                                                                  }

                                                                  await getDetails();
                                                                },
                                                                icon: Icon(Icons
                                                                    .menu_book_rounded)),
                                                          ),
                                                          calibers[caliberIndex]
                                                                      [
                                                                      'status'] ==
                                                                  1
                                                              ? Expanded(
                                                                  child: Text(
                                                                    "Active",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                )
                                                              : Expanded(
                                                                  child: Text(
                                                                    "Disactive",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                  )));
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                              color: Color.fromARGB(
                                                  255, 48, 38, 135)),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 48, 38, 135)),
                    );
                  },
                )),
          ),
        ],
      ),
    ));
  }
}
