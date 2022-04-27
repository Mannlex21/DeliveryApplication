import 'dart:convert';

import 'package:delivery_application/models/arguments/item_argument.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import '../../../models/item.dart';
import '../utils/image.dart';

class ItemWidget extends StatefulWidget {
  final Item? item;
  const ItemWidget({required this.item, Key? key}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  io.File? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/productDetail',
                arguments: ItemArgument('item', widget.item));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.white,
            elevation: 0,
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: loadImg(image, 120, 130, 15),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.item?.title}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Text(
                            "\$ - Mexicana",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Text(
                            "35 min - \$19",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getImg(widget.item?.image, 'store-image-${widget.item!.id}').then((value) {
      setState(() {
        image = value;
      });
    });
  }
}
