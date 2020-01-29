import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app1/model/user.dart';
import 'package:flutter_app1/util/const.dart';
import 'package:flutter_app1/util/dbmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DbManager dbManager = DbManager();
  String emailUser = "";
  String nameUser = "";
  User user = User();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    main();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xffFFDBDB),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://demo.wenthemes.com/university-hub-pro/wp-content/uploads/sites/34/2016/12/team2.jpg',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          nameUser,
                          style: TextStyle(
                              color: Constants.backgroundMain,
                              fontWeight: FontWeight.bold,
                              fontSize: 27),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          emailUser,
                          style: TextStyle(
                              color: Constants.backgroundMain, fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> main() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    emailUser = sharedPreferences.getString('email');
    nameUser  = sharedPreferences.getString('nameUser');
  }


}
