

import 'package:flutter/material.dart';

import 'main.dart';
import 'media_index.dart';

class LoginPage  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 150.0),
              Center(child: Image.asset('assets/image/Fairer_logo.png')),
              SizedBox(height: 50.0),
              Text('あなたに最高の大学生活を')
            ],
          ),
          Container(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'メールアドレス'
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'パスワード'
                  ),
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity, 
                  child: RaisedButton(
                    child: Text(
                      "ログイン",
                      style: TextStyle(color: Colors.white)
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      //一時的なナビゲーション
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MediaIndexPage()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.0,),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.black38),),
                    SizedBox(width: 20.0,),
                    Text("または"),
                    SizedBox(width: 20.0),
                    Expanded(child: Divider(color: Colors.black38),)
                  ],
                ),
                SizedBox(height: 30.0,),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/image/google_icon.png',
                          width: 30.0,
                        ),
                        SizedBox(width: 20.0,),
                        Text("Googleでログイン")
                      ],
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 10.0,),
                Text(
                  '利用規約と個人情報保護方針に同意の上ご利用下さい',
                  style: TextStyle(
                    fontSize: 10,
                  )
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[50],
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("アカウントをお持ちではありませんか？"),
              SizedBox(width: 10.0,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
                child: Text(
                  "会員登録",
                  style: TextStyle(
                    color: Colors.blue
                  )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}