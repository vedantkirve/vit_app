import 'package:flutter/material.dart';
import 'package:vit_app1/services/auth.dart';
import 'package:vit_app1/shared/constants.dart';
import 'package:vit_app1/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error= '';


  @override
  Widget build(BuildContext context) {


    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: new AppBar(
        title: new Text("Welcome to VIT"),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          new FlatButton.icon(
              padding: const EdgeInsets.all(5.0),
              onPressed: (){
                print("pressed");
                // ignore: unnecessary_statements
                widget.toggleView();

              },
              icon: new Icon(Icons.person),
              label:new Text("SignIn")),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0 ,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'EMAIL'),
                  validator:(val)=> val.isEmpty? 'Enter an email': null,
                  onChanged: (val){
                    setState(() => email=val);
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'PASSWORD'),
                  validator:(val)=> val.length<6 ?
                  'Enter an password ^= chars long': null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password=val);
                  }
              ),
              SizedBox(height: 20.0,),
              new RaisedButton(
                  color: Colors.blue[400],
                  child: new Text("Register",
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading=true);
                      print(email);
                      print(password);
                      dynamic result=_auth.registerWithEmailAndPassword(email, password);
                      if(result ==null){
                        setState((){
                          error = "please supply a valid email";
                          loading = false;
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0,),
              Text(error,
                style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 15.0
                ),)


            ],
          ),


        ),

      ),
    );
  }
}