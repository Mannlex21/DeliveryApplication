import 'package:delivery_application/src/bloc/products_bloc.dart';
import 'package:flutter/material.dart';

class ItemDetailWidget extends StatefulWidget {
  final item;
  const ItemDetailWidget({this.item, Key? key}) : super(key: key);

  @override
  _ItemDetailWidgetState createState() => _ItemDetailWidgetState();
}

class _ItemDetailWidgetState extends State<ItemDetailWidget> {
  final productsBloc = new ProductsBloc();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/addToCart', arguments: widget.item);
      },
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Container(
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
                        widget.item['title'].toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      if (widget.item['description'].toString().isNotEmpty) ...[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.item['description'].toString(),
                          style:
                              TextStyle(fontSize: 17, color: Colors.grey[700]),
                        )
                      ],
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '\$ ${widget.item['price']}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 15, right: 0),
              //   child: StreamBuilder(
              //     stream: productsBloc.getImg(widget.item['url']),
              //     builder: (_, AsyncSnapshot<String> snapshot) {
              //       if (snapshot.hasData) {
              //         return Container(
              //           height: 100,
              //           width: 100,
              //           decoration: BoxDecoration(
              //             color: const Color(0xFFF6F6F6),
              //             borderRadius: BorderRadius.circular(15),
              //             image: DecorationImage(
              //               image: NetworkImage(snapshot.data),
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         );
              //       }

              //       return Container(
              //         height: 100,
              //         width: 100,
              //         decoration: BoxDecoration(
              //           color: const Color(0xFFF6F6F6),
              //           borderRadius: BorderRadius.circular(15),
              //           image: DecorationImage(
              //             image: AssetImage("assets/image/default-image.png"),
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
