import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/dynamic/firebase/auth_repository.dart';
import 'package:quiz_app/static/screens/home.dart';
import 'package:quiz_app/static/screens/signup.dart';
import 'package:quiz_app/widgets/appbar.dart';
import 'package:quiz_app/widgets/custom_button.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;

  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String email = '', password = '', name = "";
  final AuthRepositry _authService = AuthRepositry();

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  getInfoAndSigIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      await _authService.signInWithEmailPass(email, password).then((value) {
        // Map<String, String> userInfo = {
        //   "userName": name,
        //   "email": email,
        // };

        // databaseService.addData(userInfo);

        // Constants.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: AppLogo()),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: _loading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Spacer(),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(hintText: "Email"),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          TextField(
                            decoration: InputDecoration(hintText: "Password"),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          CustomButton(
                              text: 'Sign In',
                              onPressed: () {
                                getInfoAndSigIn();
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account? ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 17)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Container(
                                  child: Text('Sign Up',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          decoration: TextDecoration.underline,
                                          fontSize: 17)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
      ),
    );
  }
}
