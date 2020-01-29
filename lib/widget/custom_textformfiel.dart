import 'package:flutter/material.dart';
import 'package:flutter_app1/util/const.dart';
class CustomTextFormField extends StatelessWidget {
  final Widget child;

  CustomTextFormField(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Constants.backgroundApp,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
