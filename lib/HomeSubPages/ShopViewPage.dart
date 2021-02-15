import 'package:customer/HomeSubPages/ComboPage.dart';
import 'package:customer/HomeSubPages/CommentPage.dart';
import 'package:customer/HomeSubPages/ProductPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image/network.dart';

class ShopViewPage extends StatefulWidget {
  @override
  _ShopViewPageState createState() => _ShopViewPageState();
}

class _ShopViewPageState extends State<ShopViewPage> {

  String _imageUrl = "https://image.freepik.com/free-vector/food-ad-template-burger_23-2148449854.jpg";
  Color _primary;
  Color _buttonBack;
  Color _timeText;

// get the retailer shop from the globals list

  @override
  Widget build(BuildContext context) {
    _buttonBack = Theme.of(context).primaryColor;
    _timeText = Colors.black54;
    _primary = Colors.black;
    return Scaffold(
      backgroundColor:  Theme.of(context).backgroundColor,
       body:content()
    );
  }

  Widget content (){
    return  DefaultTabController(
      length: 3,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 345.0,
                pinned: true,
                floating: false,
                automaticallyImplyLeading: true,
                backgroundColor: Theme.of(context).backgroundColor,
                title: Text("AMBIKA", style: TextStyle( fontWeight: FontWeight.bold,color:Colors.black,fontSize: 25.0,fontFamily:'PlayfairDisplay', letterSpacing: 1.2)),
                centerTitle: true,
              flexibleSpace:FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Stack(
                          children:[
                            Container(
                            height: 210.0,
                            decoration: new BoxDecoration(
                              color: _buttonBack,
                              boxShadow: [BoxShadow(blurRadius: 40.0,color: _buttonBack)],
                              borderRadius: new BorderRadius.vertical(bottom: new Radius.elliptical(MediaQuery.of(context).size.width, 100.0))),
                            ),
                            Container(
                                margin: EdgeInsets.only(left:50.0,right:50.0,top: 125),
                                height: 160.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(fit: BoxFit.fill,image: NetworkImageWithRetry(_imageUrl)),
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [BoxShadow(blurRadius: 20.0,color: _buttonBack)],
                                    border:Border.all(color:Colors.white,width: 5),
                                ),
                              ),
                            Align(
                                alignment: Alignment.center,
                                child: Column(
                                    children: [
                                      SizedBox(height: 80),
                                      RichText(text: TextSpan(
                                          children: [
                                            TextSpan(text: "Open Time ", style: Theme.of(context).textTheme.bodyText1.copyWith(color: _timeText)),
                                            WidgetSpan(child:Icon(Icons.timer, color: _timeText, size: 15,)),
                                            TextSpan(text: ' 9:30 am',style: Theme.of(context).textTheme.bodyText1.copyWith(color: _timeText),),
                                            WidgetSpan(child: Icon(Icons.timer_off, color: _timeText, size: 15)),
                                            TextSpan(text: ' 10:30 pm', style: Theme.of(context).textTheme.bodyText1.copyWith(color: _timeText),
                                            )])),
                                      SizedBox(height: 3,),
                                      Text("Palakkad | Town",style: Theme.of(context).textTheme.bodyText1.copyWith(color: _timeText)),
                                ]),
                              ),
                        ]),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Theme.of(context).accentColor,
                                  shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40,0,40,0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.star_border,color:_primary,),
                                    Text("0",style: TextStyle(letterSpacing:1.0,fontSize: 12.0,color: _primary))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Theme.of(context).accentColor,
                                  shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(18,0,18,0),
                                child: GestureDetector(
                                    onTap: (){
                                       // contact details of each shop
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.phone_enabled_outlined,color: _primary),
                                        Text('Contact Us',style: TextStyle(letterSpacing:1.0,fontSize: 12.0,color: _primary))
                                      ],
                                    )
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Theme.of(context).accentColor,
                                  shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(18,0,18,0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.shopping_cart_outlined,color: _primary,),
                                    Text("Super Mart",style: TextStyle(letterSpacing:1.0,fontSize: 12.0,color: _primary))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor:Theme.of(context).accentColor,
                    tabs: [
                      Tab(child:Column(children:[SizedBox(height: 2),Icon(Icons.shopping_cart,color: Theme.of(context).primaryColor),SizedBox(height: 2,),Text('Products',style: TextStyle(fontSize: 13.0,color: Theme.of(context).primaryColor))])),
                      Tab(child: Column(children:[SizedBox(height: 2),Icon(Icons.verified_user,color: Theme.of(context).primaryColor),SizedBox(height: 2,),Text('Combo Offers',style: TextStyle(fontSize: 13.0,color: Theme.of(context).primaryColor))])),
                      Tab(child: Column(children:[SizedBox(height: 2),Icon(Icons.comment,color: Theme.of(context).primaryColor),SizedBox(height: 2,),Text('Comments',style: TextStyle(fontSize: 13.0,color: Theme.of(context).primaryColor))])),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: itemView()
      ),
    );
  }

  Widget itemView(){
    return TabBarView(
      physics: ScrollPhysics(),
      children: [
        Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body:ProductPage()
        ),
        Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body:ComboPage()
        ),
        Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: CommentPage()
        )
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {

  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => 63;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 60,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
