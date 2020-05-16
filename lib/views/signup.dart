import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesimpleappv2/helper/loading.dart';
import 'package:thesimpleappv2/services/auth.dart';
import 'package:thesimpleappv2/widget/widgets.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

//  SignUp({Key key, this.title}) : super(key: key);
//  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String _animationName = "idle";
  String email='', password='', name='',error='';

  final asset = AssetFlare(bundle: rootBundle, name: "android/assets/Filip.flr");


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return isLoading?Loading():Scaffold(
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
                        return val.isEmpty ? "Enter Name" : null;
                      },
                      onChanged: (val) {
                        name = val;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Name',
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Email" : null;
                      },
                      onChanged: (val) {
                        email = val;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.contact_mail),
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.length <6 ? "Enter Password at least 6 digit" : null;
                      },
                      onChanged: (val) {
                        password = val;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async{
                        if(_formKey.currentState.validate()){
                          setState(() {
                            isLoading=true;
                          });
                          dynamic result=await _auth.signUpWithEmailAndPassword(email, password);
                          if(result==null){
                            setState(() {
                              isLoading=false;
                            });
                            print('error sign up');
                          }else{
                            print('congrats !');
                            print(result.uid);
                          }
                        }
                      },

                      child: blueButton(context,"Sign Up"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              "Sign in here!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}



class SizingInfo{

  final Orientation orientation;
  SizingInfo({this.orientation});

  @override
  String toString(){
    return 'Orientation:$orientation';
  }
}

class BaseWidget extends StatelessWidget {

  final Widget Function(
      BuildContext context,SizingInfo sizingInfo
      ) builder;
  const BaseWidget({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizingInfo =SizingInfo();
    return builder(context ,sizingInfo);
  }
}
