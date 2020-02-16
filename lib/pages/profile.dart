import 'package:fairer_ui/service/database.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  final String uid;
  final String name;
  final String university;
  final String department;
  final VoidCallback loginCallback;
  final bool isSignupForm;

  Profile({
    @required this.uid,  
    @required this.isSignupForm,
    this.loginCallback,
    this.name,
    this.university,
    this.department,
  });

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  List<String> selectedUnivercityGakubu = [];
  String _currentlySelected;
  String _selectedGakubu;
  String _name;

  List<String> _dropdownValues = [
    "同志社大学",
    "立命館大学",
    "関西学院大学",
    "近畿大学",
  ]; //The list of values we want on the dropdown

  @override
  Widget build(BuildContext context) {

    if (!widget.isSignupForm) {
      initState(){
        _name = widget.name;
        _currentlySelected = widget.university;
        _selectedGakubu = widget.department;
      }
    }

    final userNameInputController = new TextEditingController();
    userNameInputController.text = _name;

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          'プロフィール',
          style: TextStyle(
              color: Colors.black54, fontSize: 25, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/image/profile.png'),
                      margin: EdgeInsets.only(top: 70),
                    ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 50),
                      child: TextFormField(
                        enabled: true,
                        // 入力数
                        maxLength: 10,
                        maxLengthEnforced: false,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        obscureText: false,
                        maxLines: 1,
                        controller: userNameInputController,
                        decoration: const InputDecoration(
                          hintText: 'お名前を教えてください',
                          labelText: "ニックネーム",
                        ),
                        validator: (value) => value.isEmpty ? 'ニックネームを入力してください' : null,
                        onChanged: (value) {
                          //once dropdown changes, update the state of out currentValue
                          setState(() {
                            _name = value;
                          });
                        },
                      ),
                    ),
                    Container(
                        child: Text(
                          '学校情報',
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        ),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 50, top: 20, bottom: 20)),
                    Container(
                      child: Text('大学',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 17)),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 50, top: 30, bottom: 30),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: DropdownButton(
                              hint: widget.isSignupForm ? Text("大学") : Text("${widget.university}"),

                              //map each value from the lIst to our dropdownMenuItem widget
                              items: _dropdownValues.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              value: _currentlySelected,
                              onChanged: (value) {
                                //once dropdown changes, update the state of out currentValue
                                setState(() {
                                  _currentlySelected = value;
                                  print(_currentlySelected);
                                  _setGakubu();
                                  print(selectedUnivercityGakubu);
                                });
                              },
                              //this wont make dropdown ex_panded and fill the horizontal space
                              isExpanded: true,

                              //make default value of dropdown the first value of our list
                            ),
                            width: 300,
                          ),
                          Container(
                            child: Text('学部',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 17)),
                            alignment: Alignment.topLeft,
                            margin:
                                EdgeInsets.only(left: 50, top: 30, bottom: 30),
                          ),
                          Container(
                            child: DropdownButton(
                              //map each value from the lIst to our dropdownMenuItem widget
                              items: selectedUnivercityGakubu.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              hint: widget.isSignupForm ? Text("学部") : Text("${widget.department}"),
                              value: _selectedGakubu,
                              onChanged: (String value) {
                                //once dropdown changes, update the state of out currentValue
                                setState(() {
                                  print(value);
                                  _selectedGakubu = value;
                                });
                              },
                              //this wont make dropdown expanded and fill the horizontal space
                              isExpanded: true,
                              //make default value of dropdown the first value of our list
                            ),
                            width: 300,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              child: Text(
                '保存する',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                if (_formKey.currentState.validate() && _currentlySelected != null && _selectedGakubu != null) {
                  DatabaseService(uid: widget.uid).updateUserProfile(_name, _currentlySelected, _selectedGakubu);
                  if (widget.isSignupForm) {
                    widget.loginCallback();
                  } else {
                    Navigator.pop(context);
                  }
                } 
              },
            ),
          ),
        ],
      ),
    );
  }

  _setGakubu() {
    if (_currentlySelected == "同志社大学") {
      return selectedUnivercityGakubu = [
        "神学部",
        "商学学部",
        "経済済学部",
        "文学部",
        "学部",
        "社会学部",
        "政策学部",
        "理工学部",
        "文化情報学部",
        "生命医科学部",
        "スポーツ健康科学部",
        "心理学部",
        "グローバル・コミュニケーション学部",
        "グローバル地域文化学部"
      ];
    } else if (_currentlySelected == "立命館大学") {
      return selectedUnivercityGakubu = [
        "法学部",
        "経済学部",
        "文学部",
        "産業社会学部",
        "国際関係学部",
        "映像学部",
        "経営学部",
        "政策科学部",
        "総合心理学部",
        "グローバル教養学部",
        "スポーツ健康科学部",
        "食マネジメント学部",
        "理工学部",
        "情報理工学部",
        "生命科学学部",
        "薬学部"
      ];
    } else if (_currentlySelected == "関西学院大学") {
      return selectedUnivercityGakubu = [
        "神学部",
        "経済学部",
        "文学部",
        "社会学部",
        "法学部",
        "商学部",
        "人間福祉学部",
        "教育学部",
        "総合政策学部",
        "理工学部",
        "国際学部"
      ];
    } else if (_currentlySelected == "近畿大学") {
      return selectedUnivercityGakubu = [
        "法学部",
        "経済学部",
        "文芸学部",
        "経営学部",
        "理工学部",
        "建築学部",
        "薬学部",
        "国際学部",
        "農学部",
        "医学部",
        "生物理工学部",
        "工学部",
        "産業理工学部",
        "総合社会学部"
      ];
    } else {
      return selectedUnivercityGakubu = [];
    }
  }
}
