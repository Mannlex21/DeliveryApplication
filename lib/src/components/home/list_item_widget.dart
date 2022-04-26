import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/item.dart';
import '../../../models/response.dart';
import '../../providers/auth.dart';
import '../utils/display_dialog_widget.dart';
import 'item_widget.dart';

class ListItemWidget extends StatefulWidget {
  const ListItemWidget({Key? key}) : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  List lists = [];
  late Future<List<Item>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Item>? data = snapshot.data;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: data?.length,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ItemWidget(item: data?[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default show a loading spinner.
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Image.asset('assets/loading.gif')],
          ),
        );
      },
    );
  }

  Future<List<Item>> fetchData() async {
    List<Item> response = [];
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      var request = await http.get(
          Uri.parse('http://192.168.1.64:9090/items/getItems'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${auth.token}',
          });
      var result = Response.fromJson(jsonDecode(request.body.toString()));
      if (result.success) {
        List jsonResponse = result.value;
        return jsonResponse.map((data) => Item.fromJson(data)).toList();
      }
      return response;
    } catch (e) {
      displayDialog(context, "Error", "$e");
      return response;
    }
  }
}
