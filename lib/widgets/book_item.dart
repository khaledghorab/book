import 'package:book/database/db_helper.dart';
import 'package:book/models/book.dart';
import 'package:flutter/material.dart';

class BookItem extends StatefulWidget {
  final int id;
  final String name;
  final String photo;
  final int quantity;
  final Function decrementQuantity;
  BookItem(
      this.id, this.name, this.photo, this.quantity, this.decrementQuantity);

  @override
  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  DbHelper helper;
  @override
  void initState() {
    helper = DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        constraints: BoxConstraints(minHeight: 300, maxHeight: 300),
        color: Colors.white,
        child: Column(
          children: [
            Container(
                constraints: BoxConstraints(
                    minWidth: double.infinity, minHeight: 250, maxHeight: 250),
                child:
                    Image(image: AssetImage(widget.photo), fit: BoxFit.fill)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatefulBuilder(
                  builder: (cont, _setState) => RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                      onPressed: widget.quantity == 0
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (ctx) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                        title: Text("إستعارة"),
                                        content: Row(
                                          children: [
                                            Text("هل تريد إستعارة كتاب ",
                                                softWrap: true),
                                            Flexible(
                                                child: Text('"${widget.name}"؟',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    )))
                                          ],
                                        ),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                Book book = Book({
                                                  "id": widget.id,
                                                  "name": widget.name,
                                                  "photo": widget.photo,
                                                  "quantity": widget.quantity
                                                });
                                                widget.decrementQuantity();
                                                Navigator.of(ctx)
                                                    .pop(book.quantity);
                                              },
                                              child: Text("نعم",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(),
                                              child: Text("لا",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)))
                                        ])),
                              );
                            },
                      child: Text(
                        "إستعارة",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Text("عدد النسخ (${widget.quantity})")
              ],
            )
          ],
        ),
      ),
    );
  }
}
