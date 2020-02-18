
import 'package:fairer_ui/api/wpApi.dart';
import 'package:fairer_ui/menu/side_menu.dart';
import 'package:fairer_ui/pages/html_conv.dart';
import 'package:fairer_ui/pages/media_pages/article.dart';
import 'package:fairer_ui/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:flutter_html/flutter_html.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key key, this.articleData, this.auth, this.logoutCallback}) : super(key: key);

  final ArticleData articleData;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => new _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black38),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        //bottomNavigationBar: BottomMenuBar(),
        endDrawer: SideDrawer(auth: widget.auth, logoutCallback: widget.logoutCallback),
        body: ariticleLayout()
    );
  }

  Widget ariticleLayout() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          mainImage(),
          articleHeading(),
          articleBody(),
          ArticleGood(),
          RelativeArticle(),
        ],
      ),
    );
  }

  Widget mainImage() {
    return Container(
      height: 250,
      child: Container(
        child:FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: widget.articleData.eyecatchUrl
        ),//url
      ),
    );
  }

  Widget category(String category) {
    if(category == "コラム") {
      return Text("コラム", style: TextStyle(backgroundColor: Colors.blue));
    } else if(category == "キャリア") {
      return Text("キャリア", style: TextStyle(backgroundColor: Colors.limeAccent));
    } else if(category == "ライフ") {
      return Text("ライフ", style: TextStyle(backgroundColor: Colors.pinkAccent));
    } else if(category == "海外") {
      return Text("海外", style: TextStyle(backgroundColor: Colors.cyan));
    }
    return Text(category);
  }

  Widget articleHeading() {
    return Container(
        padding: EdgeInsets.only(top: 30.0, right: 40.0, left: 40.0, bottom: 20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Image.asset(
                //  'assets/image/Column_budge.png',
                //  width: 75,
                //),
                category(widget.articleData.category[0]),
                Text(widget.articleData.date)//date
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                    widget.articleData.title,//title
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                )
            ),
          ],
        )
    );
  }

  List<Widget> content(){
    var data = parser.parse(widget.articleData.content).documentElement.getElementsByTagName("body");
    List<Widget> html = new List();
    if(data.length > 0) {
      HtmlConv conv = new HtmlConv();
      for(var v in data.toList()[0].children) {
        if(v.getElementsByTagName("img").length > 0) {
          html.add(conv.imgSrc(v.outerHtml));
        } else {
          html.add(Html(data: v.outerHtml));
        }
      }
    }
    return html;
  }

  Widget articleBody() {
    return Container(
        padding: EdgeInsets.only(right: 50.0, left: 50),
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: content()
                  ),
              ),
            ],
          ),
        )
    );
  }

}

class ArticleGood extends StatefulWidget {
  ArticleGood({Key key}) : super(key: key);

  @override
  _ArticleGoodState createState() => _ArticleGoodState();
}

class _ArticleGoodState extends State<ArticleGood> {
  int _good = 0;
  bool _heart = false;

  void _incrementCounter() {
    setState(() {
      _good++;
      _heart = true;
    });
  }

  void _decrementCounter() {
    setState(() {
      _good--;
      _heart = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20.0, right: 50.0, left:50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: _heart ?
              Icon(Icons.favorite, color: Colors.pink,) :
              Icon(Icons.favorite_border, color: Colors.pink),
              onPressed: () {
                _heart ? _decrementCounter() : _incrementCounter();
              },
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                      "$_good",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                Text("いいね")
              ],
            )
          ],
        )
    );
  }
}

class RelativeArticle extends StatelessWidget{
  WpData wpData = new WpData();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 30.0),
        child: FutureBuilder(
          future: wpData.newArticlesGet(5),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              List<ArticleData> data = new List();
              data = snapshot.data;
              return
                //SingleChildScrollView(
                Column(
                  children: List.generate(snapshot.data.length, (index){
                    return new Article(articleData: data[index],);
                  }),
                  //   )
                );
            }
            return Center(
                child: CircularProgressIndicator()
            );
          },
        ),
      ),
    );
  }
}
