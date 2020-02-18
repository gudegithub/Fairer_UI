
import 'package:html/parser.dart' as parser;
import 'package:flutter/material.dart';

class HtmlConv {
  Widget imgSrc(String html){
    var data = parser.parse(html).documentElement.getElementsByTagName("img");
    if(data.length < 1) return Container();

    String src;
    src = data[0].outerHtml.split(' ')[1].split('=')[1];
    src = src.substring(1, src.length - 1);
    return FadeInImage.assetNetwork(
        placeholder: 'assets/loading.gif',
        image: src
    );
  }

  bool hasElem(String html, String elem){
    var data = parser.parse(html).documentElement.getElementsByTagName(elem);
    if(data.length > 0) {
      return true;
    }

    return false;
  }
}