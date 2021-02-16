class Book {
  int _id;
  String _name;
  String _photo;
  int _quantity;

  Book(dynamic object) {
    _id = object["id"];
    _name = object["name"];
    _photo = object["photo"];
    _quantity = object["quantity"];
  }

  Book.fromMap(Map<String, dynamic> data) {
    _id = data["id"];
    _name = data["name"];
    _photo = data["photo"];
    _quantity = data["quantity"];
  }
  Map<String, dynamic> toMap() =>
      {"id": _id, "name": _name, "photo": _photo, "quantity": _quantity};

  int get id => _id;

  String get name => _name;

  String get photo => _photo;

  int get quantity => _quantity;
}
