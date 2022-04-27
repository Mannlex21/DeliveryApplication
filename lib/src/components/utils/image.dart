import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';

Widget loadImg(io.File? image,
    [double? height,
    double? width,
    double border = 0,
    BoxFit? boxFit = BoxFit.cover]) {
  if (image == null) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(border),
        child: Image.asset(
          "assets/image/default-image.png",
          fit: boxFit,
        ),
      ),
    );
  } else {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(border),
        child: Image.file(
          image,
          fit: boxFit,
        ),
      ),
    );
  }
}

Future<io.File> getImg(String? imageBase64, String name) async {
  final decodedBytes = base64Decode(imageBase64!);
  final directory = await getApplicationDocumentsDirectory();
  var fileImg = io.File('${directory.path}/$name.jpeg');
  fileImg.writeAsBytesSync(List.from(decodedBytes));
  return fileImg;
}
