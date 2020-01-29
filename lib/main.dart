import 'package:flutter/material.dart';

import 'package:flutter_app1/authen/login/loginscreen.dart';

import 'package:flutter_app1/authen/register/registerscreen.dart';

import 'package:flutter_app1/view/home/dashboard.dart';
import 'package:flutter_app1/view/home/newtaskscreen.dart';
import 'package:flutter_app1/view/splashscreen/splashscreen.dart';
import 'package:flutter_app1/view/splashscreen/walkthoughscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
     initialRoute: "/",
//
//     routes: {
//       '/walkthoughtscreen':(_)=>WalkThoughtScreen(),
//       '/loginscreen':(_)=>LoginScreen(),
//       '/registerscreen':(_)=>RegisterScreen(),
//     },

      //MaterialPageRoute can not use name route

      // onGenerateRoute allow MaterialPageRoute next page with animation
      //MaterialPageRoute allow next page with animation
      onGenerateRoute: (RouteSettings setting){
        switch(setting.name){
          case '/':
            return MaterialPageRoute(builder: (context)=> SplashScreen());
            break;
          case '/walkthoughtscreen':
            return MaterialPageRoute(builder: (context)=> WalkThoughtScreen());
            break;
          case '/loginscreen':
            return MaterialPageRoute(builder: (context)=> LoginScreen());
            break;
          case '/registerscreen':
            return MaterialPageRoute(builder: (context)=> RegisterScreen());
            break;
          case '/dashboard':
            return MaterialPageRoute(builder: (context)=> DashBoard());
            break;
          case '/newtaskscreen':
            return MaterialPageRoute(builder: (context)=> NewTaskScreen());
            break;
        }
      },

      // return route name does not exits
      onUnknownRoute: (RouteSettings setting){
        return MaterialPageRoute(builder: (_)=>Text("Round name does not exist"));
      },
    );
  }

}
//class SlideRightRoute extends PageRouteBuilder {
//  final Widget widget;
//
//  SlideRightRoute({this.widget})
//      : super(
//    pageBuilder: (BuildContext context, Animation<double> animation,
//        Animation<double> secondaryAnimation) {
//      return widget;
//    },
//    transitionsBuilder: (BuildContext context,
//        Animation<double> animation,
//        Animation<double> secondaryAnimation,
//        Widget child) {
//      return new SlideTransition(
//        position: new Tween<Offset>(
//          begin: const Offset(1.0, 0.0),
//          end: Offset.zero,
//        ).animate(animation),
//        child: child,
//      );
//    },
//  );
//}
