import 'package:delivery_application/src/bloc/products_bloc.dart';
import 'package:delivery_application/src/components/home/item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatefulWidget {
  ListItemWidget({Key? key}) : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  List lists = [];
  final productsBloc = new ProductsBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: StreamBuilder(
        //   stream: productsBloc.getProducts,
        //   builder: (_, AsyncSnapshot snapshot) {
        //     if (snapshot.hasData) {
        //       lists.clear();
        //       Map<dynamic, dynamic> values = snapshot.data.value;

        //       values.forEach((key, value) {
        //         lists.add(value);
        //       });

        //       return new ListView.builder(
        //         shrinkWrap: true,
        //         itemCount: lists.length,
        //         physics: ScrollPhysics(),
        //         itemBuilder: (BuildContext context, int index) {
        //           return ItemWidget(item: lists[index]);
        //         },
        //       );
        //     }

        //     return Container(
        //       width: double.infinity,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [Image.asset('assets/loading.gif')],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
