
import 'package:fairer_ui/menu/side_menu.dart';
import 'package:fairer_ui/models/user.dart';
import 'package:fairer_ui/pages/media_pages/media_index.dart';
import 'package:fairer_ui/service/auth.dart';
import 'package:fairer_ui/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lesson/timeTablePage.dart' as prefix0;

class HomePage extends StatefulWidget {
  HomePage({this.userId, this.auth, this.logoutCallback});

  final String userId;
  final BaseAuth auth;
  final VoidCallback logoutCallback;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    int _selectedPage = 0;
    final _pageOptions = [
      prefix0.Table(uid: user.uid),
      MediaIndexPage(),
    ];




    return StreamProvider<UserProfile>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.black38),
          leading: Container(),
        ),
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedPage,
             onTap: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                title: Text("メディア"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                title: Text("時間割"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text("カレンダー"),
              ),
            ],
          ),
        ),
        endDrawer: SideDrawer(auth: widget.auth, logoutCallback: widget.logoutCallback,),
        body: _pageOptions[_selectedPage],
      ),
    );
  }
}

