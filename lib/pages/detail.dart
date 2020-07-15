import 'package:flutter/material.dart';
import 'package:testflutter/models/detail.dart';
import 'package:testflutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Course course;
  List<Chapter> chapter = [];
  var isLoading = false;

  getData(int id) async {
    setState(() {
      isLoading = true;
    });

    try {
      String url = 'https://api.codingthailand.com/api/course/' + id.toString();
      final res = await http.get(url);
      final Detail detail = Detail.fromJson(convert.jsonDecode(res.body));
      setState(() {
        chapter = detail.data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    course = ModalRoute.of(context).settings.arguments;
    getData(course.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${course.title}'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: chapter.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(5.00),
                  leading: Container(
                    width: 80.00,
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                  ),
                  title: Text(chapter[index].chTitle),
                  subtitle: Text(chapter[index].chDateadd),
                  trailing: Text(chapter[index].chTimetotal),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
    );
  }
}
