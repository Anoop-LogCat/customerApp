import 'package:customer/Model/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;

class HomeCategory extends StatelessWidget {
  final CategoryModel categoryModel;

  HomeCategory({this.categoryModel});

  @override
  Widget build(BuildContext context) {
      return Card(
        color: categoryModel.isSelected?Theme.of(context).primaryColor:Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        elevation: 0.5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0.0, right: 10.0),
                child: Icon(
                  categoryModel.icon,
                  color: categoryModel.isSelected?globals.getColorFromHex('f6eedf'):Colors.black,
                ),
              ),
              SizedBox(width: 5),
              Text(
                categoryModel.title,
                style: TextStyle(
                  color: categoryModel.isSelected?globals.getColorFromHex('f6eedf'):Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  letterSpacing: 1.0
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
      );
  }
}