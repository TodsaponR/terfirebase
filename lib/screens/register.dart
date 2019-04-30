import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Explicit
  final formKey = GlobalKey<FormState>();

  Widget passwordTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 1.0, color: Colors.grey)),
          labelText: 'Password :',
          hintText: 'Your Password',
          icon: Icon(
            Icons.vpn_key,
            color: Colors.red,
          )),validator: (String value){
            if (value.length <=5) {
              return 'Please Type Password more 6 Charactor';
            }
          } ,
    );
  }

  Widget emailTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 1.0, color: Colors.grey)),
          labelText: 'Email :',
          hintText: 'Your email',
          icon: Icon(
            Icons.email,
            color: Colors.red,
          )),validator: (String value){
            if (value.length == 0) {
              return 'Please Fill e-mail in the Blank ';
            } else if (!((value.contains('@')) && (value.contains('.')))) {
              return 'Please Fill e-mail in the Format';
            }
          },
    );
  }

  Widget nameTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 1.0, color: Colors.grey)),
          labelText: 'Name :',
          hintText: 'Type Your Name',
          icon: Icon(
            Icons.account_circle,
            color: Colors.red,
          )),validator: (String value){
            if (value.length == 0) {
              return 'Please Fill Name in the Blank';
            } 
          },
    );
  }

  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      tooltip: 'Upload To Firebase',
      onPressed: () {
        print('You Click Upload');
        if (formKey.currentState.validate()) {
          
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Register'),
          actions: <Widget>[uploadButton()],
        ),
        body: Form(key: formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.white, Colors.blue],
                    radius: 2.0,
                    center: Alignment(0, 0))),
            padding: EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                nameTextFormField(),
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: emailTextFormField(),
                ),
                passwordTextFormField()
              ],
            ),
          ),
        ));
  }
}
