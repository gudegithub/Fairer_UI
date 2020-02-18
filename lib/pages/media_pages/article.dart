
import 'package:fairer_ui/api/wpApi.dart';
import 'package:fairer_ui/pages/media_pages/articlePage.dart';
import 'package:fairer_ui/service/auth.dart';
import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  Article({Key key, this.auth, this.userId, this.logoutCallback, this.articleData})
      : super(key: key);

  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;
  final ArticleData articleData;

  Widget category(String category) {
    if(category == "コラム") {
      return Text("コラム", style: TextStyle(backgroundColor: Colors.blue));
    } else if(category == "キャリア") {
      return Text("キャリア", style: TextStyle(backgroundColor: Colors.limeAccent));
    } else if(category == "ライフ") {
      return Text("ライフ", style: TextStyle(backgroundColor: Colors.pinkAccent));
    } else if(category == "海外") {
      return Text("海外", style: TextStyle(backgroundColor: Colors.cyan));
    }
    return Text(category);
  }

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
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.gif',
                      image: this.articleData.eyecatchUrl
                  ),//url
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlePage(articleData: this.articleData)),
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
                            child: category(this.articleData.category[0]),
                        ),
                        Text(
                            this.articleData.date,
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
                          this.articleData.title,//title
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                        new ArticlePage(
                          articleData: this.articleData,
                        )),
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