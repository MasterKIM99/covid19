import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laoscovid19/Animation/Fadeanimation.dart';
import 'package:laoscovid19/Model/CovidSummary.dart';
import 'package:http/http.dart' as http;

class DashScreen extends StatefulWidget {
  DashScreen({Key key}) : super(key: key);

  @override
  _DashScreenState createState() {
    return _DashScreenState();
  }
}

class _DashScreenState extends State<DashScreen> {

  var listCovidSum;
  var listCovidGlobal;

  int currIndex = 0;
  var f = NumberFormat('#,###.##');
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
                            image: AssetImage('assets/image/3605324.jpg'),
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
              padding: EdgeInsets.only(top: 0),
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: ListView(
                children: <Widget>[
                  FadeAnimation(1.5,
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                        child: Text('ອັບເດດລ່າສຸດ: [${listCovidGlobal!=null?DateFormat('dd-MM-yyyy').format(DateTime.parse(listCovidGlobal['lastUpdate'].toString())):'N/A'}]',style: TextStyle(fontSize: 16,color: Colors.blueGrey),),
                      ),
                    ),
                  ),
              FadeAnimation(1.5,Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  child: Divider())),
                  FadeAnimation(1.5,
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                        child: Text('ສະຖິຕິທົ່ວໂລກ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  FadeAnimation(1.5, globalDash()),
                  FadeAnimation(1.5,Container(
                width: double.infinity,
                alignment: Alignment.center,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                    child: Text('ສະຖິຕິໃນລາວ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  )
                )),
                  FadeAnimation(1.5,cardDash(title: 'ຕິດເຊື້ອ',value: listCovidSum!=null?'${f.format(listCovidSum['confirmed']['value'])}':'N/A',colors: Colors.blueGrey[400],icon: Icons.bug_report)),
                  FadeAnimation(1.5,cardDash(title: 'ປິ່ນປົວເຊົາ',value: listCovidSum!=null? '${f.format(listCovidSum['recovered']['value'])}':'N/A',colors: Colors.green[400],icon: Icons.insert_emoticon)),
                  FadeAnimation(1.5,cardDash(title: 'ເສຍຊີວິດ',value: listCovidSum!=null? '${f.format(listCovidSum['deaths']['value'])}':'N/A',colors: Colors.red[400],icon: Icons.mood_bad)),
                  Image.asset('assets/image/30338779.jpg',height: 200,width: double.infinity,fit: BoxFit.fill,)
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget globalDash(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 3),
      height: 100,
      child: Card(
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(listCovidGlobal!=null?'${f.format(listCovidGlobal['confirmed']['value'])}':'N/A',style: TextStyle(color: Colors.red,fontSize: 20),),
                SizedBox(height: 10,),
                Text('ຕິດເຊື້ອ',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
              ],
            ),
            Container(height:60,child: VerticalDivider(thickness: 2,)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(listCovidGlobal!=null?'${f.format(listCovidGlobal['recovered']['value'])}':'N/A',style: TextStyle(color: Colors.green,fontSize: 20),),
                SizedBox(height: 10,),
                Text('ປິ່ນປົວເຊົາ',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
              ],
            ),
            Container(height:60,child: VerticalDivider(thickness: 2,)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(listCovidGlobal!=null?'${f.format(listCovidGlobal['deaths']['value'])}':'N/A',style: TextStyle(color: Colors.blueGrey,fontSize: 20),),
                SizedBox(height: 10,),
                Text('ເສຍຊີວິດ',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget cardDash({String title,String value,IconData icon,Color colors}){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 3),
    height: 100,
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0))),
      color: colors,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(icon,color: Colors.white, size: 40,),
                SizedBox(width: 10,),
                Text('$title',style: TextStyle(color: Colors.white,fontSize: 18),)
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '$value ',
              style: TextStyle(color: Colors.white,fontSize: 30),
              children: <TextSpan>[
                TextSpan(text: 'ຄົນ  ', style:  TextStyle(color: Colors.white,fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
