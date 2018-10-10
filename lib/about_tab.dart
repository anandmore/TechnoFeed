import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatefulWidget {
  @override
  _AboutTabState createState() => new _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
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
                        "https://anandmore.github.io/images/avatar.png"),
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
                        "https://scontent.fnag1-1.fna.fbcdn.net/v/t1.0-0/p206x206/41813775_1707333159378079_5057638631754170368_n.jpg?_nc_cat=0&oh=12938a18a6ad13a12129e6587c5f0f0c&oe=5C2D625D"),
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
              padding: const EdgeInsets.fromLTRB(0.0, 11.0, 0.0, 3.0),
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
