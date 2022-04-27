import 'dart:convert';

import 'package:delivery_application/models/menu-item.dart';
import 'package:delivery_application/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../../models/item.dart';
import '../../../models/store.dart';
import '../../components/store/item_widget.dart';
import 'dart:io' as io;

import '../../components/utils/image.dart';

class StoreScreen extends StatefulWidget {
  final Item? item;
  const StoreScreen({required this.item, Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int currentIndex = 0;
  Store store = Store(
    'Tacos',
    'Ricos tacos',
    '',
    [
      Menu(
        'Comida',
        [
          MenuItem(1, 'Tacos', 'Muy ricos tacos de asada', 0,
              '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'),
        ],
      ),
    ],
  );
  io.File? image;
  TabBar get _tabBar => TabBar(
        isScrollable: true,
        indicatorWeight: 2,
        labelColor: Colors.black,
        indicatorColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
        labelPadding: const EdgeInsets.symmetric(horizontal: 30.0),
        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        tabs: List<Widget>.generate(
          store.menu.length,
          (int index) {
            return Tab(
              text: store.menu[index].title,
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: store.menu.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                flexibleSpace: loadImg(image),
                title: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.zero,
                  child: Container(),
                ),
                expandedHeight: 200,
                pinned: true,
                floating: true,
                elevation: 1,
                collapsedHeight: 71,
                toolbarHeight: 70,
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 35,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 35,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
              SliverPersistentHeader(
                floating: false,
                delegate: _SliverAppBarDelegate(_tabBar),
                pinned: true,
              ),
            ];
          },
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: TabBarView(
                  children: List<Widget>.generate(
                    store.menu.length,
                    (int index) {
                      final children = store.menu[index];

                      return ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  children.title,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: children.items.length,
                                physics: const ScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int indexItem) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        ItemDetailWidget(
                                          item: children.items[indexItem],
                                        ),
                                        Divider(
                                          color: Colors.grey[700],
                                          thickness: 0.5,
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
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

  @override
  void dispose() {
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
