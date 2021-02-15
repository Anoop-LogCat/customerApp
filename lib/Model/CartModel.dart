class CartModel{

  String itemName;
  String unit;
  String quantity;
  String price;
  String totPrice;

  CartModel.fromJson(Map json)
  {
    this.itemName = json['itemName'];
    this.unit = json['unit'];
    this.price = json['price'];
    this.totPrice = json['total'];
    this.quantity = json['quantity'];
  }
}