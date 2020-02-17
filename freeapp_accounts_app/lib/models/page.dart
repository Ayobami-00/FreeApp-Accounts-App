// Widget _buildAddBody(BuildContext context, List monthNumberList){
//   final _formKey = GlobalKey<FormState>();
//   final _key = GlobalKey<ScaffoldState>();
//   TextEditingController _nameOfEntry = TextEditingController();
//   TextEditingController _description = TextEditingController();
//   TextEditingController _amount = TextEditingController();

//     return Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[350],
//                             blurRadius:
//                                 20.0, // has the effect of softening the shadow
//                           )
//                         ],
//                       ),
//                       child: Form(
//                           key: _formKey,
//                           child: ListView(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: 40,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Container(
//                                     alignment: Alignment.topCenter,
//                                     child: Image.asset(
//                                       'images/logo.png',
//                                       width: 260.0,
//                                     )),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     14.0, 8.0, 14.0, 8.0),
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   color: Colors.grey.withOpacity(0.2),
//                                   elevation: 0.0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 12.0),
//                                     child: TextFormField(
//                                       controller: _nameOfEntry,
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: "Credit Name",
//                                       ),
//                                       validator: (value) {
//                                         if (value.isEmpty) {
//                                          return "Email cannot be empty";
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     14.0, 8.0, 14.0, 8.0),
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   color: Colors.grey.withOpacity(0.2),
//                                   elevation: 0.0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 12.0),
//                                     child: TextFormField(
//                                       controller: _description,
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: "Description",
//                                       ),
//                                       validator: (value) {
//                                         if (value.isEmpty) {
//                                           return "Entry cannot be empty";
//                                         } 
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     14.0, 8.0, 14.0, 8.0),
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   color: Colors.grey.withOpacity(0.2),
//                                   elevation: 0.0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 12.0),
//                                     child: TextFormField(
//                                       controller: _amount,
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: "Amount",
//                                       ),
//                                       validator: (value) {
//                                         if (value.isEmpty) {
//                                           return "Entry cannot be empty";
//                                         } 
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     14.0, 8.0, 14.0, 8.0),
//                                 child: Material(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                     color: Colors.black,
//                                     elevation: 0.0,
//                                     child: MaterialButton(
//                                       onPressed: () async {
//                                         if (_formKey.currentState.validate()) {
//                                           setState(() {
//                                             _isLoading = true;
//                                           });
//                                           if (await _usersDb.validateEmail(
//                                               _email.text, _password.text)) {                 
//                                             Navigator.pushReplacement(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         BasePage()));
//                                             setState(() {
//                                               _isLoading = false;
//                                             });
//                                           } else {
//                                             setState(() {
//                                               _isLoading = false;
//                                             });
//                                             _key.currentState.showSnackBar(SnackBar(
//                                                 content: Text(
//                                                     "Login falied! Wrong Input details")));
//                                           }
//                                         }
//                                       },
//                                       minWidth:
//                                           MediaQuery.of(context).size.width,
//                                       child: Text(
//                                         "Login",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20.0),
//                                       ),
//                                     )),
//                               ),
//                             ],
//                           )),
//                     ),
//                   ),
//                 ),
//   }
  