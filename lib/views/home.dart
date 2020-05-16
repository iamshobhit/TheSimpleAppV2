import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesimpleappv2/models/ninjamodel.dart';
import 'package:thesimpleappv2/services/auth.dart';
import 'package:thesimpleappv2/services/database.dart';
import 'package:thesimpleappv2/views/setting_form.dart';
import 'package:thesimpleappv2/views/showlist.dart';
import 'package:thesimpleappv2/widget/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,horizontal: 60.0,
              ),
              child: SettingsForm(),
            );
          }
      );
    }

    return StreamProvider<List<Ninja>>.value(
      value: DatabaseService().ninjas,
      child: Scaffold(
        appBar: AppBar(
          title: appBar(context),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('setting'),
              onPressed: ()  {
                _showSettingsPanel();
              },
            ),
          ],

        ),
        body: Container(
            child: ShowList(),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                  image: AssetImage('android/assets/sinchan.png')),
            ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => Create(),
//                ));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
