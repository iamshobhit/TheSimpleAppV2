import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesimpleappv2/models/ninjamodel.dart';
import 'package:thesimpleappv2/views/ninja_tile.dart';

class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  @override
  Widget build(BuildContext context) {


    final ninjas = Provider.of<List<Ninja>>(context)?? [];
//    ninjas.forEach((ninja) {
//      print(ninja.name);
//      print(ninja.sugar);
//      print(ninja.strength);
//    });
    return ListView.builder(
      itemCount: ninjas.length,
        itemBuilder: (context,index){
          return NinjaTile(ninja:ninjas[index]);
        },
    );
  }
}