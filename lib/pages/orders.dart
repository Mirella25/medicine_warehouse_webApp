import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/crud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  TextEditingController search = TextEditingController();
  List<dynamic> originalId = [];
  List<dynamic> filteredId = [];
  List<String> orderStatus = ['Preparing', 'Sent', 'Received'];
  List<String> paymentStatus = ['Unpaid', 'Paid'];
  String? orderStatusSelected;
  String? paymentStatusSelected;
  @override
  void initState() {
    super.initState();
    allOrders();
  }

  Future allOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response =
        await Crud().getRequest(route: "/admin/allorders", headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final responsebody = jsonDecode(response.body);
    if (responsebody['status'] == true) {
      return responsebody['data'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
              flex: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Orders",
                      style: TextStyle(
                          color: Color.fromARGB(255, 48, 38, 135),
                          fontWeight: FontWeight.w900,
                          fontSize: 40),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 4,
            child: FutureBuilder(
              future: allOrders(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String?> orderStatusSelectedList = List.filled(
                    snapshot.data.length,
                    null,
                  );
                  List<String?> payStatusSelectedList = List.filled(
                    snapshot.data.length,
                    null,
                  );
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            color: Color.fromARGB(255, 183, 151, 240),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    color: Color.fromARGB(255, 227, 190, 251),
                                    height: 300,
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(TextSpan(
                                                text: 'Pharmacy : ',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 48, 38, 135)),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${snapshot.data[index]['pharmacy_name']},${snapshot.data[index]['city']},${snapshot.data[index]['region']},${snapshot.data[index]['street']}',
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ])),
                                            Container(
                                              color: Color.fromARGB(
                                                  255, 48, 38, 135),
                                              child: Text(
                                                  "${snapshot.data[index]['id']}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                        Text.rich(TextSpan(
                                            text: 'Price : ',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 48, 38, 135)),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    '${snapshot.data[index]['price']},${snapshot.data[index]['paid'] == 0 ? "Unpaid" : "Paid"}',
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ])),
                                        Text.rich(TextSpan(
                                            text: 'Order status : ',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 48, 38, 135)),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    '${snapshot.data[index]['status']}',
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ])),
                                        Text(
                                          "Medicines :",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 48, 38, 135)),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot
                                                .data[index]['details'].length,
                                            itemBuilder: (context, i) {
                                              if (snapshot.hasData) {
                                                return Column(
                                                  children: [
                                                    Text(
                                                        "${snapshot.data[index]['details'][i]['caliber']['commercial']['commercial_name']}${snapshot.data[index]['details'][i]['caliber']['caliber'] == null ? "" : snapshot.data[index]['details'][i]['caliber']['caliber']}"),
                                                    Text(
                                                        "quantity:${snapshot.data[index]['details'][i]['quantity']}"),
                                                    Divider(
                                                      color: Color.fromARGB(
                                                          255, 183, 151, 240),
                                                    )
                                                  ],
                                                );
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Color.fromARGB(
                                                            255, 48, 38, 135)),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      DropdownButtonFormField<String>(
                                        hint: Text('Select Order Status'),
                                        value: orderStatusSelectedList[index],
                                        items: orderStatus.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (order) {
                                          setState(() {
                                            orderStatusSelectedList[index] =
                                                order;
                                          });
                                        },
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            Future changeOrderStatus(
                                                {required int orderId,
                                                required String status}) async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String token =
                                                  prefs.getString('token') ??
                                                      '';
                                              var data = {
                                                'order_id': orderId.toString(),
                                                'status': status.toString(),
                                              };
                                              var response = await Crud()
                                                  .postRequest(
                                                      route:
                                                          "/admin/changestatus",
                                                      data: data,
                                                      headers: {
                                                    'Content-type':
                                                        'application/json',
                                                    'Accept':
                                                        'application/json',
                                                    'Authorization':
                                                        'Bearer $token'
                                                  });
                                              final responsebody =
                                                  jsonDecode(response.body);
                                              if (responsebody['status'] ==
                                                  true) {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              183, 151, 240),
                                                      title: Text("Message"),
                                                      content: Text(
                                                          responsebody[
                                                              'message']),
                                                      actions: [
                                                        FloatingActionButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    'order');
                                                          },
                                                          child: Text("Ok"),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                print(responsebody['message']);
                                              }
                                            }

                                            await changeOrderStatus(
                                              orderId: snapshot.data[index]
                                                  ['id'],
                                              status:
                                                  orderStatusSelectedList[index]
                                                      .toString(),
                                            );
                                          },
                                          child: Text(
                                            "Submit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color:
                                              Color.fromARGB(255, 48, 38, 135),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      DropdownButtonFormField<String>(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        hint: Text('Select Payment Status'),
                                        value: payStatusSelectedList[index],
                                        items:
                                            paymentStatus.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (pay) {
                                          setState(() {
                                            payStatusSelectedList[index] = pay;
                                          });
                                        },
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            Future changePaymentStatus(
                                                {required int orderId,
                                                required String status}) async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String token =
                                                  prefs.getString('token') ??
                                                      '';
                                              var data = {
                                                'order_id': orderId.toString(),
                                                'payment': status.toString(),
                                              };
                                              var response = await Crud()
                                                  .postRequest(
                                                      route:
                                                          "/admin/changepayment",
                                                      data: data,
                                                      headers: {
                                                    'Content-type':
                                                        'application/json',
                                                    'Accept':
                                                        'application/json',
                                                    'Authorization':
                                                        'Bearer $token'
                                                  });
                                              final responsebody =
                                                  jsonDecode(response.body);
                                              if (responsebody['status'] ==
                                                  true) {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              183, 151, 240),
                                                      title: Text("Message"),
                                                      content: Text(
                                                          responsebody[
                                                              'message']),
                                                      actions: [
                                                        FloatingActionButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    'order');
                                                          },
                                                          child: Text("Ok"),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                print(responsebody['message']);
                                              }
                                            }

                                            await changePaymentStatus(
                                              orderId: snapshot.data[index]
                                                  ['id'],
                                              status:
                                                  payStatusSelectedList[index]
                                                      .toString(),
                                            );
                                          },
                                          child: Text(
                                            "Submit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color:
                                              Color.fromARGB(255, 48, 38, 135),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 48, 38, 135)),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
