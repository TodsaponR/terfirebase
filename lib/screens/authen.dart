import 'dart:developer';

import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import '../screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './my_service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
//For Form
  final formKey = GlobalKey<FormState>();

  //Constrant
  String titleHaveSpace = 'กรุณาใส่ข้อมูลให้ครบถ้วน';
  String titleEmailFalse = 'กรุณาบันทึกรูปแบบอีเมลล์';
  String titlePasswordFalse = 'รหัสต้องมีมากกว่า 6 ตัวอักษร';

  //Explicit
  String emailString, passwordString;

  //For firebase
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //For SnackBar
  final snackBarKey = GlobalKey<ScaffoldState>();

  //Initial Method
  @override
  void initState() {
    super.initState();
    print('initState Work');

    //checkAuthen(context);
    checkStatus(context);
  }

  Future checkStatus(BuildContext context) async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      goToService(context);
    }
  }

  void goToService(BuildContext context) {
    var serviceRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
  }

  //About Widget Method
  Widget signUpButton(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.android), label: Text('Sign UP'),
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //child: Text('Sing Up'),
      onPressed: () {
        print('You Click Sign Up');
        var registerRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  Widget signInButton(BuildContext context) {
    return RaisedButton.icon(
      label: Text('Sign In'),
      icon: Icon(Icons.account_circle),
      color: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        print('You Click SingIn');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('email ==>> $emailString, password ==>> $passwordString');
          checkAuthen(context);
        }
      },
    );
  }

  void checkAuthen(BuildContext context) async {
    FirebaseUser firebaseUser = await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
      print('Success Login ==>> ${objValue.toString()}');
      //Route with arrow back

      var myServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(myServiceRoute, (Route<dynamic> Route) => false);
    }).catchError((objValue) {
      String error = objValue.message;
      print('Error ==>>> $error');
      showSnackBar(error);
    });
  }

  void showSnackBar(String messageString) {
    SnackBar snackBar = new SnackBar(
      duration: Duration(seconds: 10),
      backgroundColor: Colors.red[900],
      content: Text(messageString),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    snackBarKey.currentState.showSnackBar(snackBar);
  }

  Widget passwordTextFormField() {
    return TextFormField(
      obscureText: true,
      decoration:
          InputDecoration(labelText: 'Password :', hintText: 'Charactor 8-10'),
      validator: (String value) {
        if (value.length <= 5) {
          return titlePasswordFalse;
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget emailTextFormField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Email :', hintText: 'you@mail.com'),
      validator: (String value) {
        if (value.length == 0) {
          return titleHaveSpace;
        } else if (!((value.contains('@')) && (value.contains('.')))) {
          return titleEmailFalse;
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget showAppName() {
    return Text(
      'Master Flutter',
      style: TextStyle(
          fontFamily: 'Schoolbell',
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue[900]),
    );
  }

  Widget showLogo() {
    return Image.asset('images/logo.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: snackBarKey,
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[900], Colors.white],
                    begin: Alignment(-1, -1))),
            padding: EdgeInsets.only(top: 100.0),
            alignment: Alignment(0, -1),
            child: Column(
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  child: showLogo(),
                ),
                Container(
                    margin: EdgeInsets.only(top: 15.0), child: showAppName()),
                Container(
                  margin: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: emailTextFormField(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: passwordTextFormField(),
                ),
                Container(
                    margin: EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(right: 4.0),
                        child: signInButton(context),
                      )),
                      Expanded(
                        child: signUpButton(context),
                      )
                    ]))
              ],
            ),
          ),
        ));
  }
}
