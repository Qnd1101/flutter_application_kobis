import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/kobis_api.dart';

class MovieDetailView extends StatefulWidget {
  Map<String, dynamic> movie;
  MovieDetailView({super.key, required this.movie});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  void showPopup() async {
    var kobisApi = KobisApi(api_key: '1315403fd8be9bf87bdf519674427c39');

    var company = await kobisApi.getCompanyDetail(
        companyCd: widget.movie['companys'][0]['companyCd']);

    var msg = showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('${company['companyNm']}'),
              content: const Text('company info'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 너 나가
                    },
                    child: const Text('닫기'))
              ],
            ));
    print(msg);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movie);

    // 15 동그라미 모양
    Map<String, dynamic> gradeStyle = {};
    var grade = widget.movie['audits'][0]['watchGradeNm'].toString();
    if (grade == '15세이상관람가') {
      // 아래 방식의 타입은 Map타입
      gradeStyle['color'] = Colors.amber;
      gradeStyle['text'] = '15';
    }

    return Column(
      children: [
        Text(
          '${widget.movie['movieNm']}(${widget.movie['prdtYear']})',
          style: const TextStyle(fontSize: 20),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: gradeStyle['color'], shape: BoxShape.circle),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Center(child: Text(gradeStyle['text'])),
            )
          ],
        ),
        GestureDetector(
            onTap: () {
              // 영화 회사 정보를 검색해서, dialog로 띄우기
              showPopup();
            },
            child: Text('${widget.movie['companys'][0]['companyCd']}'))
      ],
    );
  }
}
