import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vit_app1/models/user.dart';
import 'package:vit_app1/services/database.dart';
import 'package:vit_app1/shared/constants.dart';
import 'package:vit_app1/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List profile = ['Student','Faculty','Administrator'];


  String _currentName;
  String _currentProfile;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        // ignore: missing_return
        builder: (context,snapshot) {
          if(snapshot.hasData){

            UserData userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    new Text("Make Profile",
                      style: new TextStyle(
                        fontSize: 18.0,
                      ),),

                    SizedBox(height: 20.0,),
                    TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration,
                        validator: (val) => val.isEmpty ? 'Enter a name' : null,
                        onChanged: (val) {
                          setState(() => _currentName = val);
                        }
                    ),
                    SizedBox(height: 20.0,),
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                        items: profile.map((profile){
                          return DropdownMenuItem(
                            value: profile,
                              child: Text("${profile} profile"),);
                        }).toList(),
                        onChanged: (val) {
                          setState(() => _currentProfile = val);
                        }),



                    //slider


                    SizedBox(height: 10.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          "update",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            await DatabaseService(uid: user.uid).
                            updateUSerData(
                              _currentProfile ?? userData.profile,
                              _currentName ?? userData.name,
                            );
                            Navigator.pop(context);
                          }
                        }
                    )


                  ],
                ));

          }else
          {
            return Loading();

          }

        }
    );
  }
}
