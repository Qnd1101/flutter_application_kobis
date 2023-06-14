import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/kobis_api.dart';

class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  var kobisApi = KobisApi(api_key: '1315403fd8be9bf87bdf519674427c39');
  @override
  Widget build(BuildContext context) {
    kobisApi.getMoiveDetail(movieCd: movieCd);
    return Scaffold(
      body: Text(movieCd),
    );
  }
}
