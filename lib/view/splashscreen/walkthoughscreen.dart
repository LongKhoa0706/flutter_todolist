import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/router_path.dart';
import 'package:flutter_app1/util/const.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class WalkThoughtScreen extends StatefulWidget {
  @override
  _WalkThoughtScreenState createState() => _WalkThoughtScreenState();
}

class _WalkThoughtScreenState extends State<WalkThoughtScreen> {
  List<String> listTitle = [
    "Todo list",
    "Easy complete checked",
    "Time manager",
  ];
  List<String> listImage = [
    "assets/img1.png",
    "assets/img2.png",
    "assets/img3.png",
  ];
  int currentIndex;
  SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(right: 20,left: 20,bottom: 10),
        child: Stack(
          children: <Widget>[
            Swiper(
              controller: _swiperController,
              index: currentIndex,
              itemCount: 3,

              pagination: SwiperPagination(builder: DotSwiperPaginationBuilder(color: Constants.backgroundApp,activeColor: Constants.backgroundMain,)),
              onIndexChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, intdex) {
                return IntroItem(
                  title: listTitle[intdex],
                  image: listImage[intdex],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(onTap: (){
                    Navigator.of(context).pushReplacementNamed(LoginRoute);
                  },child: Text("Skip",style: TextStyle(color: Constants.backgroundMain,fontWeight: FontWeight.bold,fontSize: 18),)),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    color: Constants.backgroundMain,
                    onPressed: (){
                      currentIndex == 2 ? Navigator.of(context).pushReplacementNamed(LoginRoute) : _swiperController.next();

                    },
                    child: Text(currentIndex ==2 ? "Done" : "Next",style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final String title;
  final String image;

  const IntroItem({Key key, this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: Constants.backgroundMain,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
