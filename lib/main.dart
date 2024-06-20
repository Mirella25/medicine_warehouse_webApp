import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/login.dart';
import 'package:flutter_application_1/pages/addpage.dart';
import 'package:flutter_application_1/pages/categories.dart';
import 'package:flutter_application_1/pages/details.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/notifications.dart';
import 'package:flutter_application_1/pages/orders.dart';
import 'package:flutter_application_1/pages/report.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Website',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 227, 190, 251),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 48, 38, 135),
        ),
        useMaterial3: true,
      ),
      home: Center(
          child: FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Some error has Occurred');
                } else if (snapshot.hasData) {
                  final token = snapshot.data!.getString('token');
                  if (token != null) {
                    return HomePage();
                  } else {
                    return LogIn();
                  }
                } else {
                  return LogIn();
                }
              })),
      routes: {
        'home': (context) => HomePage(),
        'add': (context) => const AddPage(),
        'category': (context) => const Categories(),
        'details': (context) => Details(),
        'login': (context) => LogIn(),
        'order': (context) => Orders(),
        'notification': (context) => Notifications(),
        'report': (context) => Report(),
      },
    );
  }
}
