import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/record_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/record_bloc_cache.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/app/modules/habit/domain/theme_color.dart';
import 'package:happit_flutter/values/palette.dart';
import 'package:intl/intl.dart';

/// grassRecords에 RecordBloc의 오늘 상태를 반영. 낙관적 업데이트가 잔디에 바로 보이도록.
List<Record> _mergeTodayState(
  List<Record> grassRecords,
  int habitId,
  String todayStatus,
) {
  final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final hasToday = grassRecords.any((r) => r.date == todayStr);
  if (hasToday) {
    return grassRecords
        .map(
          (r) => r.date == todayStr
              ? Record(
                  id: r.id,
                  date: r.date,
                  state: todayStatus,
                  createdAt: r.createdAt,
                  updatedAt: r.updatedAt,
                )
              : r,
        )
        .toList();
  }
  return [
    ...grassRecords,
    Record(id: habitId, date: todayStr, state: todayStatus),
  ];
}

class HabitWidget extends StatelessWidget {
  final String name;
  final int id;

  /// 습관 테마 색상 (Hex #RRGGBB).
  final String themeColor;

  /// 잔디 API로 가져온 기록. 있으면 이걸로 그리드 표시, 없으면 RecordBloc 사용.
  final List<Record>? grassRecords;

  /// 토글 성공 시 호출 (잔디 목록 갱신용). grassRecords 사용 시에만 전달.
  final VoidCallback? onRecordToggled;

  const HabitWidget({
    super.key,
    required this.id,
    required this.name,
    required this.themeColor,
    this.grassRecords,
    this.onRecordToggled,
  });

