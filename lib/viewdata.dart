import 'package:flutter/material.dart';
import 'package:justpratcice/database_helper..dart';
import 'package:justpratcice/model.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';


//Homepage Like Which the notes
class NoteList extends StatefulWidget {

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  DatabaseHelper databaseHelper = DatabaseHelper();        //  database helper class use ke
  List<UserModel> notelist;                                    //Note.dart Class use ke
  int count = 0;


  @override
  Widget build(BuildContext context) {

    if(notelist == null){
      notelist = List<UserModel>();              //Agar null ho tou Note.dart Class sAy data laye
      updateList();
    }

    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Notes",
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: getNotListView(),
    );
  }
  ListView getNotListView(){
    TextStyle titleStyle=Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context , int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(this.notelist[position].name, style: titleStyle,),
            subtitle: Text(this.notelist[position].email),
            trailing: GestureDetector(
              child: Icon(Icons.delete,color: Colors.grey,),
              onTap: (){    // onn tap of trailling
                _delete(context, notelist[position]);
              },
            ),

          ),

        );
      },


    );
  }



  void _delete(BuildContext context , UserModel note) async{
    int result = await databaseHelper.deleteNote(note.id);
    if(result != 0){
      _showSnack(context , 'Note Deleted Successfuly');
      updateList();
    }
  }

  void _showSnack(BuildContext context , String message) {

    final snackbar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackbar);

  }



  void updateList(){

    final Future<Database> dbFutur = databaseHelper.initialzedDatabase();
    dbFutur.then((database){

      Future<List<UserModel>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList){

        setState(() {
          this.notelist = noteList;
          this.count = noteList.length;
        });
      });
    });
  }



}
