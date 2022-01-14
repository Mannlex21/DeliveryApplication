import 'package:delivery_application/src/bloc/category_bloc.dart';
import 'package:delivery_application/src/components/home/category_widget.dart';
import 'package:flutter/material.dart';

class ListCategoryWidget extends StatefulWidget {
  ListCategoryWidget({Key? key}) : super(key: key);

  @override
  _ListCategoryWidgetState createState() => _ListCategoryWidgetState();
}

class _ListCategoryWidgetState extends State<ListCategoryWidget> {
  List lists = [];
  final categoryBloc = new CategoryBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
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

            return new ListView.builder(
              shrinkWrap: true,
              itemCount: lists.length,
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return CategoryWidget(category: lists[index]);
              },
            );
          }

          return Container(
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
