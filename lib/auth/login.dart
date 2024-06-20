import 'dart:convert';
import 'package:flutter/material.dart ';
import 'package:flutter_application_1/components/crud.dart';
import 'package:flutter_application_1/components/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isloading = false;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void logInAdmin() async {
    isloading = true;
    setState(() {});
    final data = {
      'email': email.text.toString(),
      'password': password.text.toString(),
    };
    final response = await Crud().postRequest(
        route: '/admin/login',
        data: data,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    final responsebody = jsonDecode(response.body);
    isloading = false;
    setState(() {});
    if (responsebody['status'] == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('token', responsebody['data']['token']);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(responsebody['message'])));
      Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(responsebody['message'])));
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
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/1703057726807.png",
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Text("DrugSwift",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "Lobster",
                          color: Color.fromARGB(229, 139, 139, 139))),
                  Container(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: formkey,
                      child: Container(
                        margin: EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            ),
                            Container(
                              height: 15,
                            ),
                            Text(
                              "Login to continue using the website",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Container(
                              height: 20,
                            ),
                            Text(
                              "Admin Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Container(
                              height: 15,
                            ),
                            CustomTextField(
                              hintText: "Enter Your Email",
                              mycontroller: email,
                              textInputType: TextInputType.text,
                              prefixIcon: Icon(Icons.mail),
                              obscureText: false,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "This field is required";
                                } else if (!p0.contains('@') ||
                                    !p0.contains('.')) {
                                  return "This field must contain an email";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 15,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Container(
                              height: 15,
                            ),
                            CustomTextField(
                                hintText: "Enter Your Password",
                                mycontroller: password,
                                textInputType: TextInputType.text,
                                obscureText: true,
                                prefixIcon: Icon(Icons.lock),
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "This field is required";
                                  }
                                  if (p0.length < 8) {
                                    return "The password must contain at least 8 characters";
                                  }
                                  return null;
                                }),
                            Container(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.elliptical(10, 19)),
                    child: MaterialButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          logInAdmin();
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color.fromARGB(255, 48, 38, 135),
                      minWidth: 500,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
