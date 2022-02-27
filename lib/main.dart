import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:quiz_app/dynamic/firebase/auth_state/collector.dart';

void main() async {
  //await ThemePreferences.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //THEME
    var theme = Theme.of(context);
    //  return
    //MultiBlocProvider(
    // providers: [
    //   BlocProvider(create: (context) => ThemeBloc()),
    // ],
    // child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
    //   if (state is ThemeInitial) {
    return MaterialApp(
      title: 'Quiz app',
      debugShowCheckedModeBanner: false,
      home: Collector(),
      // theme: AppThemes.themes[darkOrLight.lightTheme],
    );
    // }
    // else {
    //   return Container();
    // }
  }
}
//);
//}
//}
