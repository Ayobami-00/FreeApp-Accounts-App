import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freeapp_accounts_app/db/verifyStatement.dart';
import 'package:freeapp_accounts_app/widgets/loading.dart';

class AccountStatementDetails extends StatefulWidget {
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

  const AccountStatementDetails(
      {this.uid,
      this.nameOfEntry,
      this.amount,
      this.description,
      this.timestamp,
      this.teamMembersInvolved,
      this.statementType,
      this.numberOfValidation,
      this.dateTime,
      this.monthNumber});

  @override
  _AccountStatementDetailsState createState() =>
      _AccountStatementDetailsState();
}

class _AccountStatementDetailsState extends State<AccountStatementDetails> {
  final _key = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
 Verify _verify =Verify();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statement Details'),
      ),
      key: _key,
      body: _isLoading
          ? Loading()
          : Stack(
              children: <Widget>[
                Container(
                    child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                            ),
                            Center(
                                child: Text(
                              widget.nameOfEntry,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0),
                            )),
                            Divider(
                              thickness: 5,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(height: 60),
                                Expanded(
                                  child: Container(
                                    height: 30.0,
                                    color: Colors.grey.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text('Statement Type',style: TextStyle(fontSize: 20.0),),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Expanded(child: Text(widget.statementType,style: TextStyle(fontSize: 20.0),))
                              ],
                            ),
                            Divider(),




                            Row(
                              children: <Widget>[
                                SizedBox(height: 60),
                                Expanded(
                                  child: Container(
                                    height: 30.0,
                                    color: Colors.grey.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text('Amount',style: TextStyle(fontSize: 20.0),),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Expanded(child: Text('N ${widget.amount}',style: TextStyle(fontSize: 20.0),))
                              ],
                            ),
                            Divider(),



                            Row(
                              children: <Widget>[
                                SizedBox(height: 60),
                                Expanded(
                                  child: Container(
                                    height: 30.0,
                                    color: Colors.grey.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text('Date Time',style: TextStyle(fontSize: 20.0),),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Expanded(child: Text(widget.dateTime,style: TextStyle(fontSize: 20.0),))
                              ],
                            ),
                            Divider(),



                            Row(
                              children: <Widget>[
                                SizedBox(height: 60),
                                Expanded(
                                  child: Container(
                                    height: 50.0,
                                    color: Colors.grey.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text('Team Members Involved',style: TextStyle(fontSize: 20.0),),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Expanded(child: Text('${widget.teamMembersInvolved}',style: TextStyle(fontSize: 20.0),))
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Divider(thickness: 5,),
                            Center(child: Text('Description', style: TextStyle(fontSize: 15.0),)),
                            Divider(thickness: 5,),
                            SizedBox(height: 10.0,),
                            Flexible(child: Text(widget.description)),

                            FlatButton.icon(onPressed: widget.numberOfValidation < 2 ?()=> _verifyStatement() : null, icon: widget.numberOfValidation < 2 ? Icon(Icons.check,color: Colors.white,): Icon(Icons.check,color: Colors.white,size: 0.0,), label: widget.numberOfValidation < 2 ? Text('Verify',style: TextStyle(color: Colors.white,fontSize: 20.0)): Text(' '),color: Colors.black,)
                                                      ],
                                                    )))
                                          ],
                                        ),
                                );
                              }
                            
    void _verifyStatement() async {
      setState(() {
        _isLoading = true;
      });
      _verify.update(widget.statementType.toString().toLowerCase() + 's',
        { "uid": widget.uid,
          "nameOfEntry": widget.nameOfEntry,
          "amount": double.parse(widget.amount.toString()),
          "description": widget.description,
          "timestamp": widget.timestamp.toInt(),
          "teamMembersInvolved": widget.teamMembersInvolved,
          "statementType": widget.statementType,
          "numberOfValidation": widget.numberOfValidation.toInt() + 1,
          "dateTime": widget.dateTime,
          'monthNumber"': widget.monthNumber,
        });
        Navigator.pop(context);
        setState(() {
          _isLoading = false;
        });    
  }
}
