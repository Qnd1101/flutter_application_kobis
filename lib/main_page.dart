import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/kobis_api.dart';
import 'package:flutter_application_kobis/movie_detail.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final kobisApi = KobisApi(api_key: '1315403fd8be9bf87bdf519674427c39');
  dynamic body = const Center(
      child: Text(
    'Box Office',
    style: TextStyle(color: Colors.amber, fontSize: 70),
  ));

  // 달력을 보여주고 넘겨주는 메소드
  void showCal() async {
    var dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(2022),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    );
    if (dt != null) {
      // 날짜 형식 : 2022-02-11 00:00:00 -> 20220211
      var targetDt = dt.toString().split(' ')[0].replaceAll('-', '');
      var movies = kobisApi.getDailyBoxOffice(targetDt: targetDt);
      showList(movies);
    }
  }

  // 화면 출력 메소드
  void showList(Future<List<dynamic>> movies) {
    setState(() {
      body = FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 미래에서 온 데이터가 있다면
            var movies = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, index) {
                  var rankColor = Colors.black;
                  if (index == 0) {
                    rankColor = Colors.red;
                  } else if (index == 1) {
                    rankColor = Colors.blue;
                  } else if (index == 2) {
                    rankColor = Colors.green;
                  }

                  return ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: rankColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        movies[index]['rank'],
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    title: Text(movies[index]['movieNm']),
                    subtitle: Text('${movies[index]['audiAcc']}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetail(movieCd: movies[index]['movieCd']),
                        )),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: movies!.length);
          } else {
            // 미래에서 온 데이터가 없다면
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: showCal,
        child: const Icon(Icons.calendar_month),
      ),
    );
  }
}
