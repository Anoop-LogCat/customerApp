import 'package:customer/Model/MessageModel.dart';
import 'package:customer/Widgets/MesageWidget.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  TextEditingController textEditingController = new TextEditingController();
  List<MessageModel> _messages= [];
  
  void addComments(){
    if(_messages.isNotEmpty){_messages.clear();}
    _messages.add(MessageModel(
        isFrom:true,
        imageUrl: "https://storage.pixteller.com/designs/designs-images/2016-11-19/02/thumbs/img_page_1_58305b35ebf5e.png",
        senderName: "Admin",
        comment: "Hello super retailer shop now"
    ));
    _messages.add(MessageModel(
        isFrom:true,
        imageUrl: "https://storage.pixteller.com/designs/designs-images/2016-11-19/02/thumbs/img_page_1_58305b35ebf5e.png",
        senderName: "Admin",
        comment: "Hello super retailer shop now"
    ));
    _messages.add(MessageModel(
        isFrom:true,
        imageUrl: "https://storage.pixteller.com/designs/designs-images/2016-11-19/02/thumbs/img_page_1_58305b35ebf5e.png",
        senderName: "Admin",
        comment: "Hello super retailer shop now"
    ));
    _messages.add(MessageModel(
        isFrom:true,
        imageUrl: "https://storage.pixteller.com/designs/designs-images/2016-11-19/02/thumbs/img_page_1_58305b35ebf5e.png",
        senderName: "Admin",
        comment: "Hello super retailer shop now"
    ));
  }
  @override
  void initState() {
    addComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
        children: <Widget>[
          Flexible(
            child:  ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder:(_,int index)=>MessageWidget(model: _messages[index]),
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0,),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _textComposerWidget(),
          )
        ],
      )
    );
  }

  void _handleSubmit(String text) {
    textEditingController.clear();
    if(text.isNotEmpty) {
      setState(() {
        _messages.insert(0, MessageModel(
            isFrom: false,
            imageUrl: "https://storage.pixteller.com/designs/designs-images/2016-11-19/02/thumbs/img_page_1_58305b35ebf5e.png",
            senderName: "Now Sender",
            comment: text
        ));
      });
    }
}

  Widget _textComposerWidget() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.black),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Enter your comment"),
                controller: textEditingController,
                onSubmitted: _handleSubmit,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send,color: Theme.of(context).primaryColorDark,),
                onPressed: () => _handleSubmit(textEditingController.text),
              ),
            )
          ],
        ),
      ),
    );
  }
}
