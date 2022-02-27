import 'package:flutter/material.dart';
import 'package:quiz_app/dynamic/firebase/auth_repository.dart';
import 'package:quiz_app/dynamic/repository/firestore_methods.dart';
import 'package:quiz_app/static/screens/quiz_create.dart';
import 'package:quiz_app/static/screens/quiz_play.dart';
import 'package:quiz_app/static/screens/signin.dart';
import 'package:quiz_app/widgets/appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  AuthRepositry _authRepositry = AuthRepositry();
  FirestoreMethods _methods = FirestoreMethods();
  // Widget quizList() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         StreamBuilder(
  //             stream: quizStream,
  //             builder: (context, snapshot) {
  //               return snapshot.data == null
  //                   ? Container()
  //                   : ListView.builder(
  //                       itemCount: snapshot.data.doc.length,
  //                       itemBuilder: (context, index) {
  //                         return QuizTile(
  //                             title: snapshot.data.doc[index].data['quizTitle'],
  //                             imageUrl:
  //                                 snapshot.data.doc[index].data['quizImageUrl'],
  //                             description:
  //                                 snapshot.data.doc[index].data['quizDesc']);
  //                         ;
  //                       });
  //             })
  //       ],
  //     ),
  //   );
  // }

  Widget quizList() {
    return Container(
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return QuizInfo(
                      imageUrl: snapshot.data.docs[index]['quizImageUrl'],
                      title: snapshot.data.docs[index]['quizTitle'],
                      description: snapshot.data.docs[index]['quizDesc'],
                      quizId: snapshot.data.docs[index]['quizId'],
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    _methods.getQuiz().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                showAlertDialog(context);
              },
              child: Icon(
                Icons.logout,
                color: Colors.blue,
              ),
            ),
          )
        ],
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizInfo extends StatelessWidget {
  final String imageUrl, title, description, quizId;

  QuizInfo(
      {@required this.title,
      @required this.imageUrl,
      @required this.description,
      @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return
        // GestureDetector(
        //   onTap: (){
        //     Navigator.push(context, MaterialPageRoute(
        //       builder: (context) => QuizPlay(id)
        //     ));
        // },
        GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizPlay(
                      quizId,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 10),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  AuthRepositry _authRepositry = AuthRepositry();
  // Create button
  Widget logoutButton = TextButton(
    child: Text("Yes"),
    onPressed: () async {
      await _authRepositry.signOut();
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    },
  );
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logout"),
    content: Text("Are you sure you want logout?"),
    actions: [
      Row(
        children: [cancelButton, logoutButton],
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
