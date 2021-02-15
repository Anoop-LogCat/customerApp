
import 'package:customer/MapLayout.dart';
import 'package:customer/Widgets/CustomPageRoute.dart';
import 'package:customer/Widgets/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();

  final TextStyle heyTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22,
    letterSpacing: 0,
    wordSpacing: 0,
    color: Color(0XFF232444),
    decoration: TextDecoration.none,
  );

  final TextStyle welcomeTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30,
    letterSpacing: 0,
    color: Color(0XFF232444),
    decoration: TextDecoration.none,
  );

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            layout1(),
            localMartView(),
            layout2(),
            backButton(),
            otherLogin(),
          ],
        ),
      ),
    );
  }

  Widget layout1(){
    return Container(
      width: globals.width,
      height: globals.height,
      decoration: BoxDecoration(gradient: LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorDark])),
    );
  }
  Widget layout2(){
    return Transform(
      transform:Matrix4.translationValues(globals.width/5, 0, 0),
      child: Container(
        width: globals.width/1.2,
        height: globals.height/1.1,
        decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(100))),
        child: Container(margin: EdgeInsets.only(top: globals.height/7),padding: EdgeInsets.only(top:globals.height/5,left: 20,right: 30),child: fieldForm()),
      ),
    );
  }
  Widget backButton(){
    return Container(
        margin: EdgeInsets.only(left:10,top: 40),
        child:IconButton(icon: Icon(Icons.arrow_back_outlined,size: 30,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        })
    );
  }

  Widget welcomeText(){
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      width: 25.0,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("HEY,", style: heyTextStyle),
              Text("WELCOME", style: welcomeTextStyle),
            ],
          ),
        ],
      ),
    );

  }

  Widget fieldForm(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        welcomeText(),
        SizedBox(height: globals.height/10,),
        CustomTextField(
          textEditingController: _username,
          keyboardType: TextInputType.text,
          icon: Icons.person,
          hint: "user name",
        ),
        SizedBox(height: 20,),
        CustomTextField(
          textEditingController: _phone,
          keyboardType: TextInputType.number,
          icon: Icons.phone,
          hint: "phone number",
        ),
        SizedBox(height: 20,),
        RaisedButton(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () {
            Navigator.push(context, CustomPageRoute(curvedAnimation: Curves.decelerate,widget: MapLayout()));
          },
          textColor: Colors.white,
          padding: EdgeInsets.all(0.0),
          child: Container(
            alignment: Alignment.center,
            width: globals.large? globals.width/6 : (globals.medium? globals.width/3: globals.width/2.2),
            height: globals.height/20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Theme.of(context).accentColor
            ),
            child: Text('Sign up',style: TextStyle(fontSize: 20,color:Colors.black,fontWeight: FontWeight.bold),),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget localMartView(){
    return Container(
      margin: EdgeInsets.only(top: globals.height/7,left: globals.width/25),
      child: Column(
        children: [
          Text('L',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text('O',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text('C',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text('A',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text('L',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text(' ',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text('M',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text('A',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text('R',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
          Text('T',style:TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.6), fontWeight: FontWeight.w900, fontSize: 50)),
        ],
      ),
    );
  }

  Widget otherLogin(){
    return Container(
      margin: EdgeInsets.only(top: globals.height/1.08,left: globals.width/5,right: 10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Also Sign in With',style: TextStyle(fontSize: 15,color:globals.getColorFromHex('f6eedf'),fontWeight: FontWeight.bold),),

          //google icon

          Container(
            decoration: BoxDecoration(color: globals.getColorFromHex('f6eedf'),shape: BoxShape.circle),
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10.0),
            child: Container(width: 20, height: 20,decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/google.png'),fit: BoxFit.cover))),
          ),

          //facebook icon

          Container(
            decoration: BoxDecoration(color: globals.getColorFromHex('f6eedf'),shape: BoxShape.circle),
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10.0),
            child: Container(width: 20, height: 20,decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/facebook.png'),fit: BoxFit.cover))),
          ),

          //twitter icon

          Container(
            decoration: BoxDecoration(color: globals.getColorFromHex('f6eedf'),shape: BoxShape.circle),
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10.0),
            child: Container(width: 20, height: 20,decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/twitter.png'),fit: BoxFit.cover))),
          ),
        ],
      ),
    );
  }
}
