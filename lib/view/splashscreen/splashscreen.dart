import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app1/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void startTimer(){
    Timer(Duration(seconds: 2), (){
      Navigator.of(context).pushReplacementNamed('/walkthoughtscreen');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundApp,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo.png',fit: BoxFit.cover,),
              Text("Candy",style: TextStyle(color: Constants.backgroundMain,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(height: 10,),
              Text("Simple Task Manager",style: TextStyle(color: Constants.backgroundMain,fontWeight: FontWeight.w600),),
            ],
          ),
        ),
      ),
    );
  }
  Future<String> main() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if( sharedPreferences.getBool('checked') == true && sharedPreferences.getBool('checked') == null  ){

      Navigator.of(context).pushReplacementNamed('/dashboard');

      print(sharedPreferences.getBool('checked'));
    }else{
      startTimer();
    }
  }
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    main();
  }
}
