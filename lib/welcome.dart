import 'dart:async';
import 'package:flutter/material.dart';
import 'adduser.dart';

class RoutePage extends StatefulWidget {
  RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddNewUser()),
      );
    });
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xff29384D),
      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/pic1.png",
              width: double.infinity,)
            ],
          )),
    );
  }
}
