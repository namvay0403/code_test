class Shoe {
  Shoe({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
  });
  late final int id;
  late final String image;
  late final String name;
  late final String description;
  late final double price;
  late final String color;

  Shoe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['name'] = name;
    _data['description'] = description;
    _data['price'] = price;
    _data['color'] = color;
    return _data;
  }
}
