import 'package:flutter/material.dart';
import 'package:quiz_app/dynamic/repository/firestore_methods.dart';
import 'package:quiz_app/static/screens/add_ques.dart';
import 'package:quiz_app/widgets/appbar.dart';

import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizId;

  String quizImgUrl, quizTitle, quizDesc;

  bool isLoading = false;
  FirestoreMethods _methods = FirestoreMethods();

  addQuiz() async {
    quizId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> quiz = {
        'quizImageUrl': quizImgUrl,
        'quizTitle': quizTitle,
        'quizDesc': quizDesc,
        'quizId': quizId,
      };
      await _methods.addQuiz(quizId, quiz).then((value) {
        setState(() {
          isLoading = false;
        });
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Image Url" : null,
                      decoration: InputDecoration(
                          hintText: "Quiz Image Url (Optional)"),
                      onChanged: (val) {
                        quizImgUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Title" : null,
                      decoration: InputDecoration(hintText: "Quiz Title"),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Description" : null,
                      decoration: InputDecoration(hintText: "Quiz Description"),
                      onChanged: (val) {
                        quizDesc = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        addQuiz();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Create Quiz",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
