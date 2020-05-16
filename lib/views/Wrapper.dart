import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesimpleappv2/models/user.dart';
import 'package:thesimpleappv2/views/home.dart';
import 'package:thesimpleappv2/views/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
