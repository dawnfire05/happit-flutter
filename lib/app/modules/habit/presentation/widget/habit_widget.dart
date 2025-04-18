import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_model.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/record_bloc.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';
import 'package:intl/intl.dart';

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
    return BlocProvider(
      create: (context) => sl<RecordBloc>()..add(RecordEvent.get(id)),
      child: Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                    child: BlocBuilder<RecordBloc, RecordState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          success: (records, status) =>
                              GitHubGrassWidget(records: records),
                          orElse: () => const CircularProgressIndicator(),
                        );
                      },
                    ),
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
                            icon: SvgPicture.asset(
                                'assets/icons/Arrow-Right.svg'),
                          ),
                        ),
                        BlocBuilder<RecordBloc, RecordState>(
                          builder: (context, state) {
                            return Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff66D271),
                              ),
                              child: IconButton(
                                onPressed: () => context
                                    .read<RecordBloc>()
                                    .add(const RecordEvent.check()),
                                icon: SvgPicture.asset(
                                  'assets/icons/Check.svg',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GitHubGrassWidget extends StatelessWidget {
  final int rows = 7;
  final int columns = 9;
  final List<RecordModel>? records;

  const GitHubGrassWidget({super.key, this.records});

  Color _getColor(String? state) {
    switch (state) {
      case "done":
        return Palette.primary;
      case "notDone":
        return Palette.white;
      case "skip":
        return const Color(0xfff1c40f);
      default:
        return Palette.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startOfGrid =
        today.subtract(Duration(days: rows * 8 + today.weekday));

    Map<String, String> dateStateMap = {};
    records?.forEach((record) {
      dateStateMap[record.date] = record.state;
    });

    return Row(
      children: List.generate(columns, (weekIndex) {
        return Column(
          children: List.generate(rows, (dayIndex) {
            DateTime currentDate =
                startOfGrid.add(Duration(days: weekIndex * 7 + dayIndex));
            String dateStr = DateFormat('yyyy-MM-dd').format(currentDate);
            String? state = dateStateMap[dateStr];

            return Tooltip(
              message: "$dateStr: ${state ?? '없음'}",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: currentDate.isBefore(today) ||
                          currentDate.isAtSameMomentAs(today)
                      ? _getColor(state)
                      : Colors.transparent,
                ),
                margin: const EdgeInsets.all(2.0),
                width: 20.0,
                height: 20.0,
              ),
            );
          }),
        );
      }),
    );
  }
}

// class GitHubGrassWidget extends StatelessWidget {
//   final int rows = 7;
//   final int columns = 9;

//   final List<RecordModel>? records;

//   const GitHubGrassWidget({super.key, this.records});

//   @override
//   Widget build(BuildContext context) {
//     // return Column(
//     //   children: List.generate(rows, (rowIndex) {
//     //     return Row(
//     //       children: List.generate(columns, (colIndex) {
//     //         return Container(
//     //           decoration: BoxDecoration(
//     //             borderRadius: BorderRadius.circular(4.0),
//     //             color: const Color(0xff66D271),
//     //           ),
//     //           margin: const EdgeInsets.all(2.0),
//     //           width: 20.0,
//     //           height: 20.0,
//     //         );
//     //       }),
//     //     );
//     //   }),
//     // );

//     final DateTime now = DateTime.now();
//     final weekdayOfToday = now.weekday;

//     return Row(
//       verticalDirection: VerticalDirection.down,
//       children: List.generate(columns, (colIndex) {
//         return Column(
//           children: List.generate(rows, (colIndex) {
//             return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4.0),
//                 color: const Color(0xff66D271),
//               ),
//               margin: const EdgeInsets.all(2.0),
//               width: 20.0,
//               height: 20.0,
//             );
//           }),
//         );
//       }),
//     );
//   }
// }
