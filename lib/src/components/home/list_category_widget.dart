import 'package:delivery_application/src/components/home/category_widget.dart';
import 'package:flutter/material.dart';

class ListCategoryWidget extends StatefulWidget {
  const ListCategoryWidget({Key? key}) : super(key: key);

  @override
  _ListCategoryWidgetState createState() => _ListCategoryWidgetState();
}

class _ListCategoryWidgetState extends State<ListCategoryWidget> {
  List lists = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 119,
      child: StreamBuilder(
        // stream: categoryBloc.getCategories,
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;

            values.forEach((key, value) {
              lists.add(value);
            });

            return ListView.builder(
              shrinkWrap: true,
              itemCount: lists.length,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return CategoryWidget(category: lists[index]);
              },
            );
          }

          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Image.asset('assets/loading.gif')],
            ),
          );
        },
      ),
    );
  }
}
