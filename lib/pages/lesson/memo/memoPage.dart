import 'package:fairer_ui/models/memo.dart';
import 'package:fairer_ui/pages/lesson/class_data.dart';
import 'package:fairer_ui/pages/lesson/memo/memoAdd.dart';
import 'package:fairer_ui/pages/lesson/memo/memoList.dart';
import 'package:fairer_ui/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemoPage extends StatefulWidget {

  ClassData data;
  MemoPage({this.data});

  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  Color _color;
  ClassData _classdata;
  void initState(){
    _color=stringifiedColorToColor(widget.data.color);
    _classdata=widget.data;
    super.initState();
  }

  Color stringifiedColorToColor(String stringifiedColor) {
    Color reconvertedColor;
    switch (stringifiedColor) {
      case 'red':
        reconvertedColor=Colors.redAccent;
        break;
      case 'pinkAccent':
        reconvertedColor = Colors.pinkAccent;
        break;
      case 'redAccent':
        reconvertedColor = Colors.redAccent;
        break;
      case 'yellowAccent':
        reconvertedColor = Colors.yellowAccent;
        break;
      case 'orangeAccent':
        reconvertedColor = Colors.orangeAccent;
        break;
      case 'lightGreenAccent':
        reconvertedColor = Colors.lightGreenAccent;
        break;
      case 'greenAccent':
        reconvertedColor = Colors.greenAccent;
        break;
      case 'blueAccent':
        reconvertedColor = Colors.blueAccent;
        break;
      case 'indigoAccent':
        reconvertedColor = Colors.indigoAccent;
        break;
      case 'tealAccent':
        reconvertedColor = Colors.teal;
        break;
    }
    return reconvertedColor;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Memo>>.value(
      value: DatabaseService(classId: widget.data.id).getMemo,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data.className),
          backgroundColor: _color,
          /*actions: <Widget>[
            IconButton(icon: Icon(Icons.edit), onPressed: (){
                },)
          ],*/
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
              Icons.add
          ),
          onPressed: ()async{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemoAddPage(data: widget.data)),
            );
          }
        ),
        body: MemoList(),
      ),
    );
  }
}

