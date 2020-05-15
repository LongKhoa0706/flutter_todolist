import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model/user.dart';
import 'package:flutter_app1/util/dbmanager.dart';

class AuthenProvider with ChangeNotifier {
  DbManager _dbManager = DbManager();
  User user;
  String error = '';
  final confirmController = TextEditingController();

  Future<bool> register(String email, String name, String password) async {
    if (user == null) {
      User user = User(email: email.trim(), name: name.trim(), password: password);
      await _dbManager.addUser(user);
    }
    return true;
  }


  Future<bool> login(String email, String password) async {
    dynamic result = await _dbManager.checkLoginUser(email,password);
    if (result!=null) {
      error = "Thanh cong";
      return true;
    }else{
      error = "that bai ";
    }
    return false;
  }

  String validateEmail(String email) {
    if (email.isEmpty) {
      return "Email should not be empty";
    } else if (!EmailValidator.validate(email)) {
      return "Please enter validate email";
    }

  }

  String validatePassWord(String password) {
    if (password.length == 0) {
      return 'Password should not be empty';
    } else if (password.length < 4) {
      return 'Password too short';
    } else if (password != confirmController.text) {
      return 'Password not matching';
    }
  }
}
