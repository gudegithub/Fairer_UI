import 'package:flutter/material.dart';


class MediaIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black38,
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              title: Text("時間割"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text("カレンダー"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              title: Text("メディア")
            )
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: ListTile(
                
              ),
            ),
            ListTile(),
          ],
        )
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 30.0),
            child: Text(
              "オススメのトピック",
              style: TextStyle(
                fontSize: 20.0,
              )
            )
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(width: 30.0),
                Container(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Image.asset(
                    'assets/image/Career.png',
                    height: 100,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Image.asset(
                    'assets/image/Life.png',
                    height: 100,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Image.asset(
                    'assets/image/Abroad.png',
                    height: 100,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Image.asset(
                    'assets/image/Column.png',
                    height: 100,
                  ),
                )
              ],
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 30.0),
            height: 400,
            child: ListView(
              children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/image/thumbnail.png',
                        fit: BoxFit.cover,
                        )
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: Image.asset(
                                    'assets/image/Column_budge.png',
                                    width: 75,
                                  )
                                ),
                                Text(
                                  "2019 8/20",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(top: 10.0,left: 30.0, right: 30.0),
                              child: Text(
                                '【2020年度最新版】日本でeスポーツ認定されているゲーム一覧',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
            ],),
          )
        ],
      )
    );
  }
}