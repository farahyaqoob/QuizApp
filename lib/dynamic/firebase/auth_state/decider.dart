import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/dynamic/models/user.dart';
import 'package:quiz_app/static/screens/home.dart';
import 'package:quiz_app/static/screens/signin.dart';

class Decider extends StatefulWidget {
  @override
  _DeciderState createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
