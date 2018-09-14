import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatefulWidget {
  AboutApp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AboutAppState createState() => new _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {});
          return;
        },
        child: new ListView(
          children: <Widget>[
            new Card(
              elevation: 1.7,
              child: new ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: new Text(
                    "Anand More",
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
                        "https://scontent.fbom16-1.fna.fbcdn.net/v/t1.0-9/22366684_1590070127718717_6576631357266485587_n.jpg?_nc_cat=0&oh=bee0af8a94606ea0ee522e8149bc1493&oe=5C22B0BC"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        "developer",
                        style: new TextStyle(fontFamily: 'Ubuntu'),
                      ),
                      new MaterialButton(
                        onPressed: () {
                          String url = "https://anandmore.github.io/";
                          _launchURL(url);
                        },
                        child: new Icon(Icons.language),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Card(
              elevation: 1.7,
              child: new ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: new Text(
                    "Ritesh Bawale",
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
                        "https://scontent.fbom16-1.fna.fbcdn.net/v/t1.0-9/19030223_1227788263999240_2662097946674685497_n.jpg?_nc_cat=0&oh=8d59f238f7a60d3ce68dfed369095bd4&oe=5C2EB9B1"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        "developer",
                        style: new TextStyle(fontFamily: 'Ubuntu'),
                      ),
                      new MaterialButton(
                        onPressed: () {
                          String url = "https://www.facebook.com/ritesh.bawle";
                          _launchURL(url);
                        },
                        child: new Icon(Icons.language),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Card(
              elevation: 1.7,
              child: new ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: new Text(
                    "Anan Sethi",
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
                        "https://scontent.fbom16-1.fna.fbcdn.net/v/t1.0-9/39167105_2135792873161497_8623874420005404672_n.jpg?_nc_cat=0&oh=80f6351252d6e1d9f949d1f972575318&oe=5C17B27D"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        "developer",
                        style: new TextStyle(fontFamily: 'Ubuntu'),
                      ),
                      new MaterialButton(
                        onPressed: () {
                          String url = "https://www.facebook.com/anan.sethi";
                          _launchURL(url);
                        },
                        child: new Icon(Icons.language),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: new Icon(Icons.build),
            ),
            new Text(
              "Under Construction!",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 13.0,
                fontFamily: 'Ubuntu',
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
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