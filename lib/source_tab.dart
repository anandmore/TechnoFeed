import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './source.dart';

class SourceTab extends StatefulWidget {
  @override
  _SourceTabState createState() => new _SourceTabState();
}

class _SourceTabState extends State<SourceTab> {
  List<dynamic> _sources = List<dynamic>();
  void _fetchSources() async {
    var url =
        'https://newsapi.org/v2/sources?category=technology&language=en&apiKey=bac453c447ed4a2392ef426749bd4028';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _body = jsonDecode(response.body);
      setState(() {
        _sources = _body['sources'];
      });
    }
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
    super.initState();
    _fetchSources();
  }

  @override
  Widget build(BuildContext context) {
    if (_sources.length > 0) {
      return Center(
          child: Column(children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemCount: _sources.length,
          itemBuilder: (BuildContext context, int index) {
            Source _postItem;
            _postItem = Source.fromJson(_sources[index]);
            return new Card(
              elevation: 1.7,
              child: new ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: new Text(
                    _postItem.name.toString(),
                    style: new TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
                children: <Widget>[
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
                        _postItem.category.toString(),
                        style: new TextStyle(fontFamily: 'Ubuntu'),
                      ),
                      new Text(
                        _postItem.language.toString(),
                        style: new TextStyle(fontFamily: 'Ubuntu'),
                      ),
                      new Text(
                        _postItem.country.toString(),
                        style: new TextStyle(fontFamily: 'Ubuntu'),
                      ),
                      new MaterialButton(
                        onPressed: () {
                          String url = _postItem.url.toString();
                          _launchURL(url);
                        },
                        child: new Icon(Icons.language),
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
            "Fetching Sources",
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
