import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happit_flutter/widgets/bottom_navigation_bar.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'happit.',
              style: TextStyle(
                color: const Color(0xff56B45F),
                letterSpacing: Platform.isIOS ? -0.96 : 0,
                fontSize: 24,
                fontFamily: 'Montserrat Alternates',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(23, 20, 23, 20),
              decoration: ShapeDecoration(
                color: const Color(0xFFF0F2F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: SizedBox(
                          child: Text(
                            '독서',
                            style: TextStyle(
                              color: Color(0xFF1F2329),
                              fontSize: 18,
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              letterSpacing: -1.44,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          '연속 777일',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF56B45F),
                            fontSize: 14,
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w700,
                            height: 0,
                            letterSpacing: -1.12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: GitHubGrassWidget(),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: Column(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff8D939D),
                              ),
                              child: IconButton(
                                onPressed: () => {},
                                icon: SvgPicture.asset('assets/icons/Pen.svg'),
                              ),
                            ),
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff8D939D),
                              ),
                              child: IconButton(
                                onPressed: () => {},
                                icon: SvgPicture.asset('assets/icons/Pen.svg'),
                              ),
                            ),
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff8D939D),
                              ),
                              child: IconButton(
                                onPressed: () => {},
                                icon: SvgPicture.asset('assets/icons/Pen.svg'),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}

class GitHubGrassWidget extends StatelessWidget {
  final int rows = 7; // 세로 아이템 개수
  final int columns = 12; // 주간 수, 기본적으로 1년 52주

  // 임의의 색상 데이터 생성
  final List<List<Color>> data = List.generate(
    52,
    (i) => List.generate(
      7,
      (j) => Colors.primaries[(i + j) % Colors.primaries.length],
    ),
  );

  GitHubGrassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rows, (rowIndex) {
        return Row(
          children: List.generate(columns, (colIndex) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: data[colIndex][rowIndex],
              ),
              margin: const EdgeInsets.all(2.0),
              width: 20.0,
              height: 20.0,
            );
          }),
        );
      }),
    );
  }
}
