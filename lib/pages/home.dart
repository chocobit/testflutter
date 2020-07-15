import 'package:flutter/material.dart';
import 'package:testflutter/models/company.dart';
import 'package:testflutter/widgets/logo.dart';
import 'package:testflutter/widgets/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flushbar/flushbar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAuth = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  SharedPreferences prefs;
  String carNumber;
  Map profile;

  Scaffold buildMainMenu() {
    return Scaffold(
        appBar: AppBar(
          title: Logo(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.lock_open),
              onPressed: () {
                setState(() {
                  logout();
                });
              },
            )
          ],
        ),
        drawer: Menu(),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/loading');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.send,
                            color: Theme.of(context).primaryColor, size: 80.0),
                        Text(
                          'Delivery',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )
                      ],
                    )),
                    color: Colors.white70,
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/about',
                        arguments:
                            Company('TCP', 100, {'Province': 'Bangkok'}));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.book,
                            color: Theme.of(context).primaryColor, size: 80.0),
                        Text('About',
                            style: TextStyle(fontSize: 24, color: Colors.black))
                      ],
                    )),
                    color: Colors.white70,
                  )),
              GestureDetector(
                  onTap: () {
                    print('Contact');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.people,
                            color: Theme.of(context).primaryColor, size: 80.0),
                        Text('Contact',
                            style: TextStyle(fontSize: 24, color: Colors.black))
                      ],
                    )),
                    color: Colors.white70,
                  )),
              GestureDetector(
                  onTap: () {
                    print('Delivery');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.local_pizza,
                            color: Theme.of(context).primaryColor, size: 80.0),
                        Text('Delivery',
                            style: TextStyle(fontSize: 24, color: Colors.black))
                      ],
                    )),
                    color: Colors.white70,
                  )),
              GestureDetector(
                  onTap: () {
                    print('License Plate');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.perm_identity,
                            color: Theme.of(context).primaryColor, size: 80.0),
                         Text('Hello ${profile['name']??''}',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                       Text('Your id ${profile['id']}',
                            style: TextStyle(fontSize: 10, color: Colors.black))
                      ],
                    )),
                    color: Colors.white70,
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      logout();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.cloud_off,
                            color: Theme.of(context).primaryColor, size: 80.0),
                        Text('Logout',
                            style: TextStyle(fontSize: 24, color: Colors.black))
                      ],
                    )),
                    color: Colors.white70,
                  )),
            ],
          ),
        ));
  }

  Scaffold buildLoginScreen() {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'TCP',
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
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: login,
            child: Container(
              height: 100.00,
              width: 300.00,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/trial-8.png'),
                      fit: BoxFit.cover)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                padding: EdgeInsets.all(5.00),
                child: Text('Please register your email.',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline)),
              ),
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.all(5.00),
                child: Text('Forgot password.',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline)),
              )
            ],
          )
        ],
      ),
    ));
  }

  login() async {
    if (_fbKey.currentState.saveAndValidate()) {
      print(_fbKey.currentState.value);
      var url = 'https://api.codingthailand.com/api/login';
      var res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: convert.json.encode({
            'email': _fbKey.currentState.value['email'],
            'password': _fbKey.currentState.value['password']
          }));

      if (res.statusCode == 200) {
        await prefs.setString('token', res.body);
        //var msg = feedback['message'];
        //print('$msg');
        await getProfile();
        Navigator.pushReplacementNamed(context, '/');
        //checklogin();
      } else {
        var feedback = convert.json.decode(res.body);
        var msg = feedback['message'];
        Flushbar(
          title: "$msg",
          message: "Error Login Please try agian.",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.cloud_off),
        )..show(context);
      }
    }
  }

  checklogin() async {
    
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token'); //check state date logout do more

    if (token != null) {
      //getProfile();
      var profileString = prefs.getString('profile');
        if (profileString != null) {
          profile = convert.json.decode(profileString);
        }
        print('getprofile $profileString');
        
      setState(() {           
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  logout() async {
    await prefs.remove('token');
    await prefs.remove('profile');
    setState(() {
      isAuth = false;
    });
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  Future<void> getProfile() async {
    var tokenString = prefs.getString('token');
    var token = convert.json.decode(tokenString);

    var url = 'https://api.codingthailand.com/api/me';
    var res = await http.post(url,
        headers: {'Authorization': 'Bearer ' + token['access_token']},
        body: convert.json.encode({}));
    print(token['access_token']);
    print(res.body);
    var profile = convert.json.decode(res.body);
    await prefs.setString(
        'profile', convert.json.encode(profile['data']['user']));
    print(profile['data']['user']);
  }

  @override
  Widget build(BuildContext context) {
    return isAuth == true ? buildMainMenu() : buildLoginScreen();
  }
}
