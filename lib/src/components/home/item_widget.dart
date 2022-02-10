import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final item;
  const ItemWidget({this.item, Key? key}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/productDetail',
                arguments: {'product': widget.item});
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
                  // Padding(
                  //   padding: const EdgeInsets.all(5),
                  //   child: StreamBuilder(
                  //     stream: productsBloc.getImg(widget.item['image']['url']),
                  //     builder: (_, AsyncSnapshot<String> snapshot) {
                  //       if (snapshot.hasData) {
                  //         return Container(
                  //           height: 120,
                  //           width: 130,
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
                  //         height: 120,
                  //         width: 130,
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
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item['name'],
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
  }
}
