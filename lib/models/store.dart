import 'package:delivery_application/models/menu.dart';

class Store {
  String name;
  String description;
  String image;
  List<Menu> menu;
  Store(this.name, this.description, this.image, this.menu);
}
