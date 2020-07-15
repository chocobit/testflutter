import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  register(Map formValue) async {
    print(formValue['name']);
    var url = 'https://api.codingthailand.com/api/register';
    var res = await http.post(url,
        headers: {'Content-Type': 'apllication/json'},
        body: convert.json.encode({
          'name': formValue['name'],
          'email': formValue['email'],
          'password': formValue['password'],
          'dob': formValue['dob'].toString().substring(0,10)
        }));

    if (res.statusCode == 201) {
      var feedback = convert.json.decode(res.body);
      var msg = feedback['message'];
      print('$msg');

      Flushbar(
        title: "$msg",
        message: "Save Complete.",
        duration: Duration(seconds: 2),
        icon: Icon(Icons.cloud_done),
      )..show(context);

      Future.delayed(Duration(seconds:3 ),(){
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    } else {
      var feedback = convert.json.decode(res.body);
      var msg = feedback['errors']['email'][0];
      print('error : $msg');
      Flushbar(
        title: "$msg",
        message: "Cannot save.",
        duration: Duration(seconds: 3),
        icon: Icon(Icons.cloud_done),
      )..show(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Register',
              style: TextStyle(color: Colors.white, fontSize: 60.00),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FormBuilder(
                  key: _fbKey,
                  //autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        attribute: "name",
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Full Name',
                            fillColor: Colors.white,
                            errorStyle: TextStyle(color: Colors.white)),
                        validators: [
                          FormBuilderValidators.required(
                              errorText: 'Please Input name'),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "email",
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email @ddress',
                            fillColor: Colors.white,
                            errorStyle: TextStyle(color: Colors.white)),
                        validators: [
                          FormBuilderValidators.required(
                              errorText: 'Please Input an Email'),
                          FormBuilderValidators.email(
                              errorText: 'Correct the email.')
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "password",
                        obscureText: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          // filled: true,
                        ),
                        validators: [
                          FormBuilderValidators.required(
                              errorText: 'Please Input an password'),
                          FormBuilderValidators.minLength(3,
                              errorText:
                                  'Please insert password atleast 3 character.')
                        ],
                      ),
                      FormBuilderDateTimePicker(
                        attribute: "dob",
                        inputType: InputType.date,
                        format: DateFormat("yyyy-MM-dd"),
                        decoration: InputDecoration(labelText: "Date of Birth"),
                      ),
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                      register(_fbKey.currentState.value);
                    }
                  },
                ),
                MaterialButton(
                  child: Text("Reset"),
                  onPressed: () {
                    _fbKey.currentState.reset();
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // register();
              },
              child: Container(
                height: 100.00,
                width: 300.00,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/trial-8.png'),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
