import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Text(
              'เมนูหลัก',
              style: TextStyle(fontSize: 24, color: Colors.white70),
            )),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Theme.of(context).primaryColor, size: 30,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/');
          },
        ),ListTile(
          leading: Icon(
            Icons.bookmark,
            color: Theme.of(context).primaryColor,size: 30,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/product');
          },
        ),
      ],
    ));
  }
}
