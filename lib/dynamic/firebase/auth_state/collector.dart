import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/dynamic/firebase/auth_repository.dart';
import 'package:quiz_app/dynamic/firebase/auth_state/decider.dart';
import 'package:quiz_app/dynamic/models/user.dart';

class Collector extends StatefulWidget {
  @override
  _CollectorState createState() => _CollectorState();
}

class _CollectorState extends State<Collector> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      initialData: null,
      value: AuthRepositry().getUserForState,
      child: Decider(),
    );
  }
}
