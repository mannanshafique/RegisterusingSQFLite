import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justpratcice/database_helper..dart';
import 'package:justpratcice/model.dart';


class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  UserModel note;
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name,email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Padding(
              padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller:nameController ,
                  onChanged: (value){
                    print("Change in name");
                    name = nameController.text;
                  },
                  decoration: InputDecoration(
                      labelText: "Name"
                  ),
                ),
                TextField(
                  controller:emailController ,
                  onChanged: (value){
                    print("Change in email");
                    email = emailController.text;
                  },
                  decoration: InputDecoration(
                      labelText: "Email"
                  ),
                ),
                MaterialButton(
                    onPressed: (){
                      dodo(name, email);
                    },
                  color: Colors.black,
                  child: Text("Login",style: TextStyle(color: Colors.white),),

                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  color: Colors.black,
                  child: Text("Login",style: TextStyle(color: Colors.white),),

                )
              ],
            ),

          ),
        ),
      ),
    );
  }

  void dodo(String names,String emails)async{
   note = await helper.getLogin(names, emails);

  }


}
