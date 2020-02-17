import 'package:fairer_ui/models/memo.dart';
import 'package:fairer_ui/pages/lesson/memo/memoDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MemoList extends StatelessWidget {

  final Color color;

  MemoList({this.color});

  @override
  Widget build(BuildContext context) {
    final memoList = Provider.of<List<Memo>>(context) ?? [];
    return Container(
      margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
      child: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          return MemoTile(memo: memoList[index],color: color,);
        },
      ),
    );
  }
}

class MemoTile extends StatelessWidget {
  
  final Memo memo;
  final DateTime date;
  final Color color;

  MemoTile({this.memo,this.date,this.color});

  get sentDateFormatted  {
    initializeDateFormatting("ja_JP");
    final DateTime date = memo.timestamp.toDate();

    var formatter = new DateFormat('MM/dd(E)', "ja_JP");
    var formatted = formatter.format(date); // DateからString
    return formatted;
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    memo.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(sentDateFormatted),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(memo.content)
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MemoDetailPage(memo: memo,color: color,)),
          );
        },
      ),
    );
  }
}