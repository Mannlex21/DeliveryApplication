import 'package:delivery_application/src/components/home/list_category_widget.dart';
import 'package:delivery_application/src/components/home/list_item_widget.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/search');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFFF6F6F6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.search),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Buscar",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          icon: const Icon(Icons.shopping_bag),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(),
              ),
              expandedHeight: 71,
              pinned: true,
              collapsedHeight: 71,
              toolbarHeight: 70,
              elevation: 1,
              backgroundColor: Colors.white,
            ),
          ];
        },
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Container(
                color: Colors.white,
                height: 119,
                child: ListCategoryWidget(),
              ),
              ListItemWidget()
            ],
          ),
        ),
      ),
    );
  }
}
