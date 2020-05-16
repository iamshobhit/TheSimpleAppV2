import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thesimpleappv2/services/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:thesimpleappv2/views/Wrapper.dart';

import 'models/user.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  @override
//  void initState(){
//    checkUserLoggedInStatus() ;
//    super.initState();
//  }
//  checkUserLoggedInStatus() async{
//    HelperFunctions.getUerLoggedInDetails().then((value) {
//      setState(() {
//        isUserLoggedin =value;
//      });
//    });
//  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'thesimpleappv2',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Wrapper(),
      ),
    );
  }
}
