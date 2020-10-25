import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vit_app1/screens/wrapper.dart';
import 'package:vit_app1/services/auth.dart';

import 'models/user.dart';


void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
