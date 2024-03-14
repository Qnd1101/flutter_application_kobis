import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: const Text(
          '박스오피스 화면으로\n이동해주세요',
          style: TextStyle(fontSize: 40),
        )),
      ),
    );
  }
}
