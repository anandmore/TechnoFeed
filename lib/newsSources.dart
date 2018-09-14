import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class NewsSources extends StatefulWidget {
  NewsSources({Key key, this.title, this.provider}) : super(key: key);
  final String title;
  final List provider;

  @override
  _NewsSourcesState createState() => new _NewsSourcesState();
}

class _NewsSourcesState extends State<NewsSources> {
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
                      "${widget.provider[position]['name']}",
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
                          "${widget.provider[position]['category']}",
                          style: new TextStyle(fontFamily: 'Ubuntu'),
                        ),
                        new Text(
                          "${widget.provider[position]['language']}",
                          style: new TextStyle(fontFamily: 'Ubuntu'),
                        ),
                        new Text(
                          "${widget.provider[position]['country']}",
                          style: new TextStyle(fontFamily: 'Ubuntu'),
                        ),
                        new MaterialButton(
                          onPressed: () {
                            String url = "${widget.provider[position]['url']}";
                            _launchURL(url);
                          },
                          child: new Icon(Icons.language),
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
