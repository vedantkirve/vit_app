import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vit_app1/screens/home/settings_form.dart';
import 'package:vit_app1/services/auth.dart';
import 'package:vit_app1/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,
              horizontal: 60.0),
          child: SettingsForm(),
        );
      }
      );
    }


      return Scaffold(
        appBar: new AppBar(
          title: new Text("VIT"),
          backgroundColor: Colors.lightBlue[300],
          elevation: 0.0,
          actions: <Widget>[
            new FlatButton.icon(
                onPressed: () async{
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label:new Text("logout")),

            new FlatButton.icon(
                onPressed: ()=> _showSettingPanel(),
                icon: new Icon(Icons.settings),
                label: Text("Profile"))
          ],

        ),
          backgroundColor: Colors.white,
        body: Container(),
      );



  }
}