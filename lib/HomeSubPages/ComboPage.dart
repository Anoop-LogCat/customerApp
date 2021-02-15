import 'package:customer/Model/ComboModel.dart';
import 'package:customer/Widgets/ComboCard.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:random_color/random_color.dart';

class ComboPage extends StatefulWidget {
  @override
  _ComboPageState createState() => _ComboPageState();
}

class _ComboPageState extends State<ComboPage> {

  List<ComboModel> listCombo=[];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void addCombo(){
    if(listCombo.isNotEmpty){listCombo.clear();}
    listCombo.add(ComboModel(
        title: "Onam Discount Mela",
        imageUrl: "https://image.freepik.com/free-vector/food-ad-template-burger_23-2148449854.jpg",
        discount: 20,
        description:"buy one get one free",
        price: 300));
    listCombo.add(ComboModel(
        title: "Onam Discount Mela",
        imageUrl: "https://image.freepik.com/free-vector/food-ad-template-burger_23-2148449854.jpg",
        discount: 40,
        description:"buy one get one free",
        price: 250,));
    listCombo.add(ComboModel(
        title: "Onam Discount Mela",
        discount: 15,
        imageUrl: "https://image.freepik.com/free-vector/food-ad-template-burger_23-2148449854.jpg",
        description:"buy one get one free",
        price: 546,));
    listCombo.add(ComboModel(
        title: "Onam Discount Mela",
        imageUrl: "https://image.freepik.com/free-vector/food-ad-template-burger_23-2148449854.jpg",
        discount: 60,
        description:"buy one get one free",
        price: 500,));
  }

  @override
  void initState() {
    addCombo();
    super.initState();
  }

  void _onRefresh() async{
    addCombo();
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
        child:listCombo.isEmpty?Text('no data'):ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount:listCombo.length,
          itemBuilder: (context,index) {
            return Padding(padding:EdgeInsets.all(5),child: ComboCard(comboModel: listCombo[index]));
          },
        ),
      ),
    );
  }
}
