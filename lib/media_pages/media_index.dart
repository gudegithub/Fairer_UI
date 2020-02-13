import 'package:fairer_ui/menu/navigation_bar.dart';
import 'package:fairer_ui/menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'article.dart';

class MediaIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black38),
        leading: Container(),
      ),
      bottomNavigationBar: NavigationBar(),
      endDrawer: SideDrawer(),
      body: ListView(
        children: <Widget>[
          MediaIndexMessage(),
          Category(),
          ArticleList(),
        ],
      )
    );
  }
}

class MediaIndexMessage extends StatelessWidget {
  const MediaIndexMessage ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class Category extends StatelessWidget {
  const Category({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class ArticleList extends StatelessWidget {
  const ArticleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 30.0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Article(),
            Article(),
            Article(),
            Article(),
            Article(),
            Article(),
            Article(),
          ],)
        ),
      ),
    );
  }
}

