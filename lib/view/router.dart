import 'package:flutter/material.dart';
import 'package:flutter_app1/authen/login/loginscreen.dart';
import 'package:flutter_app1/authen/register/registerscreen.dart';
import 'package:flutter_app1/constant/router_path.dart';
import 'package:flutter_app1/view/home/dashboard.dart';
import 'package:flutter_app1/view/home/newtaskscreen.dart';
import 'package:flutter_app1/view/splashscreen/splashscreen.dart';
import 'package:flutter_app1/view/splashscreen/walkthoughscreen.dart';

 class Router{
   static Route<dynamic> generateRoute(RouteSettings settings){
     switch(settings.name){
       case SplashRoute:
         return MaterialPageRoute(builder: (_)=>SplashScreen());
       case OnBoardRoute:
         return MaterialPageRoute(builder: (_)=>WalkThoughtScreen());
       case LoginRoute:
         return MaterialPageRoute(builder: (_)=>LoginScreen());
       case RegisterRoute:
         return MaterialPageRoute(builder: (_)=>RegisterScreen());
       case DashBoardRoute:
         return MaterialPageRoute(builder: (_)=>DashBoard());
       case AddRoute:
         return MaterialPageRoute(builder: (_)=>NewTaskScreen());
       default:
         return MaterialPageRoute(builder: (_)=>Text("Route does not exists"));
     }
   }
 }