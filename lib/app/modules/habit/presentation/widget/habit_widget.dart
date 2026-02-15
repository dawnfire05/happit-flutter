import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit_with_grass.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/record_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/record_bloc_cache.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/github_grass_widget.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/app/modules/habit/domain/theme_color.dart';
import 'package:happit_flutter/values/palette.dart';
import 'package:intl/intl.dart';

class HabitWidget extends StatelessWidget {
  final HabitWithGrass habitWithGrass;
  final VoidCallback onRecordToggled;

  const HabitWidget({
    super.key,
    required this.habitWithGrass,
    required this.onRecordToggled,
  });

  @override
  Widget build(BuildContext context) {
    final habit = habitWithGrass.habit;
    final habitColor = colorFromHex(habit.themeColor) ?? Palette.primary;

    return BlocProvider.value(
      value: sl<RecordBlocCache>().getBloc(habit.id),
      child: BlocListener<RecordBloc, RecordState>(
        listenWhen: _shouldNotifyToggle,
        listener: (context, state) => onRecordToggled(),
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
              _HabitHeader(
                name: habit.name,
                currentStreak: habit.currentStreak,
              ),
              const SizedBox(height: 16),
              _HabitContent(
                habitId: habit.id,
                habitColor: habitColor,
                grassRecords: habitWithGrass.grassRecords,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 토글 상태가 변경되었을 때만 리스너 호출
  bool _shouldNotifyToggle(RecordState previous, RecordState current) {
    final prevStatus = previous.maybeWhen(
      success: (_, todayStatus) => todayStatus,
      orElse: () => null,
    );
    final currStatus = current.maybeWhen(
      success: (_, todayStatus) => todayStatus,
      orElse: () => null,
    );
    return prevStatus != null && currStatus != null && prevStatus != currStatus;
  }
}

/// 습관 이름 + 연속 일수 헤더
class _HabitHeader extends StatelessWidget {
  final String name;
  final int currentStreak;

  const _HabitHeader({required this.name, required this.currentStreak});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
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
          child: Text(
            '연속 $currentStreak일',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF56B45F),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 0,
              letterSpacing: -1.12,
            ),
          ),
        ),
      ],
    );
  }
}

/// 잔디 그리드 + 액션 버튼들
class _HabitContent extends StatelessWidget {
  final int habitId;
  final Color habitColor;
  final List<Record>? grassRecords;

  const _HabitContent({
    required this.habitId,
    required this.habitColor,
    this.grassRecords,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildGrassArea()),
          const SizedBox(width: 8),
          _HabitActionButtons(habitId: habitId, habitColor: habitColor),
        ],
      ),
    );
  }

  /// 잔디 그리드 영역
  Widget _buildGrassArea() {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.centerLeft,
      child: grassRecords != null
          ? _buildGrassWithCache()
          : _buildGrassWithRecordBloc(),
    );
  }

  /// GrassBloc 데이터 + RecordBloc 오늘 상태 병합
  Widget _buildGrassWithCache() {
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (context, state) {
        final records = state.maybeWhen(
          success: (_, todayStatus) =>
              _mergeTodayState(grassRecords!, habitId, todayStatus),
          orElse: () => grassRecords,
        );
        return GitHubGrassWidget(records: records, doneColor: habitColor);
      },
    );
  }

  /// RecordBloc만 사용
  Widget _buildGrassWithRecordBloc() {
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (records, status) =>
              GitHubGrassWidget(records: records, doneColor: habitColor),
          orElse: () => const CircularProgressIndicator(),
        );
      },
    );
  }

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
}

/// 습관 액션 버튼들 (수정, 상세, 완료)
class _HabitActionButtons extends StatelessWidget {
  final int habitId;
  final Color habitColor;

  const _HabitActionButtons({required this.habitId, required this.habitColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildEditButton(context),
          _buildDetailButton(context),
          _buildCheckButton(context),
        ],
      ),
    );
  }

  /// 수정 버튼
  Widget _buildEditButton(BuildContext context) {
    return _ActionButton(
      color: const Color(0xff8D939D),
      iconPath: 'assets/icons/Pen.svg',
      onPressed: () => HabitEditRoute(habitId).push(context),
    );
  }

  /// 상세 버튼 (미구현)
  Widget _buildDetailButton(BuildContext context) {
    return _ActionButton(
      color: const Color(0xff8D939D),
      iconPath: 'assets/icons/Arrow-Right.svg',
      onPressed: () {},
    );
  }

  /// 완료 체크 버튼
  Widget _buildCheckButton(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (context, state) {
        return _ActionButton(
          color: habitColor,
          iconPath: 'assets/icons/Check.svg',
          onPressed: () =>
              context.read<RecordBloc>().add(RecordEvent.toggle(habitId)),
        );
      },
    );
  }
}

/// 공통 액션 버튼
class _ActionButton extends StatelessWidget {
  final Color color;
  final String iconPath;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.color,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: IconButton(onPressed: onPressed, icon: SvgPicture.asset(iconPath)),
    );
  }
}
