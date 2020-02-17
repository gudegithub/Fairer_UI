import 'articlePage.dart';
import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  Article({this.uid});

  final String uid;



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
                  MaterialPageRoute(builder: (context) => ArticlePage(uid: uid)),
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