import 'package:flutter/material.dart';
import 'package:timeapp/Screens/home.dart';
import 'package:timeapp/Screens/loading.dart';
import 'package:timeapp/Screens/locationpicker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => loading(),
      '/home': (context) => Home(),
      '/location': (context) => locationpicker()
    },
  ));
}
