import 'dart:convert';

import 'package:http/http.dart' as http;

class KobisApi {
  final String api_key;
  final String _site =
      'http://www.kobis.or.kr/kobisopenapi/webservice/rest/'; // 공통으로 된 부분은 빼두는 것이 좋다.

  KobisApi({required this.api_key});

  Future<List<dynamic>> getDailyBoxOffice({required String targetDt}) async {
    var uri = '$_site/boxoffice/searchDailyBoxOfficeList.json';
    uri = '$uri?key=$api_key';
    uri = '$uri&targetDt=$targetDt';
    // 가독성을 위해서 위와 같은 방식으로 설정함.

    var response = await http.get(Uri.parse(uri));
    // get : 주소창으로 정보를 넘기는 것 => 주소창에 정보가 다 보임
    // post : 헤더에 정보를 넘김 => 주소창에 안보임

    if (response.statusCode == 200) {
      // 정상 수행된 코드
      // print(response.body); // 정상 수행 됐는지 확인 => .body
      // 데이터가 들어있는 경로 : boxOfficeResult.dailyBoxOfficeList
      try {
        var movies = jsonDecode(response.body)['boxOfficeResult']
            ['dailyBoxOfficeList'] as List<dynamic>; // dart가 알아 들을 수 있도록 변환
        return movies;
      } catch (e) {
        return [];
      }
    } else {
      // 정상적으로 수행되지 않은 코드
      print('error');
      return [];
    }
  }

  getMoiveDetail({required String movieCd}) async {
    var uri = '$_site/movie/searchMovieInfo.json';
    uri = '$uri?key=$api_key';
    uri = '$uri&movieCd=$movieCd';
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var movie =
          jsonDecode(response.body)['movieInfoResult']['movieInfo'] as dynamic;
      print(movie['movieNm']);
      return movie;
    } else {
      return [];
    }
  }
}
