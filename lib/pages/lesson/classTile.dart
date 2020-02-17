import 'package:fairer_ui/models/classData.dart';
import 'package:fairer_ui/pages/lesson/class_data.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class ClassTile extends StatefulWidget {
  
  final FirebaseClassData lesson;
  ClassTile({this.lesson});

  @override
  _ClassTileState createState() => _ClassTileState();
}

class _ClassTileState extends State<ClassTile> {

    Future<sqlite.Database> database;
      void initState(){
        _openDatabase();
        super.initState();
      }
      void _openDatabase() async{
        database=sqlite.openDatabase(path.join(await sqlite.getDatabasesPath(),'ajj.db'),
        version: 1,
      ) ;
    }

    Future<void> Insertclassdata(ClassData classDate) async {
    final sqlite.Database db = await database;
    await db.insert(
      'classdata',
      classDate.toMap(),
      conflictAlgorithm: sqlite.ConflictAlgorithm.replace,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: InkWell(   
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      widget.lesson.className,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: classRomm(),
                    ),
                  ],
                ),
                teacherName(),
              ],
            ),
          ),
          onTap: () {
            ClassData classdata =ClassData(
              id: widget.lesson.id,
              week: widget.lesson.week,
              time: widget.lesson.time,
              className: widget.lesson.className,
              teacherName: widget.lesson.teacherName,
              roomName: widget.lesson.room,
              classCode: widget.lesson.classCode,
              color: "red",
              absence: 0,
              late:  0,
              attendance: 0
            );
            Insertclassdata(classdata);
            Navigator.of(context).pop(classdata);

          },
        ),
      )
    );
  }

  Widget teacherName() {
    if (widget.lesson.teacherName.isEmpty) {
      return Container();
    } else {
      return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.person),
          ),
          Text(widget.lesson.teacherName)
        ],
      );
    }
  }

  Widget classRomm() {
    if (widget.lesson.room.isEmpty) {
      return Container();
    } else {
      return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.account_balance,
              size: 14,
            ),
          ),
          Text(
            widget.lesson.room,
            style: TextStyle(
              fontWeight: FontWeight.w500
            ),
          )
        ],
      );
    }
  }
}