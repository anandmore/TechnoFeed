import 'package:flutter/material.dart';
import 'dart:async';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class TopHeadlines extends StatefulWidget {
  TopHeadlines({Key key, this.title, this.provider}) : super(key: key);
  final String title;
  final List provider;

  @override
  _TopHeadlinesState createState() => new _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {});
          return;
        },
        child: new ListView.builder(
            itemCount: widget.provider.length,
            itemBuilder: (BuildContext context, int position) {
              return new Card(
                elevation: 1.7,
                child: new ExpansionTile(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                    child: new Text(
                      "${widget.provider[position]['title']}",
                      style: new TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 0.0),
                      child: Image.network(
                          "${widget.provider[position]['urlToImage']}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11.0, 7.0, 11.0, 7.0),
                      child: new Text(
                        "${widget.provider[position]['description']}",
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
                              "${widget.provider[position]['publishedAt']}")),
                          style: new TextStyle(fontFamily: 'Ubuntu'),
                        ),
                        new MaterialButton(
                          onPressed: () {
                            String url = "${widget.provider[position]['url']}";
                            _launchURL(url);
                          },
                          child: new Icon(Icons.launch),
                        ),
                        new MaterialButton(
                          onPressed: () {
                            Share.share("${widget.provider[position]['url']}");
                          },
                          child: new Icon(Icons.share),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
