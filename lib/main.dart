import 'package:flutter/material.dart';
import 'package:masal_application/anasayfa.dart';
import 'login.dart';

void main() => runApp(AnaGiris());

class AnaGiris extends StatelessWidget {
 @override

  Widget build(BuildContext context) {
      return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFD12828),
        accentColor: Colors.indigo,
      ),
      home: AnaSayfa(),
      debugShowCheckedModeBanner: false,
    );
   }
  }
var rotalar = <String, WidgetBuilder>{
  "/login": (BuildContext context) => LoginPage(),
  };