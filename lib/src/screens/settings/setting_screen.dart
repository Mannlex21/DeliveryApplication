import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SettingScreen extends StatefulWidget {
  final BuildContext context;
  const SettingScreen(this.context, {Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  io.File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => buildSheet(),
                  ),
                  child: loadImg(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImgProfile() async {
    var request = await http.post(
      Uri.parse('http://192.168.1.64:9090/client/getProfileImage'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"emailOrUser": "mannlex21", "password": "mannlex"}),
    );
    var response = jsonDecode(request.body.toString());

    if (response['success'] == true) {
      final decodedBytes = base64Decode(response['result']);
      final directory = await getApplicationDocumentsDirectory();
      var fileImg = io.File('${directory.path}/profile.jpeg');
      fileImg.writeAsBytesSync(List.from(decodedBytes));
      setState(() => image = fileImg);
    } else {
      setState(() => image = null);
    }
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: Navigator.of(context).pop,
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget buildSheet() {
    double _height = 0.0, min = 0.1, initial = 0.3, max = 0.7;

    return makeDismissible(
      child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.1,
          maxChildSize: 0.7,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  profileOptionBtn(
                    title: 'View profile picture',
                    callback: (context) {
                      print('funciono');
                    },
                  ),
                  profileOptionBtn(
                    title: 'Choose from library',
                    callback: (context) {
                      uploadImgFrom(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  profileOptionBtn(
                    title: 'Take Photo',
                    callback: (context) {
                      uploadImgFrom(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  profileOptionBtn(
                    title: 'Remove current photo',
                    callback: (context) {
                      removeImg();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget profileOptionBtn(
          {required String title, required Function callback}) =>
      TextButton(
        onPressed: () => callback(context),
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      );

  Widget loadImg() {
    if (image == null) {
      return Container(
        padding: const EdgeInsets.all(1), // Border width
        decoration: const BoxDecoration(
          color: Colors.black38,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(48), // Image radius
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage("assets/image/default-profile-image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(2), // Border width
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(48), // Image radius
            child: Image.file(
              image!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }

  Future uploadImgFrom({
    required ImageSource source,
  }) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = io.File(image.path);
      final encodeBytes = base64Encode(imageTemporary.readAsBytesSync());
      var request = await http.post(
        Uri.parse('http://192.168.1.64:9090/client/uploadProfileImage'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "login": {"emailOrUser": "mannlex21", "password": "mannlex"},
          "image": {
            "type": "jpg",
            "filename": "profileImage",
            "imageBase64": encodeBytes
          }
        }),
      );

      var response = jsonDecode(request.body);
      if (response['success'] == true) {
        setState(() => this.image = imageTemporary);
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future removeImg() async {
    try {
      var request = await http.post(
        Uri.parse('http://192.168.1.64:9090/client/deteleProfileImage'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"emailOrUser": "mannlex21", "password": "mannlex"}),
      );

      var response = jsonDecode(request.body);
      if (response['success'] == true) {
        setState(() => image = null);
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getImgProfile();
  }
}