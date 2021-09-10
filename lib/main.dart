import 'package:flutter/material.dart';
import 'package:json_insta/colors.dart';
import 'package:json_insta/MainPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
 
  
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
          textTheme: Theme.of(context).textTheme.apply(displayColor: Colors.white),

      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colour1,
              color2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

          ),
        ),
        child: Main(),
      ),
    );
  }
}
