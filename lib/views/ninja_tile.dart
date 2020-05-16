import 'package:flutter/material.dart';
import 'package:thesimpleappv2/models/ninjamodel.dart';

class NinjaTile extends StatelessWidget {

  final Ninja ninja;
  NinjaTile({this.ninja});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:2.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 4.0, 20.0,0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[ninja.strength],
            backgroundImage: AssetImage('android/assets/mello.png'),
          ),
          title: Text(ninja.name),
          subtitle: Text('Takes ${ninja.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
