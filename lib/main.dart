import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justpratcice/database_helper..dart';
import 'package:justpratcice/login.dart';
import 'package:justpratcice/model.dart';
import 'package:justpratcice/viewdata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  UserModel note;
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: RegisterUi(context),
        )
    );
  }

  Widget RegisterUi(context) {
    return Stack(
      children: <Widget>[
        textFieldUi(),
        Button(),
        FlatButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NoteList()));
            },
            child: Text("Move to data")
        ),
        Padding(padding: EdgeInsets.all(30.0),
        child:  FlatButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginView()));
            },
            child: Text("Move to Login")
        ),
        )


      ],
    );
  }


  Container textFieldUi() {
    return Container(
        margin: EdgeInsets.only(top: 150.0,),

        child: Padding(padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                onChanged: (value){
                  print("Change in name");
                  Name();

                },
                decoration: InputDecoration(
                  labelText: "Name"
                ),

              ),

              TextField(
                controller:emailController ,
                onChanged: (value){
                  print("Change in email");
                  Email();

                },
                decoration: InputDecoration(
                    labelText: "Name"
                ),

              )

            ],
          ),
        )

    );
  }

  Container Button(){
    return Container(
      margin: EdgeInsets.only(top: 520.0),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 60.0),
        child: RegisterButton(),
      ),
    );
  }

  void Name(){
  note.name = nameController.text;
  }
  void Email(){
    note.email = emailController.text;

  }


  void _reg()async{
    int result;
    if(note == null){
      UserModel st = new UserModel(nameController.text,emailController.text);
      result = await helper.insertNote(st);
//          .then((value) => {
//        nameController.clear(),
//        emailController.clear(),
//        print("student Add"),
//      });
    }
    else{
      note.name =nameController.text;
      note.email= emailController.text;
    }

    if(result != 0){
      _showAlert('Status', 'Save Successfuly');
    }else{
      _showAlert('Status', 'Saving Problem');
    }
  }


  void _showAlert(String title, String message){

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context,
        builder: (_) => alertDialog
    );

  }


  MaterialButton RegisterButton(){
    return MaterialButton(
        onPressed: () {
          setState(() {
            _reg();
            print("Clicled");
          });
        },
        color: Colors.blue,
        elevation: 10.0,
        splashColor: Colors.black,
        height: 50.0,

        textColor: Colors.white,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0),)
        ),
        child: Center(
          child: Text("Register",
            style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w600,),),
        )
    );
  }


}



