import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './article.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:share/share.dart';

class AllTab extends StatefulWidget {
  @override
  _AllTabState createState() => new _AllTabState();
}

class _AllTabState extends State<AllTab> {
  List<dynamic> _articles = List<dynamic>();
  void _fetchArticles() async {
    var url =
        'https://newsapi.org/v2/everything?sources=ars-technica,crypto-coins-news,engadget,hacker-news,recode,techcrunch,techradar,the-next-web,the-verge,wired&launguage=en&apiKey=bac453c447ed4a2392ef426749bd4028';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _body = jsonDecode(response.body);
      setState(() {
        _articles = _body['articles'];
      });
    }
    print('Loaded ${_articles.length}');
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.length > 0) {
      return Center(
          child: Column(children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemCount: _articles.length,
          itemBuilder: (BuildContext context, int index) {
            Article _postItem;
            _postItem = Article.fromJson(_articles[index]);
            return new Card(
              elevation: 1.7,
              child: new ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: new Text(
                    _postItem.title.toString(),
                    style: new TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 0.0),
                    child: Image.network(_postItem.urlToImage.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(11.0, 7.0, 11.0, 7.0),
                    child: new Text(
                      _postItem.description.toString(),
                      style: new TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Ubuntu',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        timeago.format(
                            DateTime.parse(_postItem.publishedAt.toString())),
                        style: new TextStyle(fontFamily: 'Ubuntu'),
                      ),
                      new MaterialButton(
                        onPressed: () {
                          String url = _postItem.url.toString();
                          _launchURL(url);
                        },
                        child: new Icon(Icons.language),
                      ),
                      new MaterialButton(
                        onPressed: () {
                          Share.share(_postItem.url.toString());
                        },
                        child: new Icon(Icons.share),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ))
      ]));
    } else {
      return AlertDialog(
        content: LinearProgressIndicator(),
        title: Center(
          child: Text(
            "Fetching News",
            style: new TextStyle(
              fontFamily: 'Ubuntu',
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }
  }
}
