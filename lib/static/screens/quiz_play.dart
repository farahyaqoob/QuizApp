import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/dynamic/models/quiz_model.dart';
import 'package:quiz_app/dynamic/repository/firestore_methods.dart';
import 'package:quiz_app/static/screens/home.dart';
import 'package:quiz_app/static/screens/results.dart';
import 'package:quiz_app/widgets/appbar.dart';
import 'package:quiz_app/widgets/quiz_tile.dart';

// class QuizPlay extends StatefulWidget {
//   String quizId;
//   QuizPlay({this.quizId});
//   @override
//   _QuizPlayState createState() => _QuizPlayState();
// }

// int _correct, _incorrect, _notAttemped, _total;

// class _QuizPlayState extends State<QuizPlay> {
//   FirestoreMethods _methods = FirestoreMethods();
//   QuerySnapshot querySnapshot;
//   int _correct, _incorrect, _notAttemped, _total;
//   QuestionModel getQuestionFromQuerySnapshot(DocumentSnapshot querySnapshot) {
//     QuestionModel questionModel = QuestionModel();

//     questionModel.correctOption = querySnapshot.get('option1');
//     questionModel.question = querySnapshot.get('question');
//     List<String> options = [
//       querySnapshot.get('option1'),
//       querySnapshot.get('option2'),
//       querySnapshot.get('option3'),
//       querySnapshot.get('option4')
//     ];
//     options.shuffle();
//     questionModel.option1 = options[0];
//     questionModel.option2 = options[1];
//     questionModel.option3 = options[2];
//     questionModel.option4 = options[3];
//     questionModel.answered = false;
//     return questionModel;
//   }

