import 'package:flutter/material.dart';
import 'package:flutter_app1/authen/authenprovider.dart';
import 'package:flutter_app1/model/user.dart';
import 'package:flutter_app1/util/const.dart';
import 'package:flutter_app1/util/dbmanager.dart';
import 'package:flutter_app1/widget/custom_textformfiel.dart';
import 'package:flutter_app1/widget/text_form.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: Register(),
      create: (_) => AuthenProvider(),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  DbManager _dbManager = DbManager();

  @override
  void initState() {
    _dbManager.opentDb();
    super.initState();
  }

  final _confirmPassController = TextEditingController();
  final _scafforState = GlobalKey<ScaffoldState>();
  final _formState = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';

  Future<void> submit() async {
    final form = _formState.currentState.validate();
    if (form) {
      await Provider.of<AuthenProvider>(context, listen: false).register(email, name, password);
    }
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
                        Consumer<AuthenProvider>(
                          builder: (BuildContext context, authenProvider, Widget child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CustomTextFormField(
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      email = value.trim();
                                      return authenProvider.validateEmail(value);
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
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
                                    validator: (val) => val.isNotEmpty ? null : "Name should not be empty",
                                    decoration: InputDecoration(border: InputBorder.none),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const  SizedBox(
                                  height: 20,
                                ),
                                TextForm("Password"),
                                const  SizedBox(
                                  height: 15,
                                ),
                                CustomTextFormField(
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      password = value.trim();
                                      return authenProvider
                                          .validatePassWord(value);
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                const   SizedBox(
                                  height: 20,
                                ),
                                TextForm("Confirm Password"),
                                const   SizedBox(
                                  height: 15,
                                ),
                                CustomTextFormField(
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value){
                                    return  authenProvider.validatePassWord(password);
                                    },
                                    controller: authenProvider.confirmController,
                                    decoration:
                                    InputDecoration(border: InputBorder.none),
                                  ),
                                ),
                                const  SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: submit,
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
                                const     SizedBox(
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
                            );
                          },
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
}
