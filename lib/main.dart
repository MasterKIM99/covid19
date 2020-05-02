import 'package:flutter/material.dart';
import 'package:laoscovid19/Screen/dash_screen.dart';
import 'package:laoscovid19/Screen/preventio_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(MyApp());
  OneSignal.shared.init(
      "1d50f557-688d-4144-a88b-d32077fa4988",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: true
      }
  );
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int currIndex = 0;

  PageController pageController;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController(initialPage: (currIndex));
  }

  var pageItem = [DashScreen(),PreveentionScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          print('page: $value');
          setState(() {
            currIndex = value;
            // _controller = PageController(initialPage: (currIndex++));
          });
        },
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: <Widget>[
          DashScreen(),PreveentionScreen()
        ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currIndex,
        onTap: (value){

          setState(() {
            currIndex = value;
            pageController.animateToPage(currIndex,duration: Duration(milliseconds: 400),
              curve: Curves.decelerate,);

          });

          // or this to jump to it without animating
          //pageController.jumpToPage(currIndex);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.multiline_chart),
            title: Text('ສະຖິຕິ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            title: Text('ການປ້ອງກັນ'),
          )
        ],
      ),
    );
  }
}