  @override
  Widget build(BuildContext context) {
    final recordBloc = sl<RecordBlocCache>().getBloc(id);
    final habitColor = colorFromHex(themeColor) ?? Palette.primary;
    return BlocProvider.value(
      value: recordBloc,
      child: BlocListener<RecordBloc, RecordState>(
        listenWhen: (previous, current) {
          final prevStatus = previous.maybeWhen(
            success: (_, todayStatus) => todayStatus,
            orElse: () => null,
          );
          final currStatus = current.maybeWhen(
            success: (_, todayStatus) => todayStatus,
            orElse: () => null,
          );
          return prevStatus != null &&
              currStatus != null &&
              prevStatus != currStatus;
        },
        listener: (context, state) => onRecordToggled?.call(),
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
                      horizontal: 8,
                      vertical: 6,
                    ),
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
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: grassRecords != null
                            ? BlocBuilder<RecordBloc, RecordState>(
                                builder: (context, state) {
                                  // 오늘 칸만 RecordBloc 상태로 덮어서 낙관적 업데이트가 바로 반영되게 함
                                  final records = state.maybeWhen(
                                    success: (_, todayStatus) =>
                                        _mergeTodayState(
                                          grassRecords!,
                                          id,
                                          todayStatus,
                                        ),
                                    orElse: () => grassRecords,
                                  );
                                  return GitHubGrassWidget(
                                    records: records,
                                    doneColor: habitColor,
                                  );
                                },
                              )
                            : BlocBuilder<RecordBloc, RecordState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    success: (records, status) =>
                                        GitHubGrassWidget(
                                          records: records,
                                          doneColor: habitColor,
                                        ),
                                    orElse: () =>
                                        const CircularProgressIndicator(),
                                  );
                                },
                              ),
                      ),
                    ),
                    const SizedBox(width: 8),
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
                                'assets/icons/Arrow-Right.svg',
                              ),
                            ),
                          ),
                          BlocBuilder<RecordBloc, RecordState>(
                            builder: (context, state) {
                              return Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: habitColor,
                                ),
                                child: IconButton(
                                  onPressed: () => context
                                      .read<RecordBloc>()
                                      .add(RecordEvent.toggle(id)),
                                  icon: SvgPicture.asset(
                                    'assets/icons/Check.svg',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// GitHub 스타일 잔디: 열 = 주(week), 행 = 요일(일~토). 마지막 열은 오늘 요일까지만 표시.
/// 열 개수는 화면 너비에 맞춰 유동, 왼쪽 열은 fade out.
class GitHubGrassWidget extends StatelessWidget {
  static const double _cellSize = 20.0;
  static const double _cellMargin = 2.0;
  static const int _minWeeks = 4;
  static const int _maxWeeks = 20;
  static const double _minColumnOpacity = 0.35;

  static const _dayLabels = ['일', '월', '화', '수', '목', '금', '토'];

  final List<Record>? records;

  /// 잔디 'done' 셀 및 오늘 요일 라벨에 사용할 색상. null이면 [Palette.primary].
  final Color? doneColor;

  const GitHubGrassWidget({
    super.key,
    this.records,
    this.doneColor,
  });

  Color _getColor(String? state) {
    switch (state) {
      case "done":
        return doneColor ?? Palette.primary;
      case "notDone":
        return Palette.white;
      case "skip":
        return const Color(0xfff1c40f);
      default:
        return Palette.white;
    }
  }

  /// 한 열(주)이 차지하는 너비
  double get _columnWidth => _cellSize + 2 * _cellMargin;

  static const double _labelWidth = 12.0;

  /// 요일 라벨 + 간격이 차지하는 너비
  double get _labelAreaWidth => _labelWidth + 2;

  /// 가용 너비로 채울 수 있는 주(열) 개수
  int _columnCountForWidth(double maxWidth) {
    final forColumns = maxWidth - _labelAreaWidth;
    if (forColumns <= 0) return _minWeeks;
    final count = (forColumns / _columnWidth).floor();
    return count.clamp(_minWeeks, _maxWeeks);
  }

  /// 왼쪽(과거) 열일수록 낮은 opacity. weekIndex 0=가장 과거, totalWeeks-1=현재 주.
  double _opacityForColumn(int weekIndex, int totalWeeks) {
    if (totalWeeks <= 1) return 1.0;
    final t = weekIndex / (totalWeeks - 1);
    return _minColumnOpacity + (1.0 - _minColumnOpacity) * t;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todayRowIndex = today.weekday % 7;
    final startOfCurrentWeek = today.subtract(
      Duration(days: today.weekday % 7),
    );

    final dateStateMap = <String, String>{};
    for (final r in records ?? []) {
      dateStateMap[r.date] = r.state;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final totalWeeks = _columnCountForWidth(maxWidth);

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 요일 라벨 (일~토) - compact
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(7, (rowIndex) {
                return SizedBox(
                  width: _labelWidth,
                  height: _cellSize + 2 * _cellMargin,
                  child: Center(
                    child: Text(
                      _dayLabels[rowIndex],
                      style: TextStyle(
                        fontSize: 8,
                        height: 1.0,
                        color: rowIndex == todayRowIndex
                            ? (doneColor ?? Palette.primary)
                            : const Color(0xFF8D939D),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(width: 2),
            // 주 단위 열 (오래된 주 ← 현재 주), 왼쪽 열 fade out
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(totalWeeks, (weekIndex) {
                final weeksBack = totalWeeks - 1 - weekIndex;
                final startOfWeek = startOfCurrentWeek.subtract(
                  Duration(days: weeksBack * 7),
                );
                final isLastColumn = weekIndex == totalWeeks - 1;
                final rowCount = isLastColumn ? todayRowIndex + 1 : 7;
                final opacity = _opacityForColumn(weekIndex, totalWeeks);

                return Opacity(
                  opacity: opacity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(rowCount, (rowIndex) {
                      final cellDate = startOfWeek.add(
                        Duration(days: rowIndex),
                      );
                      final dateStr = DateFormat('yyyy-MM-dd').format(cellDate);
                      final state = dateStateMap[dateStr];
                      final isPastOrToday = !cellDate.isAfter(today);

                      return Tooltip(
                        message: '$dateStr: ${state ?? '없음'}',
                        child: Container(
                          width: _cellSize,
                          height: _cellSize,
                          margin: const EdgeInsets.all(_cellMargin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: isPastOrToday
                                ? _getColor(state)
                                : Colors.transparent,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}

// class GitHubGrassWidget extends StatelessWidget {
//   final int rows = 7;
//   final int columns = 9;

//   final List<Record>? records;

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
