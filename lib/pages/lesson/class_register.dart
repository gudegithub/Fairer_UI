//時間割に授業を登録する

import 'package:fairer_ui/models/classData.dart';
import 'package:fairer_ui/pages/lesson/classTile.dart';
import 'package:fairer_ui/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'class_add.dart';


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
          body: ClassRegisterBody(),
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
}

class ClassRegisterBody extends StatefulWidget {
  @override
  _ClassRegisterBodyState createState() => _ClassRegisterBodyState();
}

class _ClassRegisterBodyState extends State<ClassRegisterBody> {
  
  
  @override
  Widget build(BuildContext context) {

    final classList = Provider.of<List<FirebaseClassData>>(context);

    return Column(
      children: <Widget>[
        searchBar(),
        Expanded(
          child: classSearchResult(classList),
        ),
      ],
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

  Widget classSearchResult(classList) {
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

