import 'package:fairer_ui/api/wpApi.dart';
import 'package:fairer_ui/pages/media_pages/article.dart';
import 'package:fairer_ui/pages/media_pages/categories.dart';
import 'package:fairer_ui/service/auth.dart';
import 'package:flutter/material.dart';

class MediaIndexPage extends StatefulWidget {
  MediaIndexPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _MediaIndexPageState();
}

class _MediaIndexPageState extends State<MediaIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              GestureDetector(
                child:
                Container(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Image.asset(
                      'assets/image/Career.png',
                      height: 100,
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Categories(category: "キャリア",))
                  );
                },
              ),
              GestureDetector(
                child:
                Container(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Image.asset(
                      'assets/image/Life.png',
                      height: 100,
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Categories(category: "ライフスタイル",))
                  );
                },
              ),
              GestureDetector(
                child:
                Container(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Image.asset(
                      'assets/image/Abroad.png',
                      height: 100,
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Categories(category: "海外",))
                  );
                },
              ),
              GestureDetector(
                child:
                Container(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Image.asset(
                      'assets/image/Column.png',
                      height: 100,
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Categories(category: "コラム",))
                  );
                },
              ),
            ],
          )
      ),
    );
  }
}

class ArticleList extends StatelessWidget {
  //const ArticleList({Key key}) : super(key: key);
  final WpData wpData = new WpData();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 30.0),
        child: FutureBuilder(
          future: wpData.newArticlesGet(10),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              List<ArticleData> data = new List();
              data = snapshot.data;
              return
                //SingleChildScrollView(
                Column(
                  children: List.generate(snapshot.data.length, (index){
                    return new Article(articleData: data[index],);
                  }),
                  //   )
                );
            }
            return Center(
                child: CircularProgressIndicator()
            );
          },
        ),
      ),
    );
  }
}

