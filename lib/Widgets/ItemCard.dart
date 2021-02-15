import 'package:customer/Model/ItemModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;
import 'package:flutter_image/network.dart';

class ItemCard extends StatelessWidget {

  final ItemModel itemModel;
  final Function addItem,subItem;
  ItemCard({this.itemModel,this.addItem,this.subItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Container(
                    height: globals.height/6.9,width: globals.width/5.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: itemModel.imageUrl.compareTo("no image")==0?AssetImage("assets/shop.png"):NetworkImageWithRetry(itemModel.imageUrl)
                        )
                    ),
                  )
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 5),
                      child: Text(itemModel.itemName, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17,),),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12,top: 5),
                        child:Row(children:[
                          Text("${itemModel.unit}", style: TextStyle(fontSize: 14,color: Colors.black54)),
                          Text(itemModel.discount==0?"":"  (${itemModel.discount} % off)", style: TextStyle( fontSize: 14,color: Colors.redAccent)),
                        ])
                    ),
                    itemModel.discount!=0?Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8,),
                      child: Text.rich(TextSpan(text: '\u20B9',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                        children: <TextSpan>[
                          TextSpan(text: ' ${itemModel.price}', style: new TextStyle(color:Colors.black54,fontSize: 13, decoration: TextDecoration.lineThrough)),
                          TextSpan(text: ' ${(itemModel.price-(itemModel.discount/100)*itemModel.price).ceil()}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23))
                        ],
                      )),
                    ):
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8,),
                      child:Text("\u20B9 ${itemModel.price}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23,)),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                  child:Column(
                    children: [
                      Container(width:30,height: 30,decoration: BoxDecoration(shape: BoxShape.rectangle,border:Border.all(color: Theme.of(context).accentColor,width: 2)),child: IconButton(padding:EdgeInsets.only(right: 1),icon: Icon(Icons.add,size: 17,color: Theme.of(context).primaryColorDark,), onPressed: addItem)),
                      SizedBox(height: 5,),
                      itemModel.cartItemQuantity<=0?SizedBox(height: 1,): Text(itemModel.cartItemQuantity.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColorDark),),
                      SizedBox(height: 5,),
                      Container(width:30,height: 30,decoration: BoxDecoration(shape: BoxShape.rectangle,border:Border.all(color: Theme.of(context).accentColor,width: 2)),child: IconButton(padding:EdgeInsets.only(right: 1),icon: Icon(Icons.remove,size: 17,color:  Theme.of(context).primaryColorDark,), onPressed: subItem))
                    ],
                  ) ),
            ],
          ),
        ),
    );
  }
}
