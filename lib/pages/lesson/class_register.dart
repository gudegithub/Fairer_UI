//時間割に授業を登録する

import 'package:fairer_ui/models/classData.dart';
import 'package:fairer_ui/pages/lesson/class_data.dart';
import 'package:fairer_ui/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'class_add.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class ClassRegister extends StatefulWidget{
  int numberClass; //1限の場合0
  int numberWeek;//月曜日の場合0
  String university;

  ClassRegister({
    @required this.numberClass,
    @required this.numberWeek,
    @required this.university,
  }):assert(numberClass !=null),
        assert(numberWeek != null);
  _ClassRegisterState createState() => _ClassRegisterState();

}
class _ClassRegisterState extends State<ClassRegister>{
  final TextEditingController eCtrl = TextEditingController();

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
  

  void dispose() {
    //ページがdispose（ページの切り替え？）が起きたときに
    //コントローラーの中身を削除する
    eCtrl.dispose();
    super.dispose();
  }
  List<String> baseWeeks = ["Mon","Tue","Wed","Thu","Fri","Sat"];
  List<String> baseTime = ["1st","2nd","3rd","4th","5th","6th","7th","8th"];
  Widget build(BuildContext context) {
    return StreamProvider<List<FirebaseClassData>>.value(
      value: DatabaseService(university: widget.university, week: widget.numberWeek, time: widget.numberClass).getClassData,
      child: Scaffold(
          appBar: AppBar(
              title: Text(
                baseWeeks[widget.numberWeek]+" "+baseTime[widget.numberClass]+"period",
              )
          ),
          body: Column(
            children: <Widget>[
              searchBar(),
              Expanded(
                child: ClassSearchResult(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
                Icons.add
            ),
            onPressed: ()async{
              final result=await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ClassAdd(numberClass:widget.numberClass, numberWeek:widget.numberWeek, university: widget.university)));
              if(result!=null) {
                Navigator.of(context).pop(result);
              }
            },
          )
      ),
    );
  }

  Widget searchBar() {
   return Container(
      height: 70,
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: eCtrl,
              decoration: InputDecoration(
                hintText: "講義名または教員名で検索",
                icon: Icon(Icons.search),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClassSearchResult extends StatelessWidget {

  final DatabaseService database;

  ClassSearchResult({this.database});

  @override
  Widget build(BuildContext context) {

    final classList = Provider.of<List<FirebaseClassData>>(context);

    if(classList != null) {  
      return ListView.builder(
        itemCount: classList.length,
        itemBuilder: (context, index) {
          return classTile(lesson: classList[index]);
        },
      );
    } else {
      return Container();
    }

  }
}

class classTile extends StatelessWidget {
  
  final FirebaseClassData lesson;

  

  const classTile({Key key, this.lesson}) : super(key: key);@override
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
                      lesson.className,
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
              id: lesson.id,
              week: lesson.week,
              time: lesson.time,
              className: lesson.className,
              teacherName: lesson.teacherName,
              roomName: lesson.room,
              classCode: lesson.classCode,
              color: "red",
              absence: 0,
              late:  0,
              attendance: 0
            );
            // Insertclassdata(classdata);
            Navigator.of(context).pop(classdata);

          },
        ),
      )
    );
  }

  Widget teacherName() {
    if (lesson.teacherName.isEmpty) {
      return Container();
    } else {
      return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.person),
          ),
          Text(lesson.teacherName)
        ],
      );
    }
  }

  Widget classRomm() {
    if (lesson.room.isEmpty) {
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
            lesson.room,
            style: TextStyle(
              fontWeight: FontWeight.w500
            ),
          )
        ],
      );
    }
  }
}