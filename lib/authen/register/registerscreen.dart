import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model/user.dart';
import 'package:flutter_app1/util/const.dart';
import 'package:flutter_app1/util/dbmanager.dart';
import 'package:flutter_app1/widget/custom_textformfiel.dart';
import 'package:flutter_app1/widget/text_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formState = GlobalKey<FormState>();
  DbManager _dbManager = DbManager();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  User user;
  final _confirmPassController = TextEditingController();
  final _nameController = TextEditingController();
  final _scafforState = GlobalKey<ScaffoldState>();
@override
  void initState() {
  _dbManager.opentDb();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafforState,
      backgroundColor: Constants.backgroundApp,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "register".toUpperCase(),
                    style: TextStyle(
                      color: Constants.backgroundMain,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: _formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextForm("Email"),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                            controller: _emailController,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm("Name"),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          TextFormField(
                            validator: (val)=>val.isNotEmpty ? null : "Name should not be empty",
                            controller: _nameController,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm("Password"),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          TextFormField(
                            obscureText: true,
                            validator: validatePassWord,
                            controller: _passController,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm("Confirm Password"),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          TextFormField(
                            obscureText: true,
                            validator: validatePassWord,
                            controller: _confirmPassController,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () => registerUser(context),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            color: Constants.backgroundMain,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Text(
                            "By registering, you automatically accept the Terms & Policies of candy app.",
                            style: TextStyle(
                              color: Constants.backgroundMain,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text(
                              "Have account? Log In",
                              style: TextStyle(
                                  color: Constants.backgroundMain,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  registerUser(BuildContext context) {
    if (_formState.currentState.validate()) {
      if(user == null){
        User user = User(email: _emailController.text.toString().trim(),name: _nameController.text,password: _passController.text);
        _dbManager.addUser(user);
        main();

        _scafforState.currentState.showSnackBar(SnackBar(content: Text("Successful"),),);
      }

    }
  }

   String validateEmail(String value) {
       if (!EmailValidator.validate(value)) {
         return 'Please enter a valid email';
       }

  }
   String validatePassWord(String value){
    if(value.length == 0 ){
      return 'Password should not be empty';
    }else if(value.length < 4 ){
      return 'Password too short';
    }else if(value != _passController.text){
      return 'Password not matching';
    }
  }
  Future<void> main() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('nameUser', _nameController.text);
    print('thanh cong');
  }
}
