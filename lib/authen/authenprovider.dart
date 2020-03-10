import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model/user.dart';
import 'package:flutter_app1/util/dbmanager.dart';

class AuthenProvider with ChangeNotifier {
  DbManager _dbManager = DbManager();
  User user;
  final confirmController = TextEditingController();


  Future<User> register(String email, String name, String password) async {
    if (user == null) {
      User user = User(
          email: email.trim(), name: name.trim(), password: password);
      await _dbManager.addUser(user);
      print(user);
//      _scafforState.currentState.showSnackBar(SnackBar(content: Text("Successful"),),);
    }
  }

  String validateEmail(String email) {
    if (!EmailValidator.validate(email)) {
      return 'Please enter a valid email';
    }
  }

  String validatePassWord(String password) {
    if (password.length == 0) {
      return 'Password should not be empty';
    } else if (password.length < 4) {
      return 'Password too short';
    }else if(password != confirmController.text){
      return 'Password not matching';
    }
  }
}