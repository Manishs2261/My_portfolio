import 'package:flutter/material.dart';
import 'package:portfolio/PortfolioHomePage.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manish sahu - Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
      ),
      debugShowCheckedModeBanner: false,
      home: PortfolioHomePage(),
    );
  }
}





