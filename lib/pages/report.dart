import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/crud.dart';
import 'package:flutter_application_1/components/datetime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TextEditingController date = TextEditingController();
  TextEditingController date2 = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  bool showData = false;
  Future showReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {
      'first_date': date.text.toString(),
      'second_date': date2.text.toString(),
    };

    String token = prefs.getString('token') ?? '';
    var response =
        await Crud().postRequest(route: '/admin/report', data: data, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var responsebody = jsonDecode(response.body);
    if (responsebody['status'] == true) {
      return responsebody;
    } else {
      print(responsebody['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: form,
          child: Column(
            children: [
              Container(
                child: Text(
                  "Report",
                  style: TextStyle(
                      color: Color.fromARGB(255, 48, 38, 135),
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                ),
              ),
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 100, right: 100, top: 8, bottom: 8),
                    child: BasicDateField(
                        date: date,
                        labelText: "From date",
                        prefixText: "From date:"),
                  )),
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 100, right: 100, top: 8, bottom: 8),
                    child: BasicDateField(
                        date: date2,
                        labelText: "To date",
                        prefixText: "To date:"),
                  )),
              MaterialButton(
                onPressed: () async {
                  if (form.currentState!.validate()) {
                    await showReport();
                    setState(() {
                      showData = true;
                    });
                  }
                },
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Color.fromARGB(255, 48, 38, 135),
              ),
              showData
                  ? FutureBuilder(
                      future: showReport(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data['status'] == true &&
                            snapshot.data['message'] == "report" &&
                            snapshot.data['data']['orders'].isNotEmpty) {
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text.rich(TextSpan(
                                      text: 'Number of orders: ',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 48, 38, 135)),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text:
                                              '${snapshot.data['data']['counter']}',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w400),
                                        )
                                      ])),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text.rich(TextSpan(
                                      text: 'Number of orders preparing: ',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 48, 38, 135)),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text:
                                              '${snapshot.data['data']['preparing']}',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w400),
                                        )
                                      ])),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text.rich(TextSpan(
                                      text: 'Number of orders sent: ',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 48, 38, 135)),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text:
                                              '${snapshot.data['data']['sent']}',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w400),
                                        )
                                      ])),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text.rich(TextSpan(
                                      text: 'Number of orders recieved: ',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 48, 38, 135)),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text:
                                              '${snapshot.data['data']['recieved']}',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w400),
                                        )
                                      ])),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text.rich(TextSpan(
                                      text: 'Sales: ',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 48, 38, 135)),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text:
                                              '${snapshot.data['data']['sales']}',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w400),
                                        )
                                      ])),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text("Orders:",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 48, 38, 135))),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        snapshot.data['data']['orders'].length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(8),
                                        color:
                                            Color.fromARGB(255, 183, 151, 240),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, bottom: 8),
                                              child: Text.rich(TextSpan(
                                                  text: 'Order number: ',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 48, 38, 135)),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                      text:
                                                          '${snapshot.data['data']['orders'][index]['id']}',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[900],
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ])),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, bottom: 8),
                                              child: Text.rich(TextSpan(
                                                  text: 'Pharmacy: ',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 48, 38, 135)),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                      text:
                                                          '${snapshot.data['data']['orders'][index]['pharmacy_name']},${snapshot.data['data']['orders'][index]['city']},${snapshot.data['data']['orders'][index]['region']},${snapshot.data['data']['orders'][index]['street']}',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[900],
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ])),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, bottom: 8),
                                              child: Text.rich(TextSpan(
                                                  text: 'Price: ',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 48, 38, 135)),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                      text:
                                                          '${snapshot.data['data']['orders'][index]['price']},${snapshot.data['data']['orders'][index]['paid'] == 0 ? "Unpaid" : "Paid"}',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[900],
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ])),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, bottom: 8),
                                              child: Text.rich(TextSpan(
                                                  text: 'Status: ',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 48, 38, 135)),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                      text:
                                                          '${snapshot.data['data']['orders'][index]['status']}',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[900],
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ])),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, bottom: 8),
                                              child: Text("Medicines:",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 48, 38, 135))),
                                            ),
                                            for (int i = 0;
                                                i <
                                                    snapshot
                                                        .data['data']['orders']
                                                            [index]['details']
                                                        .length;
                                                // ignore: dead_code
                                                i++)
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 8, bottom: 8),
                                                child: Text(
                                                  "${snapshot.data['data']['orders'][index]['details'][i]['caliber']['commercial']['commercial_name']}${snapshot.data['data']['orders'][index]['details'][i]['caliber']['caliber'] == null ? "" : snapshot.data['data']['orders'][index]['details'][i]['caliber']['caliber']} , quantity:${snapshot.data['data']['orders'][index]['details'][i]['quantity']}",
                                                  style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data['status'] == true &&
                            snapshot.data['message'] == "Nothing to show") {
                          return Center(
                            child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text("${snapshot.data['message']}")),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 48, 38, 135)),
                        );
                      },
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
