import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/router_path.dart';

import 'package:flutter_app1/util/const.dart';
import 'package:flutter_app1/view/home/profilescreen.dart';

import 'notescreen.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentIndex = 0;

  final _drawerState = GlobalKey<DrawerControllerState>();
  List<Widget> listScreen = [
    NoteScreen(),
    ProfileScreen(),
  ];
  List<String> listTitleNavigation = [
    "To-do",
    "Profile",
    "Scheduler",
    "Notifcation"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Constants.backgroundMain),//change icon color drawe
        elevation: 0.0,
        centerTitle: true,
        title: Text(currentIndex == 0 ? "To-do".toUpperCase() : "Profile".toUpperCase(),style: TextStyle(color: Constants.backgroundMain,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.search,color: Constants.backgroundMain,size: 30,),
          )
        ],
        backgroundColor: Constants.backgroundApp,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Constants.backgroundMain,
        backgroundColor: Constants.backgroundApp,
          currentIndex: this.currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            _buildBottomNavigationBarItem(Icons.list),
            _buildBottomNavigationBarItem(Icons.person_outline),
          ]),
      body: IndexedStack(
        children: listScreen,
        index: currentIndex,
      ),
      drawer: Drawer(
        key: _drawerState,
        child: SafeArea(
          child: Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network('https://demo.wenthemes.com/university-hub-pro/wp-content/uploads/sites/34/2016/12/team2.jpg',),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Text("Tiffany",style: TextStyle(color: Constants.backgroundMain,fontWeight: FontWeight.bold,fontSize: 25),)
                  ],
                ),
              ),
              Divider(thickness: .5,color: Colors.grey,height: 20,),
             ListView.builder(shrinkWrap: true,itemCount: listTitleNavigation.length,itemBuilder: (_,i){
               return ListTile(
                 onTap: (){
                    Navigator.pop(context);
                 },
                 title: Text(listTitleNavigation[i],style: TextStyle(color: Constants.backgroundMain,fontWeight: FontWeight.bold,fontSize: 16),),
               );
             },),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text("Logout",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),),
              ),

            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.backgroundMain,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () =>Navigator.of(context).pushNamed(AddRoute),
      ),
    );
  }

  _buildBottomNavigationBarItem(IconData iconData) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        size: 27,
      ),
      title: Text(""),
    );
  }

}
