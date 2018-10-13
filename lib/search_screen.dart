import 'package:flutter/material.dart';
import './result_screen.dart';
import './primary_button.dart';

class SearchScreenTab extends StatefulWidget {
  @override
  _SearchScreenTabState createState() => new _SearchScreenTabState();
}

class _SearchScreenTabState extends State<SearchScreenTab> {
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 351.0, 15.0, 0.0),
        child: Column(
          children: <Widget>[
            new TextFormField(
              key: new Key('query'),
              decoration:
                  new InputDecoration(labelText: 'Search for e.g "Android"'),
              style: new TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.black,
              ),
              autocorrect: false,
              controller: myController,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(9.0, 25.0, 9.0, 0.0),
              child: new PrimaryButton(
                key: new Key('search'),
                text: 'Search',
                height: 44.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultScreen(
                                query: myController.text,
                              )));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
