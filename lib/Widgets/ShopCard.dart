import 'package:customer/Model/ShopModel.dart';
import 'package:customer/Widgets/RatingBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;
import 'package:flutter_image/network.dart';

class ShopCard extends StatelessWidget {

  final ShopModel shopCard;
  final Function favFunction;
  ShopCard({this.shopCard,this.favFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children:[
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          height: globals.height/9.7,width: globals.width/5.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImageWithRetry(shopCard.imageUrl)
                              )
                          ),
                        ),
                      )
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(shopCard.shopName, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                          child:Text(shopCard.distance, style: TextStyle(fontSize: 14,color: Colors.grey[300])),

                        ),
                        RatingBar(number:shopCard.rating),
                      ],
                    ),
                    ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(color: Theme.of(context).accentColor,shape: BoxShape.circle),
                      child: IconButton(icon: Icon(Icons.favorite,color: shopCard.isFAav?Theme.of(context).primaryColorDark:Colors.black),iconSize: 15, onPressed:favFunction),
                    ),
                  )
                ],
              ),
              Divider()
            ]
          ),
        );
  }
}
