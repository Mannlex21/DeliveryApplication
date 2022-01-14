import 'dart:async';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class CategoryBloc {
  // Stream<DataSnapshot> get getCategories async* {
  //   DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("general-settings/category");

  //   yield await _testRef.once();
  // }

  // Stream<String> getImg(String img) async* {
  //   yield await FirebaseStorage.instance.ref(img).getDownloadURL();
  // }

  StreamController<int> _counterCategories = new StreamController<int>();
  Stream<int> get counterProducts => _counterCategories.stream;

  dispose() {
    _counterCategories.close();
  }
}
