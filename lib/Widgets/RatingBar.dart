import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {

  final int number;
  RatingBar({this.number});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context,index){
            return number<=index?Icon(Icons.star,color: Colors.grey[300]):Icon(Icons.star,color: Theme.of(context).accentColor);
          }),
      );
  }
}
