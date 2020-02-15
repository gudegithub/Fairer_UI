import 'package:fairer_ui/models/user.dart';
import 'package:fairer_ui/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../service/auth.dart";

class SideDrawer extends StatelessWidget {

  final BaseAuth auth;
  final VoidCallback logoutCallback;

  SideDrawer({this.auth, this.logoutCallback});
  

  signOut() async {
    try {
      await auth.signOut();
      logoutCallback();
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {


    return  Drawer(
        child: ListView(
          children: <Widget>[
            SideMenuHeader(),
            SideMenuList(),
          ],
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
              // showDialog(
              //   context: context,
              //   builder: (_) => linkDialog()
              // );
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
            onTap: () async {
              signOut();
            },
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

class SideMenuHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    @override

    final UserProfile userProfile = Provider.of<UserProfile>(context);
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
                  Text("${userProfile.name}"),
                  Text("${userProfile.university}　${userProfile.department}"),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}

