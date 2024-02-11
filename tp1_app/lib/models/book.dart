class Book {
  String? _imgUrl; // _ vaut dire que la variable est privée
  String _title;
  String _author;
  String _category;
  bool _isFavorite;
  String _desc;

  Book(this._title, this._author, this._category, this._isFavorite, this._desc, [this._imgUrl]);

 /*------------------ Getters ------------------*/
  String? get imgUrl => _imgUrl;
  String get title => _title;
  String get author => _author;
  String get category => _category;
  bool get isFavorite => _isFavorite;
  String get desc => _desc;
/*---------------- isFavorite Setter-------------*/
  set isFavorite(bool value) {
    _isFavorite = value;
  }

}
