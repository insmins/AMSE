class Book {
  String? _imgUrl; // _ vaut dire que la variable est privée
  String _title;
  String _author;
  String _category;
  String _desc;

  Book(this._title, this._author, this._category, this._desc, [this._imgUrl]);

 /*------------------ Getters ------------------*/
  String? get imgUrl => _imgUrl;
  String get title => _title;
  String get author => _author;
  String get category => _category;
  String get desc => _desc;


}
