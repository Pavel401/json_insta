import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_insta/constraints/colors.dart';
import 'package:json_insta/widgets/MainPage.dart';
import 'package:json_insta/widgets/reels_.dart';

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
        textTheme:
            Theme.of(context).textTheme.apply(displayColor: Colors.white),
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    List<String> _navmenu = [
      "IMAGE",
      "REELS",
      "IGTV",
    ];
    List<Widget> _widgets = [
      Main(),
      reels(),
      Main(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Insta-Saver'),
        leading: Icon(Icons.menu),
        actions: [
          //Icon(Icons.more_vert),
          PopupMenuButton<int>(
            color: Colors.white,
            onSelected: (item){
              
              handleClickActions(item);
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Exit')),
              
            ],
          ),
        ],
      ),
      backgroundColor: Colors.blueAccent,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(
            Icons.gradient_outlined,
            size: 30,
            color: Colors.blueAccent,
          ),
          Icon(
            Icons.movie_filter_outlined,
            size: 30,
            color: Colors.blueAccent,
          ),
          Icon(
            Icons.live_tv_outlined,
            size: 30,
            color: Colors.blueAccent,
          ),
        ],
        onTap: (index) {
          //Handle button tap
          _selectedIndex = index;
        },
      ),
      body: _widgets.elementAt(_selectedIndex),
    );
  }

  void handleClickActions(int item) {
    switch (item) {
    case 0:
    SystemNavigator.pop();
      break;
    
  }
  }
}
