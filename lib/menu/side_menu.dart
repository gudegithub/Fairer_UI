import 'package:fairer_ui/menu/side_pages/info.dart';
import 'package:flutter/material.dart';
import "../auth/auth.dart";
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({this.auth,  this.logoutCallback});

  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SideMenuHeader(),
          SideMenuList(),
        ],
      )
    );
  }

  Widget SideMenuHeader() {
    return DrawerHeader(
      child: Container(
        padding: EdgeInsets.only(top: 40, left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/image/sample_icon.png',
              height: 60,
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Column(
                children: <Widget>[
                  Text("山田　太郎"),
                  Text("同志社大学　経済学部")
                ],
              )
            )
          ],
        ),
      )
    );
  }

  Widget SideMenuList() {
    return Container(
      padding: EdgeInsets.only(left: 50.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.school),
            title: Text("大学のリンク集"),
            onTap: () async {
              showDialog(
                context: context,
                builder: (_) => linkDialog()
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("ヘルプ"),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("情報"),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("設定"),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("サインアウト"),
            onTap: () {
              widget.auth.signOut();
            }
          ),
          
        ],
      ),
    );
  }

  Widget linkDialog() {
    return SimpleDialog(
      title: Text("各リンク"),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            
          },
        ),
        SimpleDialogOption(),
        SimpleDialogOption(),
        SimpleDialogOption(),
      ],
    );
  }
}

