import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/kobis_api.dart';
import 'package:flutter_application_kobis/movie_detail_view.dart';

class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  var kobisApi = KobisApi(api_key: '1315403fd8be9bf87bdf519674427c39');

  @override
  Widget build(BuildContext context) {
    var movieData = kobisApi.getMovieDetail(movieCd: movieCd);
    return Scaffold(
      body: FutureBuilder(
        // Builder는 함수인데 위젯을 리턴해준다.
        future: movieData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movie = snapshot.data; // ['movieNm'] 형식으로 가공 된다.
            return MovieDetailView(movie: movie);
          } else {
            var msg = '데이터 로드중입니다.';
            return Center(child: Text(msg));
          }
        },
      ),
    );
  }
}
