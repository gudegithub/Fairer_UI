import 'package:fairer_ui/models/memo.dart';
import 'package:flutter/material.dart';

class MemoDetailPage extends StatelessWidget {
  final Memo memo;
  final Color color;

  MemoDetailPage({this.memo, this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                child: Text(
                  memo.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Text(
                memo.content,
                style: TextStyle(fontSize: 20),
              )
            )
          ],
        ),
      ),
    );
  }
}