import 'package:flutter/material.dart';
import 'package:testflutter/models/company.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String fullname = 'John Wick';

  @override
  Widget build(BuildContext context) {
    final Company company = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('AboutPage'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${company.title}',
            style: TextStyle(fontSize: 20.00),
          ),
          Text(
              'Company age ${company.age}  address ${company.address['Province']}'),
          Text('Employee Name $fullname'),
          Text('go back home.'),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.00, 20.00, 10.00, 10.00),
            child: RaisedButton(
              child: Text('Changename'),
              color: Colors.orange[900],
              textColor: Colors.black,
              onPressed: () => setState(() {
                fullname = 'Mary Ann';
              }),
            ),
          ),
          RaisedButton(
            child: Text('PopBack'),
            color: Colors.black12,
            textColor: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      )),
    );
  }
}
