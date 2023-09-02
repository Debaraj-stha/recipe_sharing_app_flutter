import 'package:flutter/material.dart';
import 'package:frontend/pages/homepage1.dart';
import 'package:frontend/pages/intropage.dart';
import 'package:frontend/pages/otpPage.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/simmerEffect.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => myProvider(),
        child: MaterialApp(
          title: 'Recipie sharing app',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const homePage1(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recipie sharing app",
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
