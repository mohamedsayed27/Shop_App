class CartModel {
  bool? status;
  String? message;
  Data? data;

  CartModel({this.status, this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<CartItem> cartItems = [];
  dynamic subTotal;
  dynamic total;
  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItem>[];
      json['cart_items'].forEach((v) {
        cartItems.add(CartItem.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItem {
  int? id;
  int? quantity;
  Product? product;

  CartItem({this.id, this.quantity, this.product});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}

class Product {
  int? id;
  dynamic price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
