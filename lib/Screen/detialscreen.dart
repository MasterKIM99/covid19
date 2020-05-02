import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laoscovid19/Animation/Fadeanimation.dart';
import 'package:laoscovid19/Model/CovidSummary.dart';
import 'package:http/http.dart' as http;

class DetialScreen extends StatefulWidget {
  String bg_url;
  int id;
  DetialScreen({Key key,this.bg_url,this.id}) : super(key: key);

  @override
  _DashScreenState createState() {
    return _DashScreenState(bg_url: bg_url,id: id);
  }
}

class _DashScreenState extends State<DetialScreen> {

  String bg_url;
  int id;
  var listCovidSum;
  var listCovidGlobal;

  _DashScreenState({this.bg_url,this.id});

  int currIndex = 0;
  var listOfdetial;

  Future<String> getDetial() async {
    var decodeJson = json.decode(await DefaultAssetBundle.of(context).loadString("assets/JSON/howtoprevent.json"));
    return decodeJson;
  }


  @override
  void initState() {
    super.initState();
    getDetial().then((value){
      setState(() {
        listOfdetial = json.decode(value);
      });
    });
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(bg_url),
                            fit: BoxFit.cover)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            bottom: 70,
                            left: 20,
                            child: FadeAnimation(1.5,Text(
                              listOfdetial!=null?listOfdetial[--id]['title']:'N/A',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ))),
                      ],
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 230),
              padding: EdgeInsets.only(top: 10),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                children: <Widget>[
                  Text(listOfdetial!=null?listOfdetial[--id]['detial']:'N/A')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget preventionItem({IconData mIcon,String title}){
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0),
                bottomRight: Radius.circular(35.0),
                bottomLeft: Radius.circular(35.0))),
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green[100]
                ),
                child: Icon(mIcon,color: Colors.green,)),
            title: Text(title),
            trailing: Icon(Icons.navigate_next)
          ),
        ),
      ),
    ),
  );
}