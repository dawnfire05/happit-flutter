import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happit_flutter/routes/routes.dart';

class HabitWidget extends StatelessWidget {
  final String name;
  final int id;

  const HabitWidget({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Expanded(
                child: SizedBox(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Color(0xFF1F2329),
                      fontSize: 18,
                      fontFamily: 'Noto Sans KR',
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: -1.12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 168,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.transparent,
                  child: const GitHubGrassWidget(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff8D939D),
                        ),
                        child: IconButton(
                          onPressed: () => HabitEditRoute(id).push(context),
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
                          icon:
                              SvgPicture.asset('assets/icons/Arrow-Right.svg'),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff66D271),
                        ),
                        child: IconButton(
                          onPressed: () => {},
                          icon: SvgPicture.asset('assets/icons/Check.svg'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GitHubGrassWidget extends StatelessWidget {
  final int rows = 7;
  final int columns = 9;

  const GitHubGrassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rows, (rowIndex) {
        return Row(
          children: List.generate(columns, (colIndex) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: const Color(0xff66D271),
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
