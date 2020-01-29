import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/main.dart';
import 'package:flutter_app1/authen/register/registerscreen.dart';
import 'package:flutter_app1/util/const.dart';
import 'package:flutter_app1/util/dbmanager.dart';
import 'package:flutter_app1/widget/custom_textformfiel.dart';
import 'package:flutter_app1/widget/text_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formState = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final DbManager _dbManager = DbManager();
  bool checkBox = false;

  AnimationController rippleController;
  AnimationController scaleController;

  Animation<double> rippleAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rippleController = AnimationController(
        vsync: this,

        duration: Duration(seconds: 1)
    );

    scaleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    });

    rippleAnimation = Tween(
        begin: 80.0,
        end: 75.0
    ).animate(rippleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rippleController.stop();
      } else if(status == AnimationStatus.dismissed) {
        rippleController.stop();
      }
    });

    scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 40.0
    ).animate(scaleController);
    rippleController.forward();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    rippleController.dispose();
    scaleController.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.backgroundApp,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "login".toUpperCase(),
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
                        validator: validateEmail,
                        controller: _emailController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextForm("Password"),
                        Text(
                          "Forgot?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      TextFormField(
                        validator: validatePassWord,
                        controller: _passController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: checkBox,
                          onChanged: (bool value) async {
                            setState(() {
                              checkBox = value;
                            });
                          },
                        ),
                        Text(
                          "Remember me!",
                          style: TextStyle(
                              color: Constants.backgroundMain,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                AnimatedBuilder(
                  animation: rippleAnimation,
                  builder: (context, child) => Container(
                    width: double.infinity,
                    height: rippleAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                      
                      ),
                      child: InkWell(
                        onTap: ()   {
                           loginUser(context);
                        },
                        child: AnimatedBuilder(
                          animation: scaleAnimation,
                          builder: (context, child) => Transform.scale(
                            scale: scaleAnimation.value,
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                  color: Constants.backgroundMain
                              ),
                              child: Center(
                                child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/registerscreen');
                      },
                      child: Center(
                        child: Text(
                          "New User? Register Here",
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
    );
  }

  loginUser(BuildContext context) async {
    if (_formState.currentState.validate()) {
      setState(() {});
      await _dbManager
          .checkLoginUser(_emailController.text.toString())
          .then((f) {
        if (f == null) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Account does not exist"),
          ));
        } else  {
          scaleController.forward();
          saveUser();
        }
      });
    }
  }

  String validateEmail(String value) {
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email';
    }
  }

  String validatePassWord(String value) {
    if (value.length == 0) {
      return 'Password should not be empty';
    } else if (value.length < 4) {
      return 'Password too short';
    } else if (value != _passController.text) {
      return 'Password not matching';
    }
  }

  Future<String> saveUser() async {
    if (checkBox == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', _emailController.text);
      preferences.setString('password', _passController.text);
      preferences.setBool('checked', true);
    }
  }
}
