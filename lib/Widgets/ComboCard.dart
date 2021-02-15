import 'package:customer/Model/ComboModel.dart';
import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;
import 'package:flutter/widgets.dart';
import 'package:flutter_image/network.dart';
import 'package:random_color/random_color.dart';

class ComboCard extends StatelessWidget {

  final ComboModel comboModel;
  final Function click;
  Color _color = RandomColor().randomColor(colorHue: ColorHue.yellow,colorSaturation: ColorSaturation.highSaturation,colorBrightness: ColorBrightness.dark).withOpacity(0.2);

  ComboCard({this.comboModel,this.click});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child:  comboContent(),
    );
  }

  Widget comboContent(){
    return GestureDetector(
      onTap:click,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
                  Container(
                    height: globals.height/7.4,width: globals.width/4.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: comboModel.imageUrl.compareTo("no image")==0?AssetImage("assets/small_shots_slider.png"):NetworkImageWithRetry(comboModel.imageUrl)
                        )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(comboModel.title, style:  TextStyle(fontWeight: FontWeight.w800, fontSize: 16,), maxLines: 3, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 5,),
                      Text(comboModel.description,style: TextStyle(fontSize: 13,color: Colors.black54), maxLines: 3, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 10,),
                      comboModel.discount!=0?Text.rich(TextSpan(text: '\u20B9',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                        children: <TextSpan>[
                          TextSpan(text: ' ${comboModel.price}', style: new TextStyle(color:Colors.black54,fontSize: 13, decoration: TextDecoration.lineThrough)),
                          TextSpan(text: ' ${(comboModel.price-(comboModel.discount/100)*comboModel.price).ceil()}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23))
                        ],
                      )): Text("\u20B9 ${comboModel.price}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)),
                    ],
                  ),
            Stack(children:[Container(margin:EdgeInsets.only(left: 20),child: Text(comboModel.discount==0?"":"${comboModel.discount}% off",style:TextStyle(color: _color,fontWeight: FontWeight.w900,fontSize: 16),)),Container(margin:EdgeInsets.only(top: 3),child: Icon(Icons.shopping_cart,color:_color,size: 90,))]),
      ]),
      ),
    );
  }
}
