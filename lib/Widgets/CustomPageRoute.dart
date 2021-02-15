import 'package:flutter/cupertino.dart';

class CustomPageRoute extends PageRouteBuilder{
  final Widget widget;
  final Curve curvedAnimation;
  CustomPageRoute({this.widget,this.curvedAnimation}):super(
      transitionDuration: Duration(milliseconds: 750),
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,Animation<double> setAnimation,
          Widget child){
        animation=CurvedAnimation(parent: animation,curve: curvedAnimation);
        return ScaleTransition(alignment:Alignment.bottomCenter,scale: animation,child: child);
      },pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> setAnimation){
    return widget;
  });
}