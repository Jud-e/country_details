import 'package:country_details/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const Homepage(),
      darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: HexColor("#000F24"),
              titleTextStyle: TextStyle(
                  fontFamily: "Axiforma",
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 25)),
          scaffoldBackgroundColor: HexColor("#000F24"),
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          inputDecorationTheme: InputDecorationTheme(
              prefixIconColor: HexColor("#EAECF0"),
              hintStyle: TextStyle(
                  color: HexColor("#EAECF0"),
                  fontFamily: "Axiforma",
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              fillColor: Color.fromRGBO(152, 162, 179, 0.2))),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: HexColor("#000F24"),
            titleTextStyle: const TextStyle(
                fontFamily: "Axiforma",
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 25),
          ),
          primarySwatch: Colors.blue,
          iconTheme: IconThemeData(color: Colors.black),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: "Axiforma",
                fontSize: 16,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
          )),
    );
  }
}
