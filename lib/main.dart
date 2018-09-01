import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

String apiKey = "364d218a3b7547ea86d6aff3cf8f3cbe";
String _apiUrl =
    "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=";
List _provider;

void main() async {
  _provider = await fetchData(_apiUrl + apiKey);
  runApp(new MyApp());
}

Future<List> fetchData(apiUrl) async {
  http.Response response = await http.get(apiUrl);
  return (json.decode(response.body)['articles']);
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Top Headlines',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Top Headlines'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.title,
          style: new TextStyle(
            fontFamily: 'Ubuntu',
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: new ListView.builder(
          itemCount: _provider.length,
          itemBuilder: (BuildContext context, int position) {
            return new Card(
              elevation: 1.7,
              child: new ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: new Text(
                    "${_provider[position]['title']}",
                    style: new TextStyle(
                      fontSize: 21.0,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 0.0),
                    child:
                        Image.network("${_provider[position]['urlToImage']}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(11.0, 7.0, 11.0, 7.0),
                    child: new Text(
                      "${_provider[position]['description']}",
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
                        timeago.format(DateTime.parse(
                            "${_provider[position]['publishedAt']}")),
                        style: new TextStyle(fontFamily: 'Ubuntu'),
                      ),
                      new MaterialButton(
                        onPressed: () {
                          String url = "${_provider[position]['url']}";
                          _launchURL(url);
                        },
                        child: new Icon(Icons.launch),
                      ),
                      new MaterialButton(
                        onPressed: () {
                          Share.share("${_provider[position]['url']}");
                        },
                        child: new Icon(Icons.share),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
