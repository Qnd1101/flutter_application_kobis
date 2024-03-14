import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/home.dart';
import 'package:flutter_application_kobis/rank_page.dart';
import 'package:flutter_application_kobis/search_Page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _index = 0;
  dynamic loadPage = const Center(
      child: Text(
    '박스오피스 화면으로 \n 이동해주세요',
    style: TextStyle(fontSize: 40),
  ));

  @override
  Widget build(BuildContext context) {
    var menus = [const Home(), const RankPage(), const SearchPage()];

    List<BottomNavigationBarItem> items = [];
    items.add(
        const BottomNavigationBarItem(label: '홈으로', icon: Icon(Icons.home)));
    items.add(
        const BottomNavigationBarItem(label: '박스오피스', icon: Icon(Icons.stars)));
    items.add(
        const BottomNavigationBarItem(label: '영화검색', icon: Icon(Icons.search)));

    return Scaffold(
      body: loadPage,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
            loadPage = menus[_index];
          });
        },
      ),
    );
  }
}
