import 'package:flutter/material.dart';
import './topHeadlines.dart' as topHeadlines;
import './allHeadlines.dart' as allHeadlines;
import './newsSources.dart' as newsSources;
import './apiService.dart' as apiService;

List _topProvider, _sourceProvider, _allProvider;

void main() async {
  _topProvider = await apiService.fetchTopHeadlines();
  _sourceProvider = await apiService.fetchSources();
  _allProvider = await apiService.fetchAllHeadlines();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TechnoFeed',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new TabBarDemo(),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.whatshot),
                ),
                Tab(
                  icon: Icon(Icons.format_align_left),
                ),
                Tab(
                  icon: Icon(Icons.category),
                ),
                Tab(
                  icon: Icon(Icons.info_outline),
                ),
              ],
            ),
            title: new Text(
              "TechnoFeed",
              style: new TextStyle(
                fontFamily: 'Ubuntu',
                fontStyle: FontStyle.italic,
              ),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              new topHeadlines.TopHeadlines(provider: _topProvider),
              new allHeadlines.AllHeadlines(provider: _allProvider),
              new newsSources.NewsSources(provider: _sourceProvider),
              new Icon(Icons.report, size: 111.0),
            ],
          ),
        ),
      ),
    );
  }
}
