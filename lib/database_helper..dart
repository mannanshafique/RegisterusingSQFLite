import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';                        // to deal with file and folder
import 'package:path_provider/path_provider.dart';
import 'model.dart';             // Model Class Import


class DatabaseHelper {

  // declare singleton databasehelper......Singleton means intialize one time and use the whole application


  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; //singleton Database

  String userTable = 'user_table'; // Table
  String colId = "id";
  String colName = "name";
  String colEmail = "email";



  // Constructor 1
  DatabaseHelper._createInstance(); // Named Constuctor

// Constructor 2
  factory DatabaseHelper(){
    // factory constructor so factory constructor will retun the value

    if (_databaseHelper == null) { // Condition
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    // getter of singleton database
    if (_database == null) { // agar jo database get kiaya hay wo null hay tou new database (initileed wala method call)
      _database = await initialzedDatabase();
    }
    return _database;
  }


  Future<Database> initialzedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory(); //ye path lay kay ata hay jahan database banta hay
    String path = directory.path + 'userdetail.db'; // notes.db kay name ka database ban jaye

    var notesDatabase = openDatabase(
        path, version: 1, onCreate: _createDb); // use the createDb function
    return notesDatabase;
  }


  // ham oncreate may be lick saktay thay par alag method bana kay lika
  void _createDb(Database db, int newVersion) async {
    // only create Database
    await db.execute(
        'CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT,'
            '$colEmail TEXT)');
  }

  //Fetch Operation  : Get all note objects from database

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    var result = await db.query(userTable,
        orderBy: '$colName ASC'); // this query get data in asc  order

    return result;
  }

  Future<UserModel> getLogin(String user, String email) async {
    Database db = await this.database;
    var res = await db.rawQuery("SELECT * FROM user_table WHERE name = '$user' and email = '$email'");
    return null;
  }

// Insert Operation : Insert a note object to database
  Future<int> insertNote(UserModel model) async {
    Database db = await this.database;
    var result = await db.insert(userTable,model.toMap());
    return result;
  }

  // Delete Operation : delete a note object to database

  Future<int> deleteNote(int id) async{
    var db = await this. database;
    int result= await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
    return result;}


  Future<int> getNote() async {
    Database db = await this. database;
    List<Map<String,dynamic>> x =await db.rawQuery('SELECT COUNT (*) from $userTable');
    int result = Sqflite.firstIntValue(x);
    return result;

  }

// Get the Map List From database and convert to note list

  Future<List<UserModel>> getNoteList() async{
    var noteMapList = await getNoteMapList();     // call the fetch operation in that which get map from database
    int count = noteMapList.length;                    //count the no of map entries in db table

    List<UserModel> notelist = List<UserModel>();
    //For loop to create a Note List from a Map list
    for(int i = 0; i<count; i++){
      notelist.add(UserModel.fromMapObject(noteMapList[i]));
    }
    return notelist;
  }


}

