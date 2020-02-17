import 'package:flutter/material.dart';
import 'package:freeapp_accounts_app/widgets/credits.dart';
import 'package:freeapp_accounts_app/widgets/debits.dart';
import 'package:freeapp_accounts_app/widgets/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _currentIndex = 1;
  String CURRENT_USER_NAME = 'Guest';
  final List<Widget> _children = [
    Credits(),
    HomePage(),
    Debits(),
  ];

  @override
  void initState() {
    getStringValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          Expanded(child: Text('Accountz -',textAlign: TextAlign.center,)),
          Expanded(child: Text(CURRENT_USER_NAME))
        ],
          ),
      ),
      body: _children[_currentIndex],
      //  _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, 
        onTap: onTabTapped,
       items: [
         
         BottomNavigationBarItem(
           icon: new Icon(Icons.attach_money),
           title: new Text('Credits'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: new Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.attach_money),
           title: Text('Debits')
         )
       ],
     ),
     
    );
  }
    getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('CURRENT_USER_NAME');
  setState(() {
    CURRENT_USER_NAME = stringValue; 
  });
}

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}


