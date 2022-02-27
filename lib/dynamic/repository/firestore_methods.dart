import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  Future<void> addQuiz(String quizId, Map quizData) async {
    await FirebaseFirestore.instance
        .collection('Quiz')
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestion(String quizId, Map quizQues) async {
    await FirebaseFirestore.instance
        .collection('Quiz')
        .doc(quizId)
        .collection('QuizQA')
        .add(quizQues)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuiz() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  Future getQuizQuestion(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection('QuizQA')
        .get();
  }
}
