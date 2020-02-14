import 'package:flutter/material.dart';
import 'package:freeapp_accounts_app/widgets/credits.dart';
import 'package:freeapp_accounts_app/widgets/debits.dart';
import 'package:freeapp_accounts_app/widgets/homepage.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    Credits(),
    HomePage(),
    Debits(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accountz',textAlign: TextAlign.center,),
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
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}


