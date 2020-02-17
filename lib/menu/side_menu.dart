import 'package:fairer_ui/models/user.dart';
import 'package:fairer_ui/pages/profile.dart';
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

    final UserProfile userProfile = Provider.of<UserProfile>(context);

    return  Drawer(
        child: ListView(
          children: <Widget>[
            SideMenuHeader(userProfile: userProfile),
            Container(
              padding: EdgeInsets.only(left: 50.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text("大学のリンク集"),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return linkDialog();
                        }
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => 
                          Profile(
                            uid: userProfile.uid,
                            isSignupForm: false,
                            name: userProfile.name,
                            university: userProfile.university,
                            department: userProfile.department,
                          )
                        ),
                      );
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
            ),
          ],
        )
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

  final UserProfile userProfile;

  SideMenuHeader({this.userProfile});

  @override
  Widget build(BuildContext context) {

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
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: 50),
                child: Column(
                  children: <Widget>[
                    Text("${userProfile.name}"),
                    Text("${userProfile.university}"),
                    Text("${userProfile.department}")
                  ],
                )
              ),
            )
          ],
        ),
      )
    );
  }
}

