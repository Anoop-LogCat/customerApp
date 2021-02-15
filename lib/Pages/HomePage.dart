import 'package:customer/Model/CategoryModel.dart';
import 'package:customer/Model/ShopModel.dart';
import 'package:customer/HomeSubPages/ShopViewPage.dart';
import 'package:customer/Widgets/CustomPageRoute.dart';
import 'package:customer/Widgets/HomeCategory.dart';
import 'package:customer/Widgets/ShopCard.dart';
import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;
import 'package:flutter_image/network.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CategoryModel> _allShopType=[];
  List<ShopModel> _shops=[];
  List<String> _offer=[];

  // get the retailer shop informations and store in globals list

  @override
  void initState() {
    super.initState();
    _allShopType.add(CategoryModel(true, Icons.edit, "Stationary"));
    _allShopType.add(CategoryModel(false, Icons.local_hospital_outlined, "Medical"));
    _allShopType.add(CategoryModel(false, Icons.fastfood, "Restaurant"));
    _allShopType.add( CategoryModel(false, Icons.bakery_dining, "Bakery"));
    _allShopType.add(CategoryModel(false, Icons.shopping_cart, "Super Mart"));
    _allShopType.add(CategoryModel(false, Icons.shopping_cart, "Vegetables"));
    _allShopType.add(CategoryModel(false, Icons.sports_baseball_outlined, "Sports"));
    globals.shopType="Stationary";

    addShops();
    addOffer();
  }

  void addOffer(){
    if(_offer.isNotEmpty){_offer.clear();}
    _offer.add("https://image.freepik.com/free-vector/food-ad-template-burger_23-2148449854.jpg");
    _offer.add("https://image.freepik.com/free-vector/grand-opening-background-flat-style_23-2148246315.jpg");
    _offer.add("https://image.freepik.com/free-vector/black-friday-sale-advertisement-background_1055-8951.jpg");
  }

  void addShops(){
    if(_shops.isNotEmpty){_shops.clear();}
    _shops.add( ShopModel(isFAav:false,imageUrl:"https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60",
        shopName:"${globals.shopType} shop 1",distance:"around 3 km",rating:3));
    _shops.add(ShopModel(isFAav:true,imageUrl:"https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60",
        shopName:"${globals.shopType} shop 3",distance:"around 2 km",rating:4));
    _shops.add(ShopModel(isFAav:false,imageUrl:"https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60",
        shopName:"${globals.shopType} shop 4",distance:"around 5 km",rating:1));
    _shops.add( ShopModel(isFAav:false,imageUrl:"https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60",
        shopName:"${globals.shopType} shop 2",distance:"around 8 km",rating:5));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(height: 10,),
              Padding(padding:EdgeInsets.only(left: 10),child: Text('Grab Offers',style:Theme.of(context).textTheme.headline5)),
              SizedBox(height: 10,),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: _offer.length,
                  itemBuilder: (context,index) {
                    return InkWell(onTap:(){

                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                              child: Container(
                                  height: globals.height/4.5,
                                  width: globals.width/1.3,
                                  decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(20.0)),image: DecorationImage(fit: BoxFit.fill, image: NetworkImageWithRetry(_offer[index]))),
                              ),
                          )
                    );
                  },
                ),
              ),


              SizedBox(height: 10,),
              Padding(padding:EdgeInsets.only(left: 10),child:Text('Shops category',style:Theme.of(context).textTheme.headline5)),
              SizedBox(height: 10,),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: _allShopType.length,
                  itemBuilder: (context,index) {
                    return InkWell(onTap:(){
                      setState(() {
                        _allShopType.forEach((element) =>element.isSelected=false);
                        _allShopType[index].isSelected=true;
                        globals.shopType=_allShopType[index].title;
                        addShops();
                      });
                      },child: HomeCategory(categoryModel: _allShopType[index]));
                  },
                ),
              ),


              SizedBox(height: 10,),
              Padding(padding:EdgeInsets.only(left: 10),child:Text(globals.shopType, style:Theme.of(context).textTheme.headline5)),
              SizedBox(height: 10,),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _shops.length,
                  itemBuilder: (context,index) {
                    return InkWell(onTap:(){
                      Navigator.push(context, CustomPageRoute(widget: ShopViewPage(),curvedAnimation: Curves.elasticInOut));
                      },child: ShopCard(shopCard: _shops[index],favFunction: (){
                        setState(() {
                          _shops[index].isFAav?_shops[index].isFAav=false:_shops[index].isFAav=true;
                        });
                    }));
                  },
                ),
              )


            ],
          ),
      );
  }
}
