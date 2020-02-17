import 'package:fairer_ui/pages/lesson/class_data.dart';
import 'package:fairer_ui/service/database.dart';
import 'package:flutter/material.dart';

class MemoAddPage extends StatefulWidget {
  
  ClassData data;

  MemoAddPage({this.data});

  @override
  _MemoAddPageState createState() => new _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {
  final _formKey = GlobalKey<FormState>();
  Color _color;
  ClassData data;
  String title;
  String content;
  DateTime today = DateTime.now();

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
  void initState() { 
    super.initState();
    _color = stringifiedColorToColor(widget.data.color);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
            child: new Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "タイトル"
                    ),
                    enabled: true,
                    validator: (val) => val.isEmpty ? "タイトルを入力してください" : null,
                    onChanged: (String value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "メモ"
                      ),
                      maxLines: 20,
                      minLines: 1,
                      validator: (val) => val.isEmpty ? "メモを入力してください" : null,
                      onChanged: (String value) {
                        setState(() {
                          content = value;
                        });
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text("Button"),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        DatabaseService(uid: widget.data.id).createMemo(title, content);
                        Navigator.of(context).pop(data);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

