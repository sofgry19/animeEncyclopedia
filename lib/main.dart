import 'package:flutter/material.dart';
import 'searchView.dart';
import 'homeView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Encyclopedia',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'RedHatDisplay',
      ),
      home: MyHomePage(title: 'Anime Encyclopedia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin<MyHomePage> {
  @override
  bool get wantKeepAlive => true;

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeWidget(),
    SearchList(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: ('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              label: ('Search'),
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
