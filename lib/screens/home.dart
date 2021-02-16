import 'package:book/database/db_helper.dart';
import 'package:book/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:book/models/book.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper helper;
  @override
  void initState() {
    helper = DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text("معرض الكتب"),
            ),
            body: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: FutureBuilder(
                    future: helper.fetchBooks(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ResponsiveGridList(
                            desiredItemWidth: 160,
                            minSpacing: 15,
                            children: (snapshot.data as List).map((e) {
                              decrement() {
                                setState(() {
                                  helper.updateQuantity(Book({
                                    "id": e["id"],
                                    "name": e["name"],
                                    "photo": e["photo"],
                                    "quantity": e["quantity"]
                                  }));
                                });
                              }

                              return BookItem(e["id"], e["name"], e["photo"],
                                  e["quantity"], decrement);
                            }).toList());
                      }
                    }))));
  }
}
