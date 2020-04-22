class UserModel{
  int _id;
  String _name;
  String _email;


  UserModel(this._name, this._email,);


  UserModel.withId(this._id, this._name, this._email,);


  Map<String , dynamic> toMap(){
    var map = Map<String, dynamic>();

    map['name'] = _name;
    map['email'] = _email;
    return map;
  }


  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) {
    _id = value;
  }


  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }



  UserModel.fromMapObject(Map<String , dynamic> map){
    this._id=map['id'];
    this._name=map['name'];
    this._email=map['email'];
  }



}