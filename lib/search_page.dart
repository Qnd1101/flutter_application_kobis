import 'package:flutter/material.dart';

import 'kobis_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  var _searchType = 'movieNm';
  var kobisApi = KobisApi(api_key: '1315403fd8be9bf87bdf519674427c39');

  // 검색을 눌렀을 때 동작하는 메서드
  void getMovieList() async {
    var movies = await kobisApi.getSearchMovieList(
        searchType: _searchType, searchValue: controller.text);
    for (var movie in movies) {
      print(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: 'movieNm',
                child: Text('영화제목'),
              ),
              DropdownMenuItem(
                value: 'directorNm',
                child: Text('감독명'),
              )
            ],
            onChanged: (value) {
              _searchType = value.toString();
            },
          ),
          Expanded(
            child: TextFormField(
              autofocus: true,
              controller: controller,
            ),
          ),
          ElevatedButton(onPressed: getMovieList, child: const Text('검색'))
        ],
      ),
    );
  }
}
