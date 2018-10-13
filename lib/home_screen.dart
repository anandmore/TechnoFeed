import 'package:flutter/material.dart';
import './top_tab.dart';
import './all_tab.dart';
import './source_tab.dart';
import './about_tab.dart';
import './search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _tabController;
  int _index;
  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._index = tab;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TechnoFeed",
          style: new TextStyle(
            fontFamily: 'Ubuntu',
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (SearchScreenTab())));
        },
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.blue,
              primaryColor: Colors.white,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: TextStyle(color: Colors.white))),
          child: BottomNavigationBar(
              currentIndex: _index,
              onTap: onTap,
              items: TabItems.map((TabItem item) {
                return BottomNavigationBarItem(
                  title: Text(
                    item.title,
                    style: new TextStyle(
                      fontFamily: 'Ubuntu',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  icon: Icon(item.icon),
                );
              }).toList())),
      body: PageView(
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[TopTab(), AllTab(), SourceTab(), AboutTab()],
      ),
    );
  }
}

class TabItem {
  final String title;
  final IconData icon;
  const TabItem({this.title, this.icon});
}

const List<TabItem> TabItems = <TabItem>[
  TabItem(title: 'Top Headlines', icon: Icons.whatshot),
  TabItem(title: 'All Headlines', icon: Icons.format_align_left),
  TabItem(title: 'News Sources', icon: Icons.category),
  TabItem(title: 'About the App', icon: Icons.info_outline),
];
