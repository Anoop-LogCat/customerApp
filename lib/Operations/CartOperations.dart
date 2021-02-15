import 'dart:convert';

import 'package:customer/Model/CartModel.dart';
import 'package:customer/MyCartLayout.dart';
import 'package:customer/Widgets/CartDialog.dart';
import 'package:customer/Widgets/CustomPageRoute.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartOperations{
  static String cartShopName,cartShopLocation;
  static Future<String> saveCart(BuildContext context,String location,String shopName,String itemName,Map jsonCartData) async {
    final prefs = await SharedPreferences.getInstance();
    Set<String> keys= prefs.getKeys();
    int price=0;
    if(keys.isNotEmpty) {
      keys.forEach((element) =>price = price+int.parse(CartModel.fromJson(json.decode(prefs.getString(element))).totPrice));
      for (String key in keys) {
        if( key.split(':')[1].compareTo(shopName) == 0&&key.split(':')[2].compareTo(itemName) == 0){
          int _quantity = int.parse(CartModel.fromJson(json.decode(prefs.getString(key))).quantity);
          int _totPrice = int.parse(CartModel.fromJson(json.decode(prefs.getString(key))).totPrice);
          int _pri = int.parse(CartModel.fromJson(json.decode(prefs.getString(key))).price);
          jsonCartData['quantity'] = (_quantity+1).toString();
          jsonCartData['total']=(_totPrice + _pri).toString();
          if(context!=null){
            prefs.setString('$location:$shopName:$itemName', json.encode(jsonCartData));
            CartDialog.cartDialog(true,context, (price+int.parse(jsonCartData['price'])).toString(), prefs.getKeys().length.toString(), shopName, location,(){
              Navigator.push(context, CustomPageRoute(curvedAnimation: Curves.fastLinearToSlowEaseIn,widget: MyCartLayout()));
            });
          }
          return 'ADDED';
        }
      }
      for (String key in keys) {
        if( key.split(':')[1].compareTo(shopName) == 0&&key.split(':')[2].compareTo(itemName) != 0){
          prefs.setString('$location:$shopName:$itemName', json.encode(jsonCartData));
          if(context!=null){
            CartDialog.cartDialog(true,context, (price+int.parse(jsonCartData['price'])).toString(), prefs.getKeys().length.toString(), shopName, location,(){
              Navigator.push(context, CustomPageRoute(curvedAnimation: Curves.fastLinearToSlowEaseIn,widget: MyCartLayout()));
            });
          }
          return 'ADDED';
        }
      }
      return 'NO_ACTION';
    }
    else{
      if(context!=null){
        prefs.setString('$location:$shopName:$itemName', json.encode(jsonCartData));
        CartDialog.cartDialog(true,context, jsonCartData['price'].toString(), prefs.getKeys().length.toString(), shopName, location,(){
          Navigator.push(context, CustomPageRoute(curvedAnimation: Curves.fastLinearToSlowEaseIn,widget: MyCartLayout()));
        });
      }
      return 'ADDED';
    }
  }

  static Future<String> deleteCart(BuildContext context,String location,String shopName,String itemName,Map jsonCartData) async {
    final prefs = await SharedPreferences.getInstance();
    Set<String> keys= prefs.getKeys();
    int price=0;
    try{
      if(keys.isNotEmpty) {
        keys.forEach((element) =>price = price+int.parse(CartModel.fromJson(json.decode(prefs.getString(element))).totPrice));
        for (String key in keys) {
          int _quantity = int.parse(CartModel.fromJson(json.decode(prefs.getString(key))).quantity);
          int _totPrice = int.parse(CartModel.fromJson(json.decode(prefs.getString(key))).totPrice);
          int _pri = int.parse(CartModel.fromJson(json.decode(prefs.getString(key))).price);
          if( key.split(':')[1].compareTo(shopName) == 0&&key.split(':')[2].compareTo(itemName) == 0&&_quantity!=1){
            jsonCartData['quantity'] = (_quantity-1).toString();
            jsonCartData['total_price']=(_totPrice - _pri).toString();
            if(context!=null){
              prefs.setString('$location:$shopName:$itemName', json.encode(jsonCartData));
              CartDialog.cartDialog(true,context, (price-int.parse(jsonCartData['price'])).toString(), prefs.getKeys().length.toString(), shopName, location,(){
                Navigator.push(context, CustomPageRoute(curvedAnimation: Curves.fastLinearToSlowEaseIn,widget: MyCartLayout()));
              });
            }
            return 'REMOVED';
          }
        }
        for (String key in keys) {
          int _quantity = int.parse(CartModel.fromJson(json.decode(prefs.getString(key))).quantity);
          if( key.split(':')[1].compareTo(shopName) == 0&&key.split(':')[2].compareTo(itemName) == 0&&_quantity==1){
            prefs.remove(key);
            if(context!=null){
              if(prefs.getKeys().length!=0) {CartDialog.cartDialog(true,context, (price-(jsonCartData['price'])).toString(), prefs.getKeys().length.toString(), shopName, location,(){
                Navigator.push(context, CustomPageRoute(curvedAnimation: Curves.fastLinearToSlowEaseIn,widget: MyCartLayout()));
              });}
              else{CartDialog.cartDialog(false,context, (jsonCartData['total']).toString(), prefs.getKeys().length.toString(), shopName, location,(){
                Navigator.push(context, CustomPageRoute(curvedAnimation: Curves.fastLinearToSlowEaseIn,widget: MyCartLayout()));
              });}
            }
            return 'REMOVED';
          }
        }
      }
    }catch(e){

    }

    return 'NO_ACTION';
  }

  static Future<List<CartModel>> readCart() async {
    List<CartModel> cartItemList=[];
    final prefs = await SharedPreferences.getInstance();
    Set<String> keys= prefs.getKeys();
    if(keys.isNotEmpty) {
      for (String key in keys) {
        cartShopLocation=key.split(':').first;cartShopName=key.split(':')[1];
        cartItemList.add(CartModel.fromJson(json.decode(prefs.getString(key))));
      }
      return cartItemList;
    }
    return null;
  }
}