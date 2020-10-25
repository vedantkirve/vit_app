import 'package:flutter/material.dart';
import 'package:vit_app1/services/auth.dart';
import 'package:vit_app1/shared/constants.dart';
import 'package:vit_app1/shared/loading.dart';


class SignIn extends StatefulWidget {


  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  //text field state
  String email = "";
  String password = "";
  String error='';


  @override
  Widget build(BuildContext context) {

    return loading ? Loading():Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: new AppBar(
          title: new Text("Welcome to VIT"),
          backgroundColor: Colors.blue[400],
          elevation: 0.5,
          actions: <Widget>[
            new FlatButton.icon(
                onPressed: (){
                  // ignore: unnecessary_statements
                  widget.toggleView();

                },
                icon: Icon(Icons.person),
                label: new Text("Register"))
          ]),
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
                  child: new Text("SignIn",
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                  onPressed: () async {
                    setState(() => loading=true
                    );
                    print(email);
                    print(password);
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      print("valid");
                      print(email);
                      print(password);

                      if (result == null) {
                        setState(() {
                          loading=false;
                          error = "Could not sign in";
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