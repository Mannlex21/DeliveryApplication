import 'dart:convert';
import 'dart:io' as io;
import 'package:delivery_application/src/providers/auth.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/response.dart';
import '../../components/utils/display_dialog_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  io.File? image;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Consumer(
      builder: (context, tokenInfo, _) => Scaffold(
        body: SafeArea(
          child: Container(
            color: const Color(0xFFF6F6F6),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${auth.user?.userDetails?.firstName} ${auth.user?.userDetails?.lastName} ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/editProfile');
                              },
                              child: const Text(
                                'Edit Account',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    child: Text(
                      'Saved Places',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                color: Color(0xFFF6F6F6),
                                width: 1,
                              ))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Home',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                color: Color(0xFFF6F6F6),
                                width: 1,
                              ))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Work',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                color: Color(0xFFF6F6F6),
                                width: 1,
                              ))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Add Place',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/");
                        final auth = Provider.of<Auth>(context, listen: false);
                        auth.logout();
                      },
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
                      Navigator.of(context).pop();
                      viewPhoto();
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

  Future<Future> viewPhoto() async {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => makeDismissible(
        child: DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Stack(children: [
                  Positioned(
                    left: 0.0,
                    top: 0.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        radius: 12.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ]),
                ]),
              );
            }),
      ),
    );
  }

  Widget profileOptionBtn(
          {required String title, required Function callback}) =>
      TextButton(
        onPressed: () => callback(context),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      );

  Widget loadImg() {
    if (image == null) {
      return ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(35), // Image radius
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: AssetImage("assets/image/default-profile-image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    } else {
      return ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(35), // Image radius
          child: Image.file(
            image!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Future uploadImgFrom({
    required ImageSource source,
  }) async {
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = io.File(image.path);
      final encodeBytes = base64Encode(imageTemporary.readAsBytesSync());
      var request = await http.post(
        Uri.parse('http://192.168.1.64:9090/client/uploadProfileImage'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${auth.token}',
        },
        body: jsonEncode({
          "type": "jpg",
          "filename": "profileImage",
          "imageBase64": encodeBytes
        }),
      );

      var result = Response.fromJson(jsonDecode(request.body.toString()));
      if (result.success) {
        setState(() => this.image = imageTemporary);
      } else {
        displayDialog(context, "Error", "${result.errorList?.first.message}");
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future removeImg() async {
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      var request = await http.delete(
        Uri.parse('http://192.168.1.64:9090/client/deteleProfileImage'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${auth.token}',
        },
      );
      var result = Response.fromJson(jsonDecode(request.body.toString()));
      if (result.success) {
        setState(() => image = null);
      } else {
        displayDialog(context, "Error", "${result.errorList?.first.message}");
      }
    } on PlatformException catch (e) {
      displayDialog(context, "Error", "Failed to pick image: $e");
    }
  }

  Future getImgProfile() async {
    final auth = Provider.of<Auth>(context, listen: false);
    var request = await http.get(
        Uri.parse('http://192.168.1.64:9090/client/getProfileImage'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${auth.token}',
        });

    var result = Response.fromJson(jsonDecode(request.body.toString()));
    if (result.success) {
      final decodedBytes = base64Decode(result.value['img64']);
      final directory = await getApplicationDocumentsDirectory();
      var fileImg = io.File('${directory.path}/profile.jpeg');
      fileImg.writeAsBytesSync(List.from(decodedBytes));
      setState(() => image = fileImg);
    } else {
      setState(() => image = null);
    }
  }

  @override
  void initState() {
    super.initState();
    getImgProfile();
  }
}
