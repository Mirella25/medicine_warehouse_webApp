import 'dart:convert';
import 'package:flutter_application_1/components/crud.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/datetime.dart';
import 'package:flutter_application_1/components/textformfield.dart';
import 'package:flutter_application_1/packages/dropdownlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController scientific = TextEditingController();
  TextEditingController commercial = TextEditingController();
  TextEditingController caliber = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController price = TextEditingController();

  void addMedicine() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final data = {
      'scientific_name': scientific.text.toString(),
      'commercial_name': commercial.text.toString(),
      'caliber': caliber.text.toString(),
      'category': category.text.toString(),
      'company': company.text.toString(),
      'quantity': quantity.text.toString(),
      'expiration_date': date.text.toString(),
      'price': price.text.toString(),
    };
    final response =
        await Crud().postRequest(route: "/admin/insert", data: data, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    final responsebody = jsonDecode(response.body);
    if (responsebody['status'] == true) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 183, 151, 240),
            title: Text("Message"),
            content: Text(responsebody['message']),
            actions: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('home', (route) => false);
                },
                child: Text("Ok"),
              )
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(responsebody['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
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
              flex: 4,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 227, 190, 251),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(20, 20))),
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: Form(
                        key: form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(15),
                              child: Text(
                                "Enter The Details Of The New Medicine",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 48, 38, 135),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 40),
                              ),
                            ),
                            CustomTextField(
                              prefixText: "Scientific Name:",
                              mycontroller: scientific,
                              textInputType: TextInputType.text,
                              labelText: 'Scientific Name',
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 15,
                            ),
                            CustomTextField(
                              prefixText: "Commercial Name:",
                              mycontroller: commercial,
                              textInputType: TextInputType.text,
                              labelText: 'Commercial Name',
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 15,
                            ),
                            CustomTextField(
                              prefixText: "Caliber:",
                              mycontroller: caliber,
                              textInputType: TextInputType.text,
                              labelText: 'Caliber',
                            ),
                            Container(
                              height: 15,
                            ),
                            AppTextField(
                              textEditingController: category,
                              isItemSelected: true,
                              dataList: [
                                SelectedListItem(name: "Heart"),
                                SelectedListItem(name: "Cold"),
                                SelectedListItem(name: "PainKiller"),
                                SelectedListItem(name: "flu"),
                                SelectedListItem(name: "diabetes"),
                                SelectedListItem(name: "Anti-allergic"),
                                SelectedListItem(name: "Appetizer"),
                                SelectedListItem(name: "Antihypertensive"),
                              ],
                              prefixText: 'Select Category:',
                              labelText: 'Select Category',
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 15,
                            ),
                            AppTextField(
                              textEditingController: company,
                              isItemSelected: true,
                              dataList: [
                                SelectedListItem(name: "ASIA"),
                                SelectedListItem(name: "AVENZOR"),
                                SelectedListItem(name: "BARAKAT"),
                                SelectedListItem(name: "PHARMASYR"),
                                SelectedListItem(name: "Unipharma"),
                              ],
                              prefixText: 'Select Company:',
                              labelText: 'Select Company',
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 15,
                            ),
                            CustomTextField(
                              prefixText: "Quantity Availible:",
                              mycontroller: quantity,
                              textInputType: TextInputType.number,
                              labelText: 'Quantity Availible',
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 15,
                            ),
                            BasicDateField(
                                date: date,
                                labelText: "Expiration Date",
                                prefixText: "Expiration Date:"),
                            Container(
                              height: 15,
                            ),
                            CustomTextField(
                              prefixText: "Price:",
                              mycontroller: price,
                              textInputType: TextInputType.number,
                              labelText: 'Price',
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 15,
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(10, 19)),
                              child: MaterialButton(
                                onPressed: () {
                                  if (form.currentState!.validate()) {
                                    addMedicine();
                                  }
                                },
                                color: Color.fromARGB(255, 48, 38, 135),
                                minWidth: 500,
                                height: 50,
                                child: const Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
