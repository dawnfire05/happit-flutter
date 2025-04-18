import 'package:flutter/material.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';
import 'package:happit_flutter/app/modules/habit/data/model/create_habit_model.dart';

class HabitCreatedScreen extends StatelessWidget {
  const HabitCreatedScreen(this.habit, {super.key});

  final CreateHabitModel habit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 48 - 20, top: 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '습관을 만들었어요',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -2.40,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '꾸준히 습관을 완료해 보세요!',
                    style: TextStyle(
                      color: Color(0xFF8C929D),
                      fontSize: 16,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1.28,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Palette.black20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              habit.name,
                              style: const TextStyle(
                                color: Color(0xFF725496),
                                fontSize: 18,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -1.44,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              decoration: ShapeDecoration(
                                color: Palette.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Text(
                                habit.repeatType,
                                style: const TextStyle(
                                  color: Palette.black100,
                                  fontSize: 16,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1.28,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              decoration: ShapeDecoration(
                                color: Palette.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: const Text(
                                '16 : 30',
                                style: TextStyle(
                                  color: Palette.black100,
                                  fontSize: 16,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1.28,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            MainButton.cta(
              text: '메인 화면으로',
              onPressed: () {
                const HabitListRoute().go(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
