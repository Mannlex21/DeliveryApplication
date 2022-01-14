import 'dart:async';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';

const PRODUCTS = ['MOCASDF', 'ASDASD', 'ASDASD', 'DFHDFHT6'];

class ProductsBloc {
  // Stream<DataSnapshot> get getProducts async* {
  //   // el * es para decir que no es Future, si no stream
  //   DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("products");

  //   yield await _testRef.once();
  // }

  // Stream<String> getImg(String img) async* {
  //   yield await FirebaseStorage.instance.ref(img).getDownloadURL();
  // }

  StreamController<int> _counterProducts = new StreamController<int>();
  Stream<int> get counterProducts => _counterProducts.stream;

  dispose() {
    _counterProducts.close();
  }
}
