import 'package:flutter/material.dart';
import 'package:testflutter/models/company.dart';
import 'package:testflutter/widgets/logo.dart';
import 'package:testflutter/widgets/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarLoginPage extends StatefulWidget {
  CarLoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CarLoginPageState createState() => _CarLoginPageState();
}

class _CarLoginPageState extends State<CarLoginPage> {
  bool isAuth = false;
  String carInput,carNumber;
  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;

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
                        Icon(Icons.child_friendly,
                            color: Theme.of(context).primaryColor, size: 80.0),
                        Text('License Plate $carNumber',
                            style: TextStyle(fontSize: 24, color: Colors.black))
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
        appBar: AppBar(title: Text('Login')),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ],
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.00),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.00))),
                            fillColor: Colors.lightBlue,
                            filled: true,
                            labelText: 'License Plate',
                            labelStyle: TextStyle(fontSize: 15.00),
                            hintText: 'Type License Plate',
                          ),
                          onSaved: (value) => carInput = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please insert License plate';
                            }
                            return null;
                          },
                        )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  login();
                },
                child: Container(
                  height: 100.00,
                  width: 300.00,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/trial-8.png'),
                          fit: BoxFit.cover)),
                ),
              )
            ],
          ),
        ));
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // print('License Plate is $carInput');
      await prefs.setString('carNumber', carInput);
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    carNumber = prefs.get('carNumber');
    if (carNumber != null) {
      setState(() {
        isAuth = true;
        print('input license plate');
      });
    } else {
      setState(() {
        isAuth = false;
        print('Worngnumber');
      });
    }
  }

  logout() async {
    await prefs.remove('carNumber');
    setState(() {
      isAuth = false;
    });
    Navigator.pushReplacementNamed(context,'/');
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return isAuth == true ? buildMainMenu() : buildLoginScreen();
  }
}
