import 'package:delivery_application/src/components/item/item_widget.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  final item;
  const StoreScreen({this.item, Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int currentIndex = 0;
  TabBar get _tabBar => TabBar(
        isScrollable: true,
        indicatorWeight: 2,
        labelColor: Colors.black,
        indicatorColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
        labelPadding: const EdgeInsets.symmetric(horizontal: 30.0),
        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        tabs: List<Widget>.generate(
          widget.item['product']['menu'].length,
          (int index) {
            return Tab(
              text: widget.item['product']['menu'][index]['title'],
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: widget.item['product']['menu'].length,
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
                // flexibleSpace: StreamBuilder(
                //   stream: productsBloc
                //       .getImg(widget.item['product']['image']['url']),
                //   builder: (_, AsyncSnapshot<String> snapshot) {
                //     if (snapshot.hasData) {
                //       return Container(
                //         decoration: BoxDecoration(
                //           image: DecorationImage(
                //             fit: BoxFit.cover,
                //             image: NetworkImage(snapshot.data),
                //           ),
                //         ),
                //         child: Container(
                //           color: Colors.black.withOpacity(.1),
                //         ),
                //       );
                //     }

                //     return Container(
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //           fit: BoxFit.cover,
                //           image: AssetImage("assets/image/default-image.png"),
                //         ),
                //       ),
                //       child: Container(
                //         color: Colors.black.withOpacity(.1),
                //       ),
                //     );
                //   },
                // ),
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
                    widget.item['product']['menu'].length,
                    (int index) {
                      final children = widget.item['product']['menu'][index];

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
                                  children['title'],
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
                                itemCount: children['children'].length,
                                physics: const ScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int indexItem) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        ItemDetailWidget(
                                            item: children['children']
                                                [indexItem]),
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
