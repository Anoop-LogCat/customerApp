import 'package:customer/Model/CartModel.dart';
import 'package:customer/Operations/CartOperations.dart';
import 'package:customer/Widgets/CartCard.dart';
import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;

class MyCartLayout extends StatefulWidget {
  @override
  _MyCartLayoutState createState() => _MyCartLayoutState();
}

class _MyCartLayoutState extends State<MyCartLayout> {

  List<CartModel> _cartModel=[];
  String _shop="",_location="";
  int totalPrice=0;

  @override
  void initState() {
    super.initState();
    _addData();
  }

  Future<void> _addData() async{
    if(_cartModel.isNotEmpty){
      _cartModel.clear();
    }
    CartOperations.readCart().then((value) {
        if(value!=null){
        setState(() {
          _shop=CartOperations.cartShopName;
          _location=CartOperations.cartShopLocation;
          _cartModel=value;
        });
        _cartModel.forEach((element) => totalPrice = totalPrice+int.parse(element.totPrice));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
          child: _cartModel.isEmpty?Center(child: Text('no cart items',style: TextStyle(color: Colors.black))):Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                     color: Colors.white,
                     padding: EdgeInsets.only(left: 20,top: globals.height/19),
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Container(width:70,height:70,decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(10.0)),image:DecorationImage(image: AssetImage('assets/profile.jpg'),fit: BoxFit.cover))),
                                 SizedBox(width: 10,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(_shop,style: TextStyle(letterSpacing: 1.0,fontSize: 20,color: Colors.black)),
                                     Text(_location,style: TextStyle(letterSpacing: 1.0,fontSize: 14,color: Colors.black54)),
                                   ],
                                 ),
                               ],
                             ),
                           ListView.builder(itemCount: _cartModel.length,itemBuilder: (BuildContext context,int index){
                             return CartCard(cartModel:_cartModel[index],add:(){
                               setState(() {
                                 _cartModel[index].quantity = (int.parse(_cartModel[index].quantity)+1).toString();
                                 _cartModel[index].totPrice = (int.parse(_cartModel[index].totPrice) + int.parse(_cartModel[index].price)).toString();
                               });
                                operationInCart(index,true);
                             },sub:(){
                               operationInCart(index,false);
                               if(int.parse(_cartModel[index].quantity)==1){setState(() {_cartModel.removeAt(index);});}
                               else{
                                 setState(() {
                                   _cartModel[index].quantity=(int.parse(_cartModel[index].quantity)-1).toString();
                                   _cartModel[index].totPrice=(int.parse(_cartModel[index].totPrice) - int.parse(_cartModel[index].price)).toString();
                                 });
                               }
                             });
                           },shrinkWrap: true,physics: ScrollPhysics(),),
                           SizedBox(height: 30,),
                         ],
                       ),
                     ),
                   ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(bottom: 5,top: 7),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text.rich(TextSpan(text: 'Total price : ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(text: '\u20B9 ', style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                            TextSpan(text: totalPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                          ],
                        )),
                        FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            height: 50,
                            minWidth:globals.width/2.3,onPressed: (){},color: Theme.of(context).primaryColor, child:Text('Order',style: TextStyle(letterSpacing:1.0,fontSize: 16,color: Colors.white),))
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  void operationInCart(int i,bool isSave){
    Map jsonData={
      'itemName':_cartModel[i].itemName,
      'price'   :_cartModel[i].price,
      'total':_cartModel[i].totPrice,
      'quantity':_cartModel[i].quantity,
      'unit'    : _cartModel[i].unit
    };
    isSave?CartOperations.saveCart(null,_location, _shop, _cartModel[i].itemName, jsonData):
    CartOperations.deleteCart(null,_location, _shop, _cartModel[i].itemName, jsonData);
  }
}
