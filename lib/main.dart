import 'package:flutter/material.dart';
import 'package:flutter_app1/view/router.dart'  ;
import 'constant/router_path.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
     initialRoute: SplashRoute,
      onGenerateRoute: Router.generateRoute,

      // return route name does not exits
      onUnknownRoute: (RouteSettings setting){
        return MaterialPageRoute(builder: (_)=>Text("Round name does not exist"));
      },
    );
  }

}
