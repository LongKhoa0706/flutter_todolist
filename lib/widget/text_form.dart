import 'package:flutter/material.dart';
import 'package:flutter_app1/util/const.dart';
class TextForm extends StatelessWidget {
  final String title;

  TextForm(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(color: Constants.backgroundMain,fontSize: 18,fontWeight: FontWeight.w500),);
  }
}