//   @override
//   void initState() {
//     _methods.getQuizQuestion(widget.quizId).then((value) {
//       setState(() {
//         querySnapshot = value;
//         _correct = 0;
//         _incorrect = 0;
//         _notAttemped = 0;
//         _total = querySnapshot.docs.length;
//       });
//       print("$_total is the total");
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: AppLogo(),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         brightness: Brightness.light,
//         elevation: 0.0,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             querySnapshot.docs == null
//                 ? Container()
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     physics: ClampingScrollPhysics(),
//                     itemCount: querySnapshot.docs.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return QuizPlayTile(
//                         index: index,
//                         questionModel: getQuestionFromQuerySnapshot(
//                           querySnapshot.docs[index],
//                         ),
//                       );
//                     })
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuizPlayTile extends StatefulWidget {
//   final QuestionModel questionModel;
//   final int index;
//   QuizPlayTile({@required this.questionModel, this.index});

//   @override
//   _QuizPlayTileState createState() => _QuizPlayTileState();
// }

// class _QuizPlayTileState extends State<QuizPlayTile> {
//   String optionSelected = "";
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Text(widget.questionModel.question),
//           SizedBox(
//             height: 4,
//           ),
//           GestureDetector(
//             onTap: () {
//               if (!widget.questionModel.answered) {
//                 if (widget.questionModel.option1 ==
//                     widget.questionModel.correctOption) {
//                   setState(() {
//                     optionSelected = widget.questionModel.option1;
//                     widget.questionModel.answered = true;
//                     _correct = _correct + 1;
//                     _notAttemped = _notAttemped + 1;
//                   });
//                 } else {
//                   setState(() {
//                     optionSelected = widget.questionModel.option1;
//                     widget.questionModel.answered = true;
//                     _incorrect = _incorrect + 1;
//                     _notAttemped = _notAttemped - 1;
//                   });
//                 }
//               }
//             },
//             child: QuizTile(
//                 correctAnswer: widget.questionModel.option1,
//                 description: widget.questionModel.option1,
//                 option: 'A',
//                 selectedOption: optionSelected),
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           GestureDetector(
//             onTap: () {
//               if (!widget.questionModel.answered) {
//                 if (widget.questionModel.option2 ==
//                     widget.questionModel.correctOption) {
//                   setState(() {
//                     optionSelected = widget.questionModel.option2;
//                     widget.questionModel.answered = true;
//                     _correct = _correct + 1;
//                     _notAttemped = _notAttemped + 1;
//                   });
//                 } else {
//                   setState(() {
//                     optionSelected = widget.questionModel.option2;
//                     widget.questionModel.answered = true;
//                     _incorrect = _incorrect + 1;
//                     _notAttemped = _notAttemped - 1;
//                   });
//                 }
//               }
//             },
//             child: QuizTile(
//                 correctAnswer: widget.questionModel.option1,
//                 description: widget.questionModel.option2,
//                 option: 'B',
//                 selectedOption: optionSelected),
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           GestureDetector(
//             onTap: () {
//               if (!widget.questionModel.answered) {
//                 if (widget.questionModel.option3 ==
//                     widget.questionModel.correctOption) {
//                   setState(() {
//                     optionSelected = widget.questionModel.option3;
//                     widget.questionModel.answered = true;
//                     _correct = _correct + 1;
//                     _notAttemped = _notAttemped + 1;
//                   });
//                 } else {
//                   setState(() {
//                     optionSelected = widget.questionModel.option3;
//                     widget.questionModel.answered = true;
//                     _incorrect = _incorrect + 1;
//                     _notAttemped = _notAttemped - 1;
//                   });
//                 }
//               }
//             },
//             child: QuizTile(
//                 correctAnswer: widget.questionModel.option1,
//                 description: widget.questionModel.option3,
//                 option: 'C',
//                 selectedOption: optionSelected),
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           GestureDetector(
//             onTap: () {
//               if (!widget.questionModel.answered) {
//                 if (widget.questionModel.option4 ==
//                     widget.questionModel.correctOption) {
//                   setState(() {
//                     optionSelected = widget.questionModel.option4;
//                     widget.questionModel.answered = true;
//                     _correct = _correct + 1;
//                     _notAttemped = _notAttemped + 1;
//                   });
//                 } else {
//                   setState(() {
//                     optionSelected = widget.questionModel.option4;
//                     widget.questionModel.answered = true;
//                     _incorrect = _incorrect + 1;
//                     _notAttemped = _notAttemped - 1;
//                   });
//                 }
//               }
//             },
//             child: QuizTile(
//                 correctAnswer: widget.questionModel.option1,
//                 description: widget.questionModel.option4,
//                 option: 'D',
//                 selectedOption: optionSelected),
//           ),
//         ],
//       ),
//     );
//   }
// }

class QuizPlay extends StatefulWidget {
  final String quizId;
  QuizPlay(this.quizId);

  @override
  _QuizPlayState createState() => _QuizPlayState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

/// Stream
Stream infoStream;

class _QuizPlayState extends State<QuizPlay> {
  QuerySnapshot questionSnaphot;
  FirestoreMethods _methods = new FirestoreMethods();

  bool isLoading = true;

  @override
  void initState() {
    _methods
      ..getQuizQuestion(widget.quizId).then((value) {
        questionSnaphot = value;
        _notAttempted = questionSnaphot.docs.length;
        _correct = 0;
        _incorrect = 0;
        isLoading = false;
        total = questionSnaphot.docs.length;
        setState(() {});
        print("init don $total ${widget.quizId} ");
      });

    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
        print("this is x $x");
        return [_correct, _incorrect];
      });
    }

    super.initState();
  }

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.get("question");

    /// shuffling the options
    List<String> options = [
      questionSnapshot.get("option1"),
      questionSnapshot.get("option2"),
      questionSnapshot.get("option3"),
      questionSnapshot.get("option4"),
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.get('option1');
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                        correct: _correct,
                        incorrect: _incorrect,
                        total: total,
                      )));
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    InfoHeader(
                      length: questionSnaphot.docs.length,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    questionSnaphot == null
                        ? Container(
                            child: Center(
                              child: Text("No Data"),
                            ),
                          )
                        : ListView.builder(
                            itemCount: questionSnaphot.docs.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return QuizPlayTile(
                                questionModel: getQuestionModelFromDatasnapshot(
                                    questionSnaphot.docs[index]),
                                index: index,
                              );
                            })
                  ],
                ),
              ),
            ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({@required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 14),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      NoOfQuestionTile(
                        text: "Total",
                        number: widget.length,
                      ),
                      NoOfQuestionTile(
                        text: "Correct",
                        number: _correct,
                      ),
                      NoOfQuestionTile(
                        text: "Incorrect",
                        number: _incorrect,
                      ),
                      NoOfQuestionTile(
                        text: "NotAttempted",
                        number: _notAttempted,
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  QuizPlayTile({@required this.questionModel, @required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1} ${widget.questionModel.question}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: QuizTile(
              option: "A",
              description: "${widget.questionModel.option1}",
              correctAnswer: widget.questionModel.correctOption,
              selectedOption: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: QuizTile(
              option: "B",
              description: "${widget.questionModel.option2}",
              correctAnswer: widget.questionModel.correctOption,
              selectedOption: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: QuizTile(
              option: "C",
              description: "${widget.questionModel.option3}",
              correctAnswer: widget.questionModel.correctOption,
              selectedOption: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: QuizTile(
              option: "D",
              description: "${widget.questionModel.option4}",
              correctAnswer: widget.questionModel.correctOption,
              selectedOption: optionSelected,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
