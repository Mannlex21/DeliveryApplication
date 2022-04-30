import 'package:delivery_application/models/arguments/menu_item_argument.dart';
import 'package:delivery_application/models/menu-item.dart';
import 'package:delivery_application/src/components/utils/image.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

class ItemDetailWidget extends StatefulWidget {
  final MenuItem? item;
  const ItemDetailWidget({this.item, Key? key}) : super(key: key);

  @override
  _ItemDetailWidgetState createState() => _ItemDetailWidgetState();
}

class _ItemDetailWidgetState extends State<ItemDetailWidget> {
  io.File? image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/addToCart',
          arguments: MenuItemArgument('item', widget.item),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 110,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item!.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      if (widget.item!.description.isNotEmpty) ...[
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.item!.description,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xFF616161),
                          ),
                        )
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '\$ ${widget.item!.price}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loadImg(image, 100, 130, 15),
            ],
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
