import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticleData {
  String        title;
  String        content;
  String        excerpt;
  String        eyecatchUrl;
  String        date;
  List<String>  category = new List();

  categorySet(List categoryIds) async {
    var response = await http.get('https://cwalk.jp/wp-json/wp/v2/categories', headers:{"Accept":"application/json"});
    var convertDatatoJson = jsonDecode(response.body);
    for(var v in convertDatatoJson) {
      for(var w in categoryIds) {
        if (w != v['id']) continue;
        this.category.add(v['name']);
      }
    }
  }
}

class WpData {
  Map<String, int> categories = new Map();
  List<ArticleData> articles = new List();

  Future<List> newArticlesGet(int num) async {
    final response = await http.get('https://cwalk.jp/wp-json/wp/v2/posts?_embed&per_page=' + num.toString(), headers:{"Accept":"application/json"});
    var convertDatatoJson = jsonDecode(response.body);
    for(var v in convertDatatoJson){
      try {
        ArticleData d = new ArticleData();
        d.title = v['title']['rendered'];
        d.content = v['content']['rendered'];
        d.excerpt = v['excerpt']['rendered'];
        d.eyecatchUrl = v["_embedded"]["wp:featuredmedia"][0]["source_url"];
        await d.categorySet(v['categories']);
        int year = DateTime.parse(v['date']).year;
        int month = DateTime.parse(v['date']).month;
        int day = DateTime.parse(v['date']).day;
        d.date = year.toString() + " " + month.toString() + "/" + day.toString();
        articles.add(d);
      } catch(e) {
        print(e);
      }
    }
    return articles;
  }

  categoriesGet() async {
    var response = await http.get('https://cwalk.jp/wp-json/wp/v2/categories', headers:{"Accept":"application/json"});
    var convertDatatoJson = jsonDecode(response.body);
    for(var v in convertDatatoJson) {
      this.categories[v['name']] = v['id'];
    }
  }

  Future<List> articlesGet(String category) async {
    await categoriesGet();
    print(categories);
    if(!categories.containsKey(category)) return null;
    String url = 'https://cwalk.jp/wp-json/wp/v2/posts?_embed&per_page=10&categories=' +
        categories[category].toString();
    final response = await http.get(
        url, headers: {"Accept": "application/json"});
    var convertDatatoJson = jsonDecode(response.body);
    print(convertDatatoJson);
    for(var v in convertDatatoJson){
      try {
        ArticleData d = new ArticleData();
        d.title = v['title']['rendered'];
        d.content = v['content']['rendered'];
        d.excerpt = v['excerpt']['rendered'];
        d.eyecatchUrl = v["_embedded"]["wp:featuredmedia"][0]["source_url"];
        await d.categorySet(v['categories']);
        int year = DateTime.parse(v['date']).year;
        int month = DateTime.parse(v['date']).month;
        int day = DateTime.parse(v['date']).day;
        d.date = year.toString() + " " + month.toString() + "/" + day.toString();
        articles.add(d);
        print(d);
      } catch(e) {
        print(e);
      }
    }
    return articles;
  }
}
