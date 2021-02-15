import 'package:customer/Model/CartModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {

  final CartModel cartModel;

  final Function add,sub;

  CartCard({this.cartModel,this.add,this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children:[Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${cartModel.itemName}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                  SizedBox(height: 5,),
                  Text("( ${cartModel.price} / per ${cartModel.unit} )", style: TextStyle(color:Colors.black54,fontSize: 11)),
                  SizedBox(height: 5,),
                  Text('\u20B9 ${cartModel.totPrice}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,),),
                ],
              ),
              Spacer(),
              changeQuantityWidget(context),
              SizedBox(width: 10,)
            ],
          ),
            Divider()
          ]),
      );
  }

  Widget changeQuantityWidget(BuildContext context){
    return Container(
      child: Row(
        children: [
          Container(width:25,height: 25,decoration: BoxDecoration(shape: BoxShape.rectangle,border:Border.all(color: Theme.of(context).accentColor,width: 2)),child: IconButton(padding:EdgeInsets.only(right: 2),icon: Icon(Icons.remove,size: 17,color: Theme.of(context).primaryColorDark,), onPressed:sub)),
          SizedBox(width: 10),
          Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)),color:Theme.of(context).accentColor),
            child: Center(
              child:Text('${cartModel.quantity} ${cartModel.unit}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            ),
          ),
          SizedBox(width: 10),
          Container(width:25,height: 25,decoration: BoxDecoration(shape: BoxShape.rectangle,border:Border.all(color: Theme.of(context).accentColor,width: 2)),child: IconButton(padding:EdgeInsets.only(right: 2),icon: Icon(Icons.add,size: 17,color: Theme.of(context).primaryColorDark,), onPressed:add)),
        ],
      ),
    );
  }
}

