
import 'package:fairer_ui/models/user.dart';
import 'package:fairer_ui/pages/root_page.dart';
import 'package:provider/provider.dart';

import 'service/auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(auth: Auth(),)
      ),
    );
  }
}

