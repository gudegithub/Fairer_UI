import 'package:fairer_ui/models/memo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemoList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final memoList = Provider.of<List<Memo>>(context) ?? [];
    return Container(
      margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
      child: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          return MemoTile(memo: memoList[index],);
        },
      ),
    );
  }
}

class MemoTile extends StatelessWidget {
  
  final Memo memo;

  MemoTile({this.memo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(memo.title),
                Text(memo.timestamp)
              ],
            ),
            Container(
              child: Text(memo.content)
            )
          ],
        ),
      ),
    );
  }
}