import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesimpleappv2/services/database.dart';
import 'package:thesimpleappv2/widget/widgets.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _formKey = GlobalKey<FormState>();
  String sugar, strength,name;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Your Quote" : null;
                      },
                      onChanged: (val) {
                        sugar = val;
                      },
                      decoration: InputDecoration(
                        hintText: 'Create here',
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Create(),
                              ),
                            );
                          },
                          child: createButton(context, "Create"),
                        ),
                        GestureDetector(
                          onTap: () {

//                            Navigator.pushReplacement(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => createQuoteOnline(),
//                              ),
//                            );
                          },
                          child: createButton(context, "Submit"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
