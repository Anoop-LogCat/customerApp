import 'package:customer/Model/MessageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';


class MessageWidget extends StatelessWidget {

  final MessageModel model;
  MessageWidget({this.model});
  @override
  Widget build(BuildContext context) {
    return !model.isFrom?
    Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor,shape: BoxShape.rectangle,borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),topRight: Radius.circular(20),topLeft: Radius.circular(20))),
            padding: EdgeInsets.only(top:20.0,bottom: 20.0,right:10,left: 20),
            child: Text(model.comment,maxLines:3,overflow:TextOverflow.ellipsis,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15,color: Colors.white)),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: CircleAvatar(maxRadius:12,backgroundImage: NetworkImageWithRetry(model.imageUrl)),
          ),
        ],
      ),
    )
    :Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(backgroundImage: NetworkImageWithRetry(model.imageUrl)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Text(model.senderName,style: Theme.of(context).textTheme.subhead),
               Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(model.comment),
              )
            ],
          )
        ],
      ),
    );
  }
}