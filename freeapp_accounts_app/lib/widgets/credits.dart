import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freeapp_accounts_app/pages/accountStatementDetails.dart';
import 'package:freeapp_accounts_app/widgets/addCredits.dart';
import 'package:freeapp_accounts_app/widgets/loading.dart';

enum Page {normal, monthView}


class Credits extends StatefulWidget {
  @override
  
  _CreditsState createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  int  monthNumberVal;
  Page _selectedPage = Page.normal;
  String _currentMonth = "0";
  List _dropDownList = ["1","2","3"];
  List<DropdownMenuItem<String>> monthsDropDown = <DropdownMenuItem<String>>[];
  // double _total = 0.0;
  
  
  
  

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 10.0),
              FlatButton.icon(
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCredit())), 
                    icon: Icon(Icons.add), 
                    label: Text("CREDITS",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                    ),
                    SizedBox(width: 10.0),
                  Text("Choose Month Category"),
                  DropdownButton(
                          items: getMonthsDropdown(),
                          onChanged: changeSelectedCategory,
                          value: _currentMonth,
                        ),
                  
            ],
          ),
          Divider(color: Colors.black),
          SizedBox(height: 10.0),
              Flexible(child:  _loadScreen(context, monthNumberVal)
              ,),
              // Divider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     SizedBox(width:10),
              //     Expanded(child:Text('Total :',style: TextStyle(fontWeight: FontWeight.bold),),),
              //     Text('N',style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough,)),
              //     Expanded(child:Text('$_total',style: TextStyle(fontWeight: FontWeight.bold),),),
              //   ],
              // ),
              // SizedBox(height:10),
              
              
               
        ],
      ),
     
    );
  }
  
  List<DropdownMenuItem<String>> getMonthsDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < _dropDownList.length+1 ; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text('$i'),
                value: i.toString()));
      });
    }
    return items;
  }


  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentMonth = selectedCategory);
    returnMonthListQuery(selectedCategory);

  }

  Widget _loadScreen(BuildContext context, int monthNumberVal){
    switch(_selectedPage){
      case Page.normal:
      return _buildBody(context);
      break;

      case Page.monthView:
      return _buildMonthlyBody(context, monthNumberVal);
      break;
    }
  }
  
  Widget _buildBody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('credits').orderBy('timestamp',descending: true)
      .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildMonthlyBody(BuildContext context,int monthNumberVal){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('credits')
      .where('monthNumber', isEqualTo : monthNumberVal).
      snapshots(),
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
          enabled: true,
          title: Text(statement.nameOfEntry, style: TextStyle(color: statement.numberOfValidation == 2 ? Colors.black : Colors.red,)),
          trailing: Text('N${statement.amount}', style: TextStyle(color: statement.numberOfValidation == 2 ? Colors.black : Colors.red,))
        ),
      ),
    );
  }
  

  void  returnMonthListQuery(String monthCat){
    switch(monthCat){
      case "0":
      setState(() {
        _selectedPage = Page.normal;
      });
      break;
      case "1":
      setState(() {
        monthNumberVal = 1;
        _selectedPage = Page.monthView;
      });
      break;
      case "2":
      setState(() {
       monthNumberVal = 2;
        _selectedPage = Page.monthView;
      });
      break;
      case "3":
      setState(() {
        monthNumberVal = 0;
        _selectedPage = Page.monthView;
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
        monthNumber = (map['monthNumber'] as num).toInt();

        SingleStatement.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


}
