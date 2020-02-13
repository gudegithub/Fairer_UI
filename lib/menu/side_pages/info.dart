import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key key}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black38),
        title: Text(
          "アプリ情報",
          style: TextStyle(color: Colors.black38)
        )
      ),
      body: Container(
        padding: EdgeInsets.only(top :40),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("利用規約"),
              ),
              onTap: () {

              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("オープソースライブラリ"),
              ),
              onTap: () {

              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("プライバシーポリシー"),
              ),
              onTap: () {

              },
            )
          ],
        )
      )
    );
  }

  
}