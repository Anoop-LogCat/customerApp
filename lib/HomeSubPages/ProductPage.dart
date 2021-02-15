
import 'dart:convert';

import 'package:customer/Model/CartModel.dart';
import 'package:customer/Model/ItemModel.dart';
import 'package:customer/Operations/CartOperations.dart';
import 'package:customer/Widgets/ItemCard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  List<ItemModel> _items = [];
  List<ItemModel> _noDis = [];
  List<String> _headerTitle=['Discount Offers','No Offers'];

  int incrementQuantity=0,decrementQuantity=0;

  String shopName,location;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void addItems() async{
    final prefs = await SharedPreferences.getInstance();
    if(_items.isNotEmpty||_noDis.isNotEmpty){_items.clear();_noDis.clear();}
    setState(() {
      _items.add(ItemModel(
          userid: "fsff",
          cartItemQuantity:prefs.containsKey('$location:$shopName:Nivia')?int.parse(CartModel.fromJson(json.decode(prefs.getString('$location:$shopName:Nivia'))).quantity):0,
          imageUrl: "https://upload.wikimedia.org/wikipedia/commons/6/65/Product_Photography.jpg",
          itemName:"Nivia",
          discount: 20,
          unit: "1 packet",
          price: 300));
      _items.add(ItemModel(
          userid: "fsff",
          cartItemQuantity:prefs.containsKey('$location:$shopName:Soap')?int.parse(CartModel.fromJson(json.decode(prefs.getString('$location:$shopName:Soap'))).quantity):0,
          imageUrl: "https://image.shutterstock.com/image-illustration/3d-collection-household-cleaning-products-260nw-237357382.jpg",
          itemName:"Soap",
          discount: 20,
          unit: "1 packet",
          price: 300));
      _noDis.add(ItemModel(
          userid: "fsff",
          cartItemQuantity:prefs.containsKey('$location:$shopName:colgate')?int.parse(CartModel.fromJson(json.decode(prefs.getString('$location:$shopName:colgate'))).quantity):0,
          imageUrl: "https://img.freepik.com/free-vector/beauty-skin-care-background_52683-728.jpg?size=626&ext=jpg",
          itemName:"colgate",
          discount: 0,
          unit: "1 packet",
          price: 300));
      _noDis.add(ItemModel(
          userid: "fsff",
          cartItemQuantity:prefs.containsKey('$location:$shopName:Nivia')?int.parse(CartModel.fromJson(json.decode(prefs.getString('$location:$shopName:Nivia'))).quantity):0,
          imageUrl: "https://img.freepik.com/free-vector/beauty-skin-care-background_52683-728.jpg?size=626&ext=jpg",
          itemName:"Nivia",
          discount: 0,
          unit: "1 packet",
          price: 300));
      _noDis.add(ItemModel(
          userid: "fsff",
          cartItemQuantity:prefs.containsKey('$location:$shopName:Nivia')?int.parse(CartModel.fromJson(json.decode(prefs.getString('$location:$shopName:Nivia'))).quantity):0,
          imageUrl: "https://img.freepik.com/free-vector/beauty-skin-care-background_52683-728.jpg?size=626&ext=jpg",
          itemName:"Nivia",
          discount: 0,
          unit: "1 packet",
          price: 300));
    });
  }

  @override
  void initState() {
    shopName = 'Ambika';
    location = 'Palakkad | Town';
    addItems();
    super.initState();
  }

  void _onRefresh() async{
    addItems();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          header: WaterDropHeader(),
          footer: CustomFooter(builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode == LoadStatus.failed){body = Text("Load Failed! Retry again!");}
            return Container(height: 55.0, child: Center(child:body));
          }),
          child:_items.isEmpty&&_noDis.isEmpty ? Text('no data'):ListView.builder(itemCount: _headerTitle.length,itemBuilder: (context, index) {
            return  StickyHeader(
              header: Container(height: 40.0, color: Colors.white,
                padding:EdgeInsets.only(left: 10,top: 10),alignment: Alignment.centerLeft,
                child: Text(_headerTitle[index],style:Theme.of(context).textTheme.headline5)
              ),
              content: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _headerTitle[index].compareTo("Discount Offers")==0?_items.length:_noDis.length,
                  itemBuilder: (contxt,indx){
                    return GestureDetector(
                        child: _headerTitle[index].compareTo("Discount Offers")==0?
                        ItemCard(itemModel: _items[indx],addItem: (){setState(() {_items[indx].cartItemQuantity=_items[indx].cartItemQuantity+1;});operationInCart(indx,true,true);},subItem: (){setState(() {_items[indx].cartItemQuantity=_items[indx].cartItemQuantity-1;});operationInCart(indx,true,false);},):
                        ItemCard(itemModel: _noDis[indx],addItem: (){setState(() {_noDis[indx].cartItemQuantity=_noDis[indx].cartItemQuantity+1;});operationInCart(indx,false,true);},subItem: (){setState(() {_noDis[indx].cartItemQuantity=_noDis[indx].cartItemQuantity-1;});operationInCart(indx,false,false);})
                    );
                  }
              ),
            );
          }, shrinkWrap: true)
      ),
    );
  }

  void operationInCart(int i,bool isDis,bool isSave){
    List<ItemModel> tempModel = isDis?_items:_noDis;
    int payMoney = tempModel[i].discount!=0?(tempModel[i].price-(tempModel[i].discount/100)*tempModel[i].price).ceil():tempModel[i].price;
    Map jsonData={
      'itemName':tempModel[i].itemName,
      'price'   :payMoney.toString(),
      'total':payMoney.toString(),
      'quantity':tempModel[i].unit.split(" ").first,
      'unit'    : tempModel[i].unit.split(" ").last
    };
     isSave?CartOperations.saveCart(context,location, shopName, tempModel[i].itemName, jsonData).then((value) {if(value.compareTo('NO_ACTION')==0){ Fluttertoast.showToast(msg: "only one shop at a time",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,timeInSecForIosWeb: 1);}}):
            CartOperations.deleteCart(context,location, shopName, tempModel[i].itemName, jsonData).then((value)  {if(value.compareTo('NO_ACTION')==0){ Fluttertoast.showToast(msg: "cart is empty",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,timeInSecForIosWeb: 1);}});
  }
}
