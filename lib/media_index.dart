import 'package:fairer_ui/side_menu.dart';
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
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              title: Text("時間割"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text("カレンダー"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              title: Text("メディア")
            )
          ],
        ),
      ),
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

class Article extends StatelessWidget {
  const Article({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: SizedBox(
              width: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/image/thumbnail.png',
                  fit: BoxFit.cover,
                  )
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlePage()),
                );
              },
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Image.asset(
                            'assets/image/Column_budge.png',
                            width: 75,
                          )
                        ),
                        Text(
                          "2019 8/20",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0,left: 30.0, right: 30.0),
                      child: Text(
                        '【2020年度最新版】日本でeスポーツ認定されているゲーム一覧',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ArticlePage()),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}