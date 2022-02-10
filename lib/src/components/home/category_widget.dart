import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final category;
  const CategoryWidget({this.category, Key? key}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 90,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFF6F6F6),
          ),
          child: Container(
              // child: StreamBuilder(
              //   stream: categoryBloc.getImg(widget.category['image']['url']),
              //   builder: (_, AsyncSnapshot<String> snapshot) {
              //     if (snapshot.hasData) {
              //       return Image(
              //         fit: BoxFit.cover,
              //         image: NetworkImage(snapshot.data),
              //       );
              //     }

              //     return Image(fit: BoxFit.cover, image: AssetImage("assets/image/default-image.png"));
              //   },
              // ),
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(widget.category['name'])
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
