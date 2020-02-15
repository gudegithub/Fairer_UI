import 'package:flutter/material.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() {
    return _OnbordingState();
  }
}

class _OnbordingState extends State<Onbording> {
  int _counter = 0;

  Widget _imageChange() {
    if (_counter == 0) {
      return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 25),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 35, right: 35),
                ),
              ),
              Container(
                  child: Icon(IconData(58362, fontFamily: 'MaterialIcons'),
                      color: Colors.green, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30, left: 35)),
              Container(
                  child: Icon(IconData(58380, fontFamily: 'MaterialIcons'),
                      color: Colors.black, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30)),
              Container(
                  child: Icon(IconData(58380, fontFamily: 'MaterialIcons'),
                      color: Colors.black, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30)),
              GestureDetector(
                child: Container(
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 25),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 40),
                ),
                onTap: () {
                  setState(() {
                    _counter++;
                  });
                },
              )
            ],
          ),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Container(
              child: Image.asset('images/fairer1.png'),
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 250),
            ),
            Container(
                child: Text(
                  '時間割を管理しよう',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
                margin: EdgeInsets.all(40)),
            Container(
              child: Text(
                '        大学毎に登録されている\nシラバス情報をアプリに登録して\n           時間割を管理しよう',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            )
          ]),
        ),
      );
    } else if (_counter == 1) {
      return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 25),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 35, right: 35),
                ),
              ),
              Container(
                  child: Icon(IconData(58380, fontFamily: 'MaterialIcons'),
                      color: Colors.black, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30, left: 35)),
              Container(
                  child: Icon(IconData(58362, fontFamily: 'MaterialIcons'),
                      color: Colors.green, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30)),
              Container(
                  child: Icon(IconData(58380, fontFamily: 'MaterialIcons'),
                      color: Colors.black, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30)),
              GestureDetector(
                child: Container(
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 25),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 40),
                ),
                onTap: () {
                  setState(() {
                    _counter++;
                  });
                },
              )
            ],
          ),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Container(
              child: Image.asset('images/fairer2.png'),
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 250),
            ),
            Container(
                child: Text(
                  'メディアで情報収集しよう',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
                margin: EdgeInsets.all(40)),
            Container(
              alignment: Alignment.center,
              child: Text(
                '  自分の好みに最適化された\nメディアを通して大学生活に\n    必要な情報を収集しよう',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ]),
        ),
      );
    } else if (_counter == 2) {
      return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 25),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 35, right: 35),
                ),
              ),
              Container(
                  child: Icon(IconData(58380, fontFamily: 'MaterialIcons'),
                      color: Colors.black, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30, left: 35)),
              Container(
                  child: Icon(IconData(58380, fontFamily: 'MaterialIcons'),
                      color: Colors.black, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30)),
              Container(
                  child: Icon(IconData(58362, fontFamily: 'MaterialIcons'),
                      color: Colors.green, size: 16),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: 30)),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset('images/fairer3.png'),
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 200),
              ),
              Container(
                  child: Text(
                    '学内イベントスケジュールを管理しよう',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  margin: EdgeInsets.all(40)),
              Container(
                child: Text(
                  '学内イベントのスケジュールや\n             タスクの管理を\n      カレンダーで管理しよう',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 30),
              ),
              RaisedButton(
                child: Text("さあ、始めよう！",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                color: Colors.redAccent[100],
                shape: StadiumBorder(),
                onPressed: () {},
                padding:
                    EdgeInsets.only(top: 9, bottom: 9, left: 60, right: 60),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _imageChange();
  }
}
