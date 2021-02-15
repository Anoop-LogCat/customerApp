import 'package:flutter/material.dart';

class ComboModel {
  String title, description,imageUrl;
  int price,discount;

  ComboModel(
      {this.title,
        this.description,
        this.discount,
        this.imageUrl,
        this.price});

  ComboModel.fromJson(Map json)
  {
    this.title=json['comboName'];
    this.imageUrl=json['imageUrl'];
    this.description=json['descrip'];
    this.discount=json['discount'];
    this.price=json['price'];
  }
}