import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesimpleappv2/helper/loading.dart';
import 'package:thesimpleappv2/models/user.dart';
import 'package:thesimpleappv2/services/database.dart';



class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey =GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData=snapshot.data;
          return DraggableScrollableSheet(
            builder: (context,scrollController){
              return SingleChildScrollView(
                controller: scrollController,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text("Update your Setting.",
                        style: TextStyle(fontSize: 18.0),),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        initialValue: userData.name,
                        validator: (val)=> val.isEmpty?'Please enter a Name':null,
                        onChanged: (val)=>setState(()=>_currentName=val),
                      ),
                      DropdownButtonFormField(
                        value: _currentSugar ?? userData.sugar,
                        items: sugars.map((sugar){
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _currentSugar=val;
                          });
                        },
                      ),
                      Slider(
                          min: 100.0,
                          max: 900.0,
                          divisions: 8,
                          value: (_currentStrength?? userData.strength).toDouble(),
                          activeColor: Colors.teal[_currentStrength?? userData.strength],
                          inactiveColor: Colors.teal[_currentStrength?? userData.strength],
                          onChanged: (val){
                            setState(() {
                              _currentStrength=val.round();
                            });
                          }
                      ),
                      SizedBox(height: 20.0,),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text('Update',style: TextStyle(color: Colors.white),),
                          onPressed: ()async{
                            if(_formKey.currentState.validate()){
                              await DatabaseService(uid: user.uid).updateUserData(
                                  _currentSugar ?? userData.sugar,
                                  _currentName ?? userData.name,
                                  _currentStrength ?? userData.strength
                              );
                              Navigator.pop(context);
                            }
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        }else{
          return Loading();
        }
      }
    );
  }
}
