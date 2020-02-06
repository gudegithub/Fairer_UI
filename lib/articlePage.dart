

import 'package:fairer_ui/article.dart';
import 'package:fairer_ui/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'side_menu.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key key}) : super(key: key);

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
      bottomNavigationBar: NavigationBar(),
      endDrawer: SideDrawer(),
      body: AriticleLayout()
    );
  }
}

class AriticleLayout extends StatelessWidget {
  const AriticleLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MainImage(),
          ArticleHeading(),
          ArticleBody(),
          ArticleGood(),
          RelativeArticle(),
        ],
      ),
    );
  }
}

class MainImage extends StatelessWidget {
  const MainImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Container(
        decoration:
        BoxDecoration( 
          image: DecorationImage(
            image: AssetImage("assets/image/thumbnail.png"),
            fit: BoxFit.cover
          )
        )
      ),
    );
  }
}




class ArticleHeading extends StatelessWidget {
  const ArticleHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0, right: 40.0, left: 40.0, bottom: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                'assets/image/Column_budge.png',
                width: 75,
              ),
              Text(
                "2019 12/21"
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "【2020年度最新版】日本でeスポーツ認定されているゲーム一覧",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            )
          ),
        ],
      )
    );
  }
}




class ArticleBody extends StatelessWidget {
  const ArticleBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 50.0, left: 50),
      child: Text("asdfasdfsdfssssssdfahdfhfdsdsfagssadfsadfasdfsadfasdfasdfasdfg"),
    );
  }
}




class ArticleGood extends StatefulWidget {
  ArticleGood({Key key}) : super(key: key);

  @override
  _ArticleGoodState createState() => _ArticleGoodState();
}

class _ArticleGoodState extends State<ArticleGood> {
  int _good = 0;
  bool _heart = false;

  void _incrementCounter() {
    setState(() {
      _good++;
      _heart = true;
    });
  }

  void _decrementCounter() {
    setState(() {
      _good--;
      _heart = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, right: 50.0, left:50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: _heart ? 
            Icon(Icons.favorite, color: Colors.pink,) : 
            Icon(Icons.favorite_border, color: Colors.pink),
            onPressed: () {
              _heart ? _decrementCounter() : _incrementCounter();
            },
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  "$_good",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
              Text("いいね")
            ],
          )
        ],
      )
    );
  }
}


class RelativeArticle extends StatelessWidget {
  const RelativeArticle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 40.0, left: 40.0, bottom: 40.0),
      child: Column(
        children: <Widget>[
          Article(),
          Article(),
          Article(),
          Article(),
          Article(),
        ],
      )
    );
  }
}