import 'dart:io';

import 'package:customer/LogIn.dart';
import 'package:customer/MainMenu.dart';
import 'package:customer/SignIn.dart';
import 'package:customer/Widgets/CustomPageRoute.dart';
import 'package:customer/Widgets/ResponsiveWidget.dart';
import 'package:customer/Widgets/SliderWidget.dart';
import 'package:customer/storage/globals.dart'as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingApp()
  ));
}

class SettingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Fluttertoast.showToast(msg: 'Failed', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1);
          return Scaffold(body: Container(),);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              title: 'Local Mart',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                backgroundColor: Colors.white,
                primaryColor:globals.getColorFromHex('f57b51'),
                primaryColorDark:globals.getColorFromHex('d63447'),
                accentColor:globals.getColorFromHex('ffd31d'),
                textTheme: TextTheme(
                  headline5: TextStyle(fontSize: 23,fontWeight: FontWeight.w900,color:globals.getColorFromHex('f57b51'),letterSpacing: 2.0),
                  bodyText2: TextStyle(fontSize: 13,color: Colors.black)
                )
              ),
              home:WelcomeScreen(title: 'Local Mart Welcome Page'),
          );
        }
        return Scaffold(body: Container(),);
      },
    );
  }

}

class WelcomeScreen extends StatefulWidget {

  WelcomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  User _user = FirebaseAuth.instance.currentUser;

  Future<void> getUser()async{
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if(_user!=null){
          globals.user=_user;
          Navigator.pushAndRemoveUntil(context, CustomPageRoute(widget:MainMenu(),curvedAnimation:Curves.easeInOutBack), (Route<dynamic>route) => false);
        }
        else{
          Navigator.pushAndRemoveUntil(context, CustomPageRoute(widget:FirstEntry(),curvedAnimation:Curves.easeInOutBack), (Route<dynamic>route) => false);
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No internet Connection",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,timeInSecForIosWeb: 1);
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    globals.height = MediaQuery.of(context).size.height;
    globals.width = MediaQuery.of(context).size.width;
    globals.pixelRatio = MediaQuery.of(context).devicePixelRatio;
    globals.large =  ResponsiveWidget.isScreenLarge(globals.width, globals.pixelRatio);
    globals.medium =  ResponsiveWidget.isScreenMedium(globals.width, globals.pixelRatio);
    globals.small =  ResponsiveWidget.isScreenSmall(globals.width, globals.pixelRatio);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
  Widget splashScreen(){
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text("LM",style: TextStyle(shadows: [Shadow(offset: Offset(5,0), blurRadius: 3.0, color: Theme.of(context).accentColor),],letterSpacing:7.0,fontSize: 70,fontFamily:'PlayfairDisplay',fontWeight: FontWeight.w900),),
                Text("shop from your surroundings",style: TextStyle(fontWeight:FontWeight.w600,letterSpacing:2.0,fontSize: 10,fontFamily:'PlayfairDisplay'),),
               SizedBox(height: globals.height/30,),
                SpinKitFadingCircle(color: Colors.black, size: 50.0,)
              ])
      ),
    );
  }
}

class FirstEntry extends StatefulWidget {
  @override
  _FirstEntryState createState() => _FirstEntryState();
}

class _FirstEntryState extends State<FirstEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget> [
            Expanded(flex:40,child: SliderWidget()),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Expanded(flex: 4,
                    child: RaisedButton(child:Padding(
                      padding: const EdgeInsets.fromLTRB(30,10,30,10),
                      child: Text('Create Account',style: TextStyle(fontSize:17.0,fontWeight:FontWeight.bold,color: Colors.white,)),
                    ),onPressed: (){
                      Navigator.push(context, CustomPageRoute(widget: SignIn(),curvedAnimation: Curves.elasticInOut));
                    },color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 5,),
                  Expanded(flex: 3,
                    child: FlatButton(
                        child: Text('Already have an Account ?',style: TextStyle(fontSize:14.0,fontWeight:FontWeight.bold,color:Theme.of(context).primaryColor),),
                        onPressed: (){
                          Navigator.push(context, CustomPageRoute(widget: LogIn(),curvedAnimation: Curves.elasticInOut));
                        },color: Colors.white),
                  ),
                  Expanded(flex:2,child: Padding(padding:EdgeInsets.fromLTRB(0, 4, 4, 0),child: Text('shop from your surroundings',style: TextStyle(letterSpacing:1.0,fontWeight:FontWeight.bold,fontFamily: 'Montserrat-Bold.ttf',fontSize: 10.0,color: Colors.grey[800])))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

