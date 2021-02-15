import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;

class CartDialog{
  static void cartDialog(bool isShow,BuildContext context,String price,String itemCount,String shopName,String shopLocation,Function viewCart) {
    if(!isShow){
      Color textColor = globals.getColorFromHex('f6eedf');
      showBottomSheet(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColorDark,
          context: context,
          builder: (context) => Container(
              height: 60,
              width: globals.width,
              child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Padding(padding:EdgeInsets.only(left: 2),child: Text('NO CART ITEMS', style: new TextStyle(color:textColor,fontWeight: FontWeight.bold,fontSize: 15))),
                        SizedBox(width: 10,),
                        Icon(Icons.shopping_bag_outlined,color:textColor,)
                ],
              )
          ));
    }
    else{
      Color textColor = globals.getColorFromHex('f6eedf');
      showBottomSheet(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColorDark,
          context: context,
          builder: (context) => Container(
              height: 60,
              width: globals.width,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                          TextSpan(text: '\u20B9',style: TextStyle(color:textColor,fontWeight: FontWeight.bold, fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(text: ' $price', style: new TextStyle(color:textColor,fontWeight: FontWeight.bold,fontSize: 15)),
                              TextSpan(text: ' | ', style: new TextStyle(color:textColor,fontWeight: FontWeight.bold,fontSize: 15)),
                              TextSpan(text: ' $itemCount Items',style: TextStyle(color:textColor,fontWeight: FontWeight.bold, fontSize: 15))
                            ],
                          )),
                      SizedBox(height: 2,),
                      Text.rich(
                          TextSpan(text: 'From : ',style: TextStyle(color:textColor.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 10),
                            children: <TextSpan>[
                              TextSpan(text: shopName, style: new TextStyle(color:textColor.withOpacity(0.6),fontWeight: FontWeight.bold, fontSize: 10)),
                              TextSpan(text: ' $shopLocation',style: TextStyle(color:textColor.withOpacity(0.6),fontWeight: FontWeight.bold, fontSize: 10))
                            ],
                          )),
                    ],
                  ),
                  GestureDetector(
                    onTap: viewCart,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Text('VIEW CART', style: new TextStyle(color:textColor,fontWeight: FontWeight.bold,fontSize: 15)),
                          SizedBox(width: 10,),
                          Icon(Icons.shopping_bag_outlined,color:textColor,)
                        ]),
                  ),
                ],
              )
          ));
    }
  }
}