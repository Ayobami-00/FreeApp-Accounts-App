import 'package:flutter/material.dart';
import 'package:freeapp_accounts_app/db/creditUpload.dart';
import 'package:freeapp_accounts_app/db/sharedPreferencedb.dart';
import 'package:freeapp_accounts_app/db/teamMembersdb.dart';
import 'package:freeapp_accounts_app/db/usersdb.dart';
import 'package:freeapp_accounts_app/pages/basepage.dart';
import 'package:freeapp_accounts_app/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCredit extends StatefulWidget {
  @override
  _AddCreditState createState() => _AddCreditState();
}

class _AddCreditState extends State<AddCredit> {
  CreditUpload _creditUpload = CreditUpload();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> categoriesDropDown2 =
      <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentCategory2;

  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _amount = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories2 = <DocumentSnapshot>[];
  TeamMembersListService _teamMemebersList = TeamMembersListService();
  UsersDb _usersDb = UsersDb();
  bool _isLoading = false;

  @override
  void initState() {
    _getCategories();
    // _getCategories2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: _isLoading
          ? Loading()
          : Stack(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[350],
                            blurRadius:
                                20.0, // has the effect of softening the shadow
                          )
                        ],
                      ),
                      child: Form(
                          key: _formKey,
                          child: ListView(
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "ADD CREDIT",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  // borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _name,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Name",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Entry cannot be empty!';
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  // borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _description,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Short Description",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Entry cannot be empty!';
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  // borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _amount,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Amount in figures",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Entry cannot be empty!';
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                "Add a team members below relevant to this credit",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: DropdownButton(
                                      items: categoriesDropDown,
                                      onChanged: changeSelectedCategory,
                                      value: _currentCategory,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 10.0,
                                  // ),
                                  // Expanded(
                                  //   child: DropdownButton(
                                  //     items: categoriesDropDown2,
                                  //     onChanged: changeSelectedCategory2,
                                  //     value: _currentCategory2,
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.0, 8.0, 14.0, 8.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black,
                                    elevation: 0.0,
                                    child: MaterialButton(
                                      onPressed: () {
                                        validateAndUpload();
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: Text(
                                        "Add",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ))
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data['name']),
                value: categories[i].data['name']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown2() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories2[i].data['name']),
                value: categories2[i].data['name']));
      });
    }
    return items;
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _teamMemebersList.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0].data['name'];
    });
  }

  _getCategories2() async {
    List<DocumentSnapshot> data = await _teamMemebersList.getCategories();
    print(data.length);
    setState(() {
      categories2 = data;
      categoriesDropDown2 = getCategoriesDropdown2();
      _currentCategory2 = categories2[0].data['name'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedCategory2(String selectedCategory) {
    setState(() => _currentCategory2 = selectedCategory);
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      if (double.tryParse(_amount.text) != null) {
          DateTime now = new DateTime.now();
        _creditUpload.uploadCredit({
          "nameOfEntry": _name.text,
          "amount": double.parse(_amount.text),
          "description": _description.text,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toInt(),
          "teamMembersInvolved": _currentCategory,
          "statementType": 'Credit',
          "numberOfValidation": 1,
          "dateTime": '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
          'monthNumber': (DateTime.now().month % 3).toInt(),
        });
        _formKey.currentState.reset();
        setState(() => _isLoading = false);
        Navigator.pop(context);
        _key.currentState.showSnackBar(
            SnackBar(content: Text('Credit added successfully!')));
      } else {
        setState(() => _isLoading = false);
        _key.currentState.showSnackBar(
            SnackBar(content: Text('Invalid Amount!')));
      }
    }
  }
}
