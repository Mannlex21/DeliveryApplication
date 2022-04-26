class Item {
  int? id;
  String? title;
  String? description;
  double? price;
  String? image;

  Item({this.id, this.title, this.description, this.price});
  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}
