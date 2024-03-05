class CartModel {
  int? id;
  int? count = 1;
  double? price;
  String? color;
  String? name;
  String? imageUrl;
  CartModel(
      this.id, this.count, this.price, this.name, this.imageUrl, this.color);

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    price = json['price'];
    color = json['color'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['count'] = count;
    _data['price'] = price;
    _data['color'] = color;
    _data['name'] = name;
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}
