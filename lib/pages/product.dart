import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:testflutter/models/product.dart';
import 'package:testflutter/widgets/menu.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Course> course = [];
  var isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      String url = 'https://api.codingthailand.com/api/course';
      final res = await http.get(url);
      final Product product = Product.fromJson(convert.jsonDecode(res.body));
      setState(() {
         course = product.data;
        isLoading = false;
      });
      /*
      if (res.statusCode == 200) {
        course = product.data;
        isLoading = false;
      } else {
        setState(() {
          //course = product.data;
          isLoading = false;
        });
      }*/

    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }

    //course = product.data;
    //print(res.body);
  }

  @override
  void initState() {
    super.initState();
    //getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product')),
      drawer: Menu(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: course.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(5.00),
                  leading: Container(
                    width: 80.00,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(course[index].picture))),
                  ),
                  title: Text(course[index].title),
                  subtitle: Text(course[index].detail),
                  trailing: Icon(
                    Icons.arrow_right,
                    size: 30.00,
                  ),
                  onTap: () {
                    //print(course[index].toJson());
                    Navigator.pushNamed(context, '/detail',
                    arguments: Course(id: course[index].id , title: course[index].title)
                    );   
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
    );
  }
}
