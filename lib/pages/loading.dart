import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:signature/signature.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flushbar/flushbar.dart';
import 'dart:convert' as convert;
//import 'package:testflutter/widgets/menu.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final _formKey = GlobalKey<FormState>();
  String barcodeInput;
  String barcode;
  final barcodeController = TextEditingController();

  var _signatureCanvas = Signature(
    //width: 400,
    width: screenWidth,
    height: 300,
    backgroundColor: Colors.lightBlueAccent,
    penColor: Colors.black,
    penStrokeWidth: 3.0,
  );
  
  String image;
  Position _currentPosition;
  static double screenWidth;

  Future scan() async {
    String cameraScanResult = await scanner.scan();
    setState(() {
      barcode = cameraScanResult;
    });
    barcodeController.text = barcode;
  }

  uploadImage(String image) async {
    print(image);
    var url = 'https://codingthailand.com/api/upload_image2.php';
    var res = await http.post(url,
        headers: {'Content-Type': 'apllication/json'},
        body: convert.json.encode({
          'imageData': 'data:image/png;base64,' + image,
          //barcodeInput
        }));
    if (res.statusCode == 200) {
      var feedback = convert.json.decode(res.body);
      var msg = feedback['message'];
      Flushbar(
        title: "$msg",
        message:
            "Save Complete.",
        duration: Duration(seconds: 3),
        icon: Icon(Icons.cloud_done),
      )..show(context);
      //print(feedback['message']);
    }
    else{
      Flushbar(
                  title:  "${res.statusCode}",
                  message:  "Please try again",
                  duration:  Duration(seconds: 3),          
                  icon: Icon(Icons.accessible_forward ),    
                )..show(context);
    }
  }

  _initCurrentLocation() async {
    _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(_currentPosition.latitude);
    print(_currentPosition.longitude);
  }

  @override
  void initState() {
    super.initState();
    scan();
    _initCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
    barcodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
        appBar: AppBar(
          title: Text('Loading'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.00),
                        child: TextFormField(
                          controller: barcodeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.00))),
                            labelText: 'BarCode',
                            hintText: 'Type Barcode',
                          ),
                          onSaved: (value) => barcodeInput = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please insert value';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.all(5.00),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _signatureCanvas,
                            Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.clear),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        return _signatureCanvas.clear();
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.00),
                        child: RaisedButton(
                          onPressed: () {
                            scan();
                          },
                          child: Text('Scan Barcode'),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.00),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print('submit $barcodeInput');

                              var bytes = await _signatureCanvas.exportBytes();
                              image = convert.base64.encode(bytes);
                              uploadImage(image);
                              _signatureCanvas.clear();
                              barcodeController.clear();
                            }
                          },
                          child: Text('Save Data'),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
