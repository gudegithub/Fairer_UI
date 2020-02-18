import 'package:fairer_ui/api/wpApi.dart';
import 'package:fairer_ui/menu/side_menu.dart';
import 'package:fairer_ui/service/auth.dart';

import 'article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  Categories({Key key, this.auth, this.userId, this.logoutCallback, this.category})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String category;

  @override
  State<StatefulWidget> createState() => new _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  WpData wpData = new WpData();
  Widget topImg() {
    if(widget.category == "コラム") {
      return Container(
        padding: EdgeInsets.only(right: 30.0),
        child: Image.asset(
          'assets/image/Column.png',
          height: 100,
        ),
      );
    } else if(widget.category == "ライフスタイル") {
      return Container(
        padding: EdgeInsets.only(right: 30.0),
        child: Image.asset(
          'assets/image/Life.png',
          height: 100,
        ),
      );
    } else if(widget.category == "海外") {
      return Container(
        padding: EdgeInsets.only(right: 30.0),
        child: Image.asset(
          'assets/image/Abroad.png',
          height: 100,
        ),
      );
    } else if(widget.category == "キャリア") {
      return Container(
        padding: EdgeInsets.only(right: 30.0),
        child: Image.asset(
          'assets/image/Career.png',
          height: 100,
        ),
      );
    }
    return Container();
  }

  articleList() {
    return Container(
      padding: EdgeInsets.only(right: 40.0, left: 40.0, bottom: 40.0),
      child: FutureBuilder(
          future: wpData.articlesGet(widget.category),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              List<ArticleData> data = new List();
              data = snapshot.data;
              return new Column(
                children: List.generate(snapshot.data.length, (index){
                  return new Article(articleData: data[index]);
                }),
              );
            }
            return Center(
                child: CircularProgressIndicator()
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black38),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        endDrawer: new SideDrawer(auth: widget.auth, logoutCallback: widget.logoutCallback),
        body: ListView(
          children: <Widget>[
            topImg(),
            articleList(),
          ],
        )
    );
  }
}