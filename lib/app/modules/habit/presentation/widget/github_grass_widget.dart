import 'package:flutter/material.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/values/palette.dart';
import 'package:intl/intl.dart';

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
            _buildDayLabels(todayRowIndex),
            const SizedBox(width: 2),
            _buildWeekColumns(
              totalWeeks,
              startOfCurrentWeek,
              todayRowIndex,
              today,
              dateStateMap,
            ),
          ],
        );
      },
    );
  }

  /// 요일 라벨 (일~토) - compact
  Widget _buildDayLabels(int todayRowIndex) {
    return Column(
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
    );
  }

  /// 주 단위 열 (오래된 주 ← 현재 주), 왼쪽 열 fade out
  Widget _buildWeekColumns(
    int totalWeeks,
    DateTime startOfCurrentWeek,
    int todayRowIndex,
    DateTime today,
    Map<String, String> dateStateMap,
  ) {
    return Row(
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
          child: _buildWeekColumn(startOfWeek, rowCount, today, dateStateMap),
        );
      }),
    );
  }

  /// 한 주(열)의 셀들
  Widget _buildWeekColumn(
    DateTime startOfWeek,
    int rowCount,
    DateTime today,
    Map<String, String> dateStateMap,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rowCount, (rowIndex) {
        final cellDate = startOfWeek.add(Duration(days: rowIndex));
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
              color: isPastOrToday ? _getColor(state) : Colors.transparent,
            ),
          ),
        );
      }),
    );
  }
}
