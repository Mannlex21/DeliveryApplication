import 'package:delivery_application/src/components/home/list_item_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final BuildContext context;
  final bool showleading;
  const SearchScreen(this.context, this.showleading, {Key? key})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: widget.showleading
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 30,
                padding: const EdgeInsets.only(left: 25),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            : null,
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
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Buscar",
                    hintStyle: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        flexibleSpace: Container(),
        toolbarHeight: 70,
        elevation: 1,
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: const ListItemWidget(),
      ),
    );
  }
}
