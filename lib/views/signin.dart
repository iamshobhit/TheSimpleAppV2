import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesimpleappv2/helper/loading.dart';
import 'package:thesimpleappv2/services/auth.dart';
import 'package:thesimpleappv2/widget/widgets.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

//  SignIn({Key key, this.title}) : super(key: key);
//  final String title;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final asset = AssetFlare(bundle: rootBundle, name: "android/assets/totest1.flr");
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = new AuthService();
  String email='', password='';
  String _animationName = "activate";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading? Loading():Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: isLoading
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
                    Expanded(
                      child: FlareCacheBuilder(
                        [asset],
                        builder: (BuildContext context, bool isWarm) {
                          return !isWarm
                              ? Container(child: Text("NO"))
                              : FlareActor.asset(
                            asset,
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: _animationName,
                          );
                        },
                      ),
                    ),
                    //Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Email" : null;
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.isEmpty ? "Enter Password" : null;
                      },
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock_outline),
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
//                      onTap: (){
//                        if(_formKey.currentState.validate()){
//                          print(email);
//                          print(password);
//                        }
//                      },
                      onTap:() async {
                        if(_formKey.currentState.validate()){
                          setState(() {
                            isLoading=true;
                          });
                          dynamic result=await _auth.signInEmailAndPass(email, password);
                          if(result==null){
                            setState(() {
                              isLoading=false;
                            });
                            print('error sign in');
                          }else{
                            print('signed in');
                            print(result.uid);
                          }
                        }
//                  Navigator.pushReplacement(context, MaterialPageRoute(
//                      builder: (context)=>SignIn(),),);
                      },
                      child: blueButton(context, "Sign In"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        GestureDetector(
                            onTap: (){
                              widget.toggleView();
                            },
                            child: Text(
                              "Sign up here!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline),
                            )),
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
