import 'package:customer/MyCartLayout.dart';
import 'package:customer/Pages/FavouritePage.dart';
import 'package:customer/Pages/HomePage.dart';
import 'package:customer/Pages/OrderPage.dart';
import 'package:customer/Pages/ScheduledPage.dart';
import 'package:customer/Pages/SearchPage.dart';
import 'package:customer/Widgets/CustomPageRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  bool collapsed = false;
  double scale=1;

  String profileName='Anoop Benzier',profileNumber='9738738473';

  List<Widget> _pages = [HomePage(),SearchPage(),FavouritePage(),OrderPage(),ScheduledPage()];
  int _pageIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationDrawer(),
          drawerTabController(),
        ],
      ),
    );
  }

  Widget navigationDrawer(){
    return Container(
      decoration: BoxDecoration(gradient:  LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors: [ Theme.of(context).primaryColor,Theme.of(context).primaryColorDark,])),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: Image.asset("assets/profile.jpg").image,
                     ),
                    Container(margin:EdgeInsets.only(top:52.0,left: 52.0),width:30,height:30,decoration:BoxDecoration(shape: BoxShape.circle,color:globals.getColorFromHex('f6eedf') ),child: IconButton(icon:Icon(Icons.camera_alt,color: Theme.of(context).primaryColorDark),iconSize: 12,onPressed: (){
                      //change profile pic

                    })),
                ]),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    children:[
                      Text(profileName,style:TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 18,fontWeight: FontWeight.bold)),
                      SizedBox(height: 5,),
                      Text(profileNumber,style:TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 14,fontWeight: FontWeight.bold))
                    ])
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton.icon(icon:Icon(Icons.house_outlined,color:globals.getColorFromHex('f6eedf')),label:Text('Home',style: TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 17,fontWeight: FontWeight.bold)), onPressed: () {
                  setState(() {
                    _pageIndex=0;
                    collapsed=false;
                  });
                },),
                SizedBox(height: 10),
                FlatButton.icon(icon:Icon(Icons.search,color:globals.getColorFromHex('f6eedf')),label:Text('Search in ${globals.shopType}',style: TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 17,fontWeight: FontWeight.bold)), onPressed: () {
                  setState(() {
                    _pageIndex=1;
                    collapsed=false;
                  });
                },),
                SizedBox(height: 10),
                FlatButton.icon(icon:Icon(Icons.favorite_border,color:globals.getColorFromHex('f6eedf')), label:Text('Favourite Shops',style: TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 17,fontWeight: FontWeight.bold)), onPressed: () {
                  setState(() {
                    _pageIndex=2;
                    collapsed=false;
                  });
                },),
                SizedBox(height: 10),
                FlatButton.icon(icon:Icon(Icons.bookmark_border,color:globals.getColorFromHex('f6eedf')), label:Text('My Orders',style: TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 17,fontWeight: FontWeight.bold)), onPressed: () {
                  setState(() {
                    _pageIndex=3;
                    collapsed=false;
                  });
                }),
                SizedBox(height: 10),
                FlatButton.icon(icon:Icon(Icons.schedule_outlined,color:globals.getColorFromHex('f6eedf')), label:Text('Scheduled Orders',style: TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 17,fontWeight: FontWeight.bold)), onPressed: () {
                  setState(() {
                    _pageIndex=4;
                    collapsed=false;
                  });
                },)
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                SizedBox(width: 10),
                FlatButton.icon(icon:Icon(Icons.settings_rounded,color:globals.getColorFromHex('f6eedf')),label:Text('Settings',style: TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 17,fontWeight: FontWeight.bold)), onPressed: () {  },),
                Text('|',style: TextStyle(fontSize: 16,color:globals.getColorFromHex('f6eedf'),fontWeight: FontWeight.bold)),
                FlatButton.icon(icon:Icon(Icons.logout,color:globals.getColorFromHex('f6eedf')),label:Text('Log Out',style: TextStyle(color:globals.getColorFromHex('f6eedf'),fontSize: 17,fontWeight: FontWeight.bold)), onPressed: () {  },),
              ],)
          ],
        ),
      ),
    );
  }

  Widget drawerTabController(){
    return AnimatedContainer(
        duration: Duration(milliseconds: 350),
        curve: Curves.bounceOut,
        transform: Matrix4.translationValues(collapsed?globals.width/1.6:0,  collapsed ? 190 : 0, 0)..scale(collapsed?0.6:scale),
        child: Container(
            child:Scaffold(
              appBar: collapsed?null:AppBar(
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('Local Mart',style: TextStyle(color:globals.getColorFromHex('f6eedf'),fontWeight: FontWeight.bold,fontSize: 25,fontFamily:'PlayfairDisplay'),),
                actions: [
                        IconButton(icon: Icon(Icons.shopping_cart,color: globals.getColorFromHex('f6eedf')), onPressed: (){
                          Navigator.push(context, CustomPageRoute(curvedAnimation: Curves.fastLinearToSlowEaseIn,widget: MyCartLayout()));
                        }),
                ],
                leading: IconButton(icon: Icon(Icons.menu,color: globals.getColorFromHex('f6eedf')), onPressed: (){
                  setState(() {collapsed=true;});
                }),
              ),

              body: SingleChildScrollView(child: _pages[_pageIndex])

              ),
        )
    );
  }
}
