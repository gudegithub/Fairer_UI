import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key key}) : super(key: key);

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
}

class SideMenuHeader extends StatelessWidget {
  const SideMenuHeader({Key key}) : super(key: key);

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
}

class SideMenuList extends StatelessWidget {
  String iconName;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.school),
            title: Text("大学のリンク集"),
            onTap: () {

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
          )
        ],
      ),
    );
  }
}
