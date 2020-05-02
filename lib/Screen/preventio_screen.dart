import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laoscovid19/Animation/Fadeanimation.dart';
import 'package:laoscovid19/Model/CovidSummary.dart';
import 'package:http/http.dart' as http;
import 'package:laoscovid19/Screen/detialscreen.dart';

class PreveentionScreen extends StatefulWidget {
  PreveentionScreen({Key key}) : super(key: key);

  @override
  _DashScreenState createState() {
    return _DashScreenState();
  }
}

class _DashScreenState extends State<PreveentionScreen> {

  var listCovidSum;
  var listCovidGlobal;

  int currIndex = 0;

  Future<String> feedCovidSummary() async {
    var response = await http.get('https://covid19.mathdro.id/api/countries/laos',headers: {'Accept':'application/json'}).timeout(Duration(seconds: 10));
    var obj = List<CovidSummary>();
    //print('body:' + _body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return response.body.toString();
    } else {
      return 'failed';
    }
  }

  Future<String> feedCovidGlobal() async {
    var response = await http.get('https://covid19.mathdro.id/api',headers: {'Accept':'application/json'}).timeout(Duration(seconds: 10));
    var obj = List<CovidSummary>();
    //print('body:' + _body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return response.body.toString();
    } else {
      return 'failed';
    }
  }


  @override
  void initState() {
    super.initState();
    feedCovidSummary().then((value) {
      setState(() {
        print(value);
        listCovidSum = json.decode(value);
      });
    });
    feedCovidGlobal().then((value){
      setState(() {
        listCovidGlobal = json.decode(value);
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
                            image: AssetImage('assets/image/preventbackdrop.jpg'),
                            fit: BoxFit.cover)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            bottom: 70,
                            left: 20,
                            child: FadeAnimation(1.5,Text(
                              'Covid 19 \nDash',
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
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                      child: Text('ການປ້ອງກັນການຕິດເຊື້ອ',style: TextStyle(fontSize: 20),),
                    ),
                  ),
                  preventionItem(title: 'ລ້າງມືເປັນປະຈຳ',mIcon: Icons.pan_tool,onPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetialScreen(bg_url: 'assets/image/washhand.jpg',id: 1,),));
                  }),
                  preventionItem(title: 'ໃສ່ໜ້າກາກອະນາໄມ',mIcon: Icons.mood,onPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetialScreen(bg_url: 'assets/image/mash.jpg',id: 2,),));
                  }),
                  preventionItem(title: 'ຮັກສາໄລຍະຫ່າງທາງສັງຄົມ',mIcon: Icons.group,onPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetialScreen(bg_url: 'assets/image/socialdistaincing.jpg',id: 3,),));
                  }),
                  preventionItem(title: 'Stay at home',mIcon: Icons.home,onPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetialScreen(bg_url: 'assets/image/stayAtHome.jpg',id: 4,),));
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget preventionItem({IconData mIcon,String title,Function onPress}){
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
            onTap: onPress,
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