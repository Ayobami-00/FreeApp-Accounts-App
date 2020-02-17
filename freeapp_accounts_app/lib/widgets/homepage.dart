import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freeapp_accounts_app/db/sharedPreferencedb.dart';
import 'package:freeapp_accounts_app/pages/accountStatementDetails.dart';
import 'package:freeapp_accounts_app/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Page {credits, debits}

class HomePage extends StatefulWidget {
  @override
  
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List monthNumberList = [];
  Page _selectedPage = Page.credits;
  String _currentMonth = "Credits";
  List _dropDownList = ["Credits","Debits"];
  List<DropdownMenuItem<String>> monthsDropDown = <DropdownMenuItem<String>>[];
  String CURRENT_USER_NAME;

  @override
  void initState() {
    getStringValuesSF();
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 10.0),
              Text("VERIFY",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  Text("Choose Statement Category :"),
                  DropdownButton(
                          items: getMonthsDropdown(),
                          onChanged: changeSelectedCategory,
                          value: _currentMonth,
                        ),
                  // FlatButton.icon(
                  //   onPressed: (){}, 
                  //   icon: Icon(Icons.arrow_drop_down), 
                  //   label: Text("Chose View Category"))
            ],
          ),
          Divider(color: Colors.black),
          SizedBox(height: 10.0),
              Flexible(child:  _loadScreen(context)
             
              ,),
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

  List<DropdownMenuItem<String>> getMonthsDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < _dropDownList.length ; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text('${_dropDownList[i]}'),
                value: _dropDownList[i]));
      });
    }
    return items;
  }


  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentMonth = selectedCategory);
    returnPageListQuery(selectedCategory);

  }

  Widget _loadScreen(BuildContext context){
    switch(_selectedPage){
      case Page.credits:
      return _buildCredits(context);
      break;

      case Page.debits:
      return _buildDebits(context);
      break;
    }
  }
  
  Widget _buildCredits(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('credits').where('numberOfValidation', isLessThan: 2)
      .where('teamMembersInvolved',isEqualTo: CURRENT_USER_NAME)
      .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }
// .where('teamMembersInvolved', arrayContains: Sharedpreference().getName('USERNAME'))
  Widget _buildDebits(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('debits').where('numberOfValidation',isLessThan: 2)
      .where('teamMembersInvolved',isEqualTo: CURRENT_USER_NAME)
      .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final statement = SingleStatement.fromSnapshot(data);

    return Material(
      child: InkWell(
        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountStatementDetails(

          uid: statement.uid,
          nameOfEntry: statement.nameOfEntry,
          amount: statement.amount,
          description: statement.description,
          timestamp: statement.timestamp,
          teamMembersInvolved: statement.teamMembersInvolved,
          statementType: statement.statementType,
          numberOfValidation: statement.numberOfValidation,
          dateTime: statement.dateTime,
          monthNumber: statement.monthNumber,
        ))), 
        child: ListTile(
          leading: Icon(Icons.bookmark),
          enabled: statement.numberOfValidation == 2 ? true : false,
          title: Text(statement.nameOfEntry),
          trailing: Text('N${statement.amount}')
        ),
      ),
    );
  }
  

  void  returnPageListQuery(String pageCat){
    switch(pageCat){
      case "Credits":
      setState(() {
        _selectedPage = Page.credits;
      });
      break;
      case "Debits":
      setState(() {
        _selectedPage = Page.debits;
      });
      break;
    }

  }
}


class SingleStatement{

  final DocumentReference reference;

  final String uid;
  final String nameOfEntry;
  final double amount;
  final String description;
  final int timestamp;
  final String teamMembersInvolved;
  final String statementType;
  final int numberOfValidation;
  final String dateTime;
  final int monthNumber;

  SingleStatement.fromMap(Map<String, dynamic> map, {this.reference})
      : uid = map['uid'],
        nameOfEntry = map['nameOfEntry'],
        amount = (map['amount'] as num).toDouble(),
        description = map['description'],
        timestamp = (map['timestamp'] as num).toInt(),
        teamMembersInvolved = map['teamMembersInvolved'],
        statementType = map['statementType'],
        numberOfValidation = (map['numberOfValidation']as num).toInt(),
        dateTime = map['dateTime'],
        monthNumber = map['monthNumber'];

        SingleStatement.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


}
