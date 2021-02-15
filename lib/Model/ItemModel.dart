class ItemModel {
  String userid;
  String itemName;
  String imageUrl;
  String unit;
  int cartItemQuantity;
  int price;
  int discount;

  ItemModel.fromJson(Map json)
  {
    this.userid = json['userid'];
    this.itemName = json['itemName'];
    this.price = json['price'];
    this.discount = json['discount'];
    this.imageUrl = json['imageUrl'];
    this.unit = json['unit'];
  }
  ItemModel({this.imageUrl, this.itemName, this.discount, this.price,this.userid,this.unit,this.cartItemQuantity});
}