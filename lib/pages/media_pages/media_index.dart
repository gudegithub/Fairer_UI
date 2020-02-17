import 'package:fairer_ui/menu/navigation_bar.dart';
import 'package:fairer_ui/menu/side_menu.dart';
import 'package:fairer_ui/service/auth.dart';
import 'package:flutter/material.dart';
import 'article.dart';




class MediaIndexPage extends StatelessWidget {

  final String uid;

  MediaIndexPage({this.uid});

  @override

  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MediaIndexMessage(),
        Category(),
        ArticleList(),
      ],
    );
  }

  Widget MediaIndexMessage() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 30.0),
      child: Text(
        "オススメのトピック",
        style: TextStyle(
          fontSize: 20.0,
        )
      )
    );
  }

  Widget Category() {
    return Container(
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 30.0),
            Container(
              padding: EdgeInsets.only(right: 30.0),
              child: Image.asset(
                'assets/image/Career.png',
                height: 100,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 30.0),
              child: Image.asset(
                'assets/image/Life.png',
                height: 100,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 30.0),
              child: Image.asset(
                'assets/image/Abroad.png',
                height: 100,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 30.0),
              child: Image.asset(
                'assets/image/Column.png',
                height: 100,
              ),
            )
          ],
        )
      ),
    );
  }

  Widget ArticleList() {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 30.0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Article(uid: uid),
            Article(uid: uid),
            Article(uid: uid),
            Article(uid: uid),
            Article(uid: uid),
            Article(uid: uid),
            Article(uid: uid),
            Article(uid: uid),
          ],)
        ),
      ),
    );
  }
}



