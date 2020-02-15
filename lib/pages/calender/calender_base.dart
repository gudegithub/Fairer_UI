import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'calender_data.dart';
import 'calender_plan_add.dart';

class CalenderBase extends StatefulWidget {
  CalenderBase();

  _CalendarBaseState createState() => _CalendarBaseState();
}

DateTime _now = DateTime.now();
DateTime _1st = _now.subtract(Duration(days: _now.day - 1)); //今の月の初めの日
DateTime _nextMonth = _1st.add(Duration(days: 40)); //次の月のいずれかの日
DateTime _beforeEnd = _1st.subtract(Duration(days: _1st.day)); //前の月の最後の日
DateTime _beginDay =
    _1st.subtract(Duration(days: _1st.weekday - 1)); //カレンダーの最初の日

class _CalendarBaseState extends State<CalenderBase> {
  Map<int, List<CalenderData>> map;
  int _counter = 0;

  void operate() async {
    final Future<Database> database = openDatabase(
      path.join(await getDatabasesPath(), 'calender4.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE calenderplan (id TEXT KEY, plan TEXT,startTime TEXT,sday INTEGER,eday INTEGER,startDay TEXT,endDay TEXT,endTime TEXT,color TEXT) ",
        );
      },
      version: 1,
    );
    Future<void> insertCalenderData(CalenderData data) async {
      final Database db = await database;
      await db.insert(
        'calenderplan',
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    void _getCalenderData(DateTime time) async {
      final Database db = await database;
      final id = (DateFormat.yM())
          .format(DateTime.now())
          .toString(); //time.month.toString()+"/"+time.year.toString();
      final List<Map<String, dynamic>> maps =
          await db.query('calenderplan', where: 'id=?', whereArgs: [id]);
      Map<int, List<CalenderData>> calenderDatas =
          Map<int, List<CalenderData>>();
      CalenderData calenderData;
      for (int i = 0; i < maps.length; i++) {
        calenderData = CalenderData(
          id: maps[i]['id'],
          sday: maps[i]['sday'],
          eday: maps[i]['eday'],
          plan: maps[i]['plan'],
          startDay: maps[i]['startDay'],
          startTime: maps[i]['startTime'],
          endDay: maps[i]['endDay'],
          endTime: maps[i]['endTime'],
          color: maps[i]['color'],
        );
        if (calenderDatas[maps[i]['sday']] == null)
          calenderDatas[maps[i]['sday']] = [];
        (calenderDatas[maps[i]['sday']]).add(calenderData);
        int k = 0;
        while (maps[i]['eday'] - maps[i]['sday'] - k > 0) {
          k++;
          if (calenderDatas[maps[i]['sday'] + k] == null)
            calenderDatas[maps[i]['sday'] + k] = [];
          (calenderDatas[maps[i]['sday'] + k]).add(calenderData);
        }
      }
      map = calenderDatas;
      print(map);
    }

    await _getCalenderData(DateTime.now());
    //deleteClass();
  }

  Color chageColor(String color) {
    Color reconvertedColor;
    switch (color) {
      case '0xFFA0C6F2':
        reconvertedColor = Color(0xFFA0C6F2);
        break;
      case '0xFFF0BBBA':
        reconvertedColor = Color(0xFFF0BBBA);
        break;
      case '0xFF8BEBB7':
        reconvertedColor = Color(0xFF8BEBB7);
        break;
      case '0xFFFFFB90':
        reconvertedColor = Color(0xFFFFFB90);
        break;
    }
    return reconvertedColor;
  }

  void _selectLeftIcon() {
    setState(() {
      _1st = _beforeEnd.subtract(Duration(days: _beforeEnd.day - 1));
      _beforeEnd = _1st.subtract(Duration(days: _1st.day));
      _beginDay = _1st.subtract(Duration(days: _1st.weekday - 1));
      _nextMonth = _1st.add(Duration(days: 40));
    });
  }

  void _selectRightIcon() {
    setState(() {
      _1st = _nextMonth.subtract(Duration(days: _nextMonth.day - 1));
      _nextMonth = _1st.add(Duration(days: 40));
      _beginDay = _1st.subtract(Duration(days: _1st.weekday - 1));
      _beforeEnd = _1st.subtract(Duration(days: _1st.day));
    });
  }

  DateTime selected = _now;

  Widget _createCalendar(BuildContext context) {
    //print(map);
    Color color;
    Color backcolor;
    Color circlecolor;
    Color selectedcolor = Color(0xFFA0C6F2);
    final List _listweek = ['日', '月', '火', '水', '木', '金', '土', '日'];
    final List _listmonth = [
      'Jan', //uary',
      'Feb', //ruary',
      'Mar', //ch',
      'Apr', //il'
      'May',
      'Jun', //e',
      'Jul', //y',
      'Aug', //ust',
      'Sep', //tember',
      'Oct', //ober',
      'Nov', //ember',
      'Dec', //ember'
    ];
    return Column(children: <Widget>[
      /*Center(
        child: Row(
          children: <Widget>[
            Expanded(
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                heroTag: 'leftbotton',
                child: Icon(
                  Icons.arrow_left,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  _selectLeftIcon();
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '${_1st.year}/${_listmonth[_1st.month - 1]} ${_1st.month}',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                heroTag: 'rightbutton',
                child: Icon(
                  Icons.arrow_right,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  _selectRightIcon();
                },
              ),
            ),
          ],
        ),
      ),*/
      Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: SizedBox(
              height: 25,
              child: GridView.count(
                  crossAxisCount: 7,
                  children: List.generate(7, (index) {
                    return Container(
                      color: Colors.white,
                      child: Text(
                        _listweek[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    );
                  })))),
      if ((_beginDay.add(Duration(days: 35))).month != _1st.month)
        Padding(
            padding: EdgeInsets.only(right: 2, left: 2),
            child: SizedBox(
                height: 450,
                child: GridView.count(
                    crossAxisCount: 7,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3.0,
                    // 縦スペース
                    // 横スペース
                    childAspectRatio: 53 / 84,
                    children: List.generate(35, (index) {
                      final thisDay = _beginDay.add(Duration(days: index - 1));
                      if (thisDay.month !=
                          (_beginDay.add(Duration(days: 7))).month) {
                        color = Colors.grey;
                      } else {
                        color = Colors.black;
                      }
                      if (_now == thisDay) {
                        circlecolor = Color(0xFFA0C6F2);
                        color = Colors.white;
                        backcolor = Colors.white;
                        if (selected == thisDay)
                          selectedcolor = Color(0xFFA0C6F2);
                        else
                          selectedcolor = Colors.white;
                      } else {
                        circlecolor = Colors.white;
                        if (selected == thisDay)
                          selectedcolor = Color(0xFFA0C6F2);
                        else
                          selectedcolor = Colors.white;
                      }
                      backcolor = Colors.white;
                      if (thisDay.day < 10) {
                        if (thisDay.month !=
                            (_beginDay.add(Duration(days: 7))).month) {
                          return Container(
                              decoration: BoxDecoration(
                                color: backcolor,
                                border: Border.all(color: selectedcolor),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Hero(
                                  tag: thisDay.toString(),
                                  child: InkWell(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Stack(children: <Widget>[
                                        Container(
                                            width: 24,
                                            height: 24,
                                            child: MaterialButton(
                                              elevation: 0,
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      color: circlecolor,
                                                      style:
                                                          BorderStyle.solid)),
                                              color: circlecolor,
                                              onPressed: () {},
                                            )),
                                        Positioned(
                                          child: Container(
                                            child: Text(
                                              '  ${thisDay.day}',
                                              style: TextStyle(color: color),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selected = thisDay;
                                      });
                                    },
                                  )));
                        } else {
                          List<CalenderData> list = map[thisDay.day];
                          if (list != null) {
                            print("b");
                            print(thisDay.day);
                            return Container(
                                decoration: BoxDecoration(
                                  color: backcolor,
                                  border: Border.all(color: selectedcolor),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Hero(
                                    tag: thisDay.toString(),
                                    child: InkWell(
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: /*Row(
                                            children: <Widget>[*/
                                              Stack(children: <Widget>[
                                                Container(
                                                    width: 24,
                                                    height: 24,
                                                    child: MaterialButton(
                                                      elevation: 0,
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              color:
                                                                  circlecolor,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      color: circlecolor,
                                                      onPressed: () {},
                                                    )),
                                                Positioned(
                                                  child: Container(
                                                    child: Text(
                                                      '  ${thisDay.day}',
                                                      style: TextStyle(
                                                          color: color),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                              /*Container(
                                                  child: ListView.builder(
                                                itemCount: list.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                      color: chageColor(
                                                          list[index].color));
                                                },
                                              ))*/
                                            /*],
                                          )*/),
                                      onTap: () {
                                        setState(() {
                                          selected = thisDay;
                                        });
                                      },
                                    )));
                          } else {
                            return Container(
                                decoration: BoxDecoration(
                                  color: backcolor,
                                  border: Border.all(color: selectedcolor),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Hero(
                                    tag: thisDay.toString(),
                                    child: InkWell(
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Stack(children: <Widget>[
                                                Container(
                                                    width: 24,
                                                    height: 24,
                                                    child: MaterialButton(
                                                      elevation: 0,
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              color:
                                                                  circlecolor,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      color: circlecolor,
                                                      onPressed: () {},
                                                    )),
                                                Positioned(
                                                  child: Container(
                                                    child: Text(
                                                      '  ${thisDay.day}',
                                                      style: TextStyle(
                                                          color: color),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                      onTap: () {
                                        setState(() {
                                          selected = thisDay;
                                        });
                                      },
                                    )));
                          }
                        }
                      } else
                        return Container(
                            decoration: BoxDecoration(
                              color: backcolor,
                              border: Border.all(color: selectedcolor),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Hero(
                                tag: thisDay.toString(),
                                child: InkWell(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Stack(children: <Widget>[
                                      Container(
                                          width: 24,
                                          height: 24,
                                          child: MaterialButton(
                                            elevation: 0,
                                            shape: CircleBorder(
                                                side: BorderSide(
                                                    color: circlecolor,
                                                    style: BorderStyle.solid)),
                                            color: circlecolor,
                                            onPressed: () {},
                                          )),
                                      Positioned(
                                        child: Container(
                                          child: Text(
                                            ' ${thisDay.day}',
                                            style: TextStyle(color: color),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selected = thisDay;
                                    });
                                  },
                                )));
                    }))))
      else
        Padding(
            padding: EdgeInsets.only(right: 2, left: 2),
            child: SizedBox(
                height: 350,
                child: GridView.count(
                    crossAxisCount: 7,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    children: List.generate(42, (index) {
                      final thisDay = _beginDay.add(Duration(days: index));
                      if (thisDay.month !=
                          (_beginDay.add(Duration(days: 7))).month) {
                        color = Colors.grey;
                      } else {
                        color = Colors.black;
                      }
                      if (_now == thisDay) {
                        backcolor = Colors.pink;
                        color = Colors.white;
                      } else
                        backcolor = Colors.transparent;
                      return Container(
                          color: backcolor,
                          child: Hero(
                            tag: thisDay,
                            child: InkWell(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    '${thisDay.day}',
                                    style: TextStyle(color: color),
                                  ),
                                ),
                                onTap: () {}),
                          ));
                    })))),
      Container(
        height: 40,
        color: Colors.grey[300],
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${selected.month}月${selected.day}日(${_listweek[selected.weekday]})",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  void initState() {
    operate();
    _counter = 1;
    selected = _now;
  }

  Widget build(BuildContext context) {
    print(DateTime.now().month.toString() +
        "/" +
        DateTime.now().year.toString() +
        "a");
    if (_counter == 1) operate();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            //child:Padding(
            // padding: EdgeInsets.only(top: 20),
            child: _createCalendar(context),
          ) //)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFA0C6F2),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CalenderAdd()));
        },
      ),
    );
  }
}
