import 'package:flutter/material.dart';

class AddToCartScreen extends StatefulWidget {
  final item;

  AddToCartScreen({this.item, Key? key}) : super(key: key);

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  int countItem = 1;

  removeItem() {
    setState(() {
      countItem -= 1;
    });
  }

  addItem() {
    setState(() {
      countItem += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.item);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 35,
            ),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.ios_share,
                size: 35,
              ),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  width: 160,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 15)),
                          ),
                          onPressed: removeItem,
                          child: Icon(
                            Icons.remove,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              countItem.toString(),
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 15)),
                          ),
                          onPressed: addItem,
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15)),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text('Add to Cart'),
                        Expanded(child: SizedBox()),
                        Text('\$100'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                widget.item['title'].toString(),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
