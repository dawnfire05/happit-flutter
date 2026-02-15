String? errorCodeToMessage(String? errorCode) => switch (errorCode) {
  'INVALID_CREDENTIALS' => '아이디 또는 비밀번호가 올바르지 않습니다.',
  'INVALID_REFRESH_TOKEN' => '로그인이 만료되었습니다. 다시 로그인해주세요.',
  'FORBIDDEN_HABIT_ACCESS' => '해당 습관에 접근할 수 없습니다.',
  'FORBIDDEN_HABIT_UPDATE' => '해당 습관을 수정할 수 없습니다.',
  'FORBIDDEN_HABIT_DELETE' => '해당 습관을 삭제할 수 없습니다.',
  'DUPLICATE_EMAIL' => '이미 사용 중인 이메일입니다.',
  'DUPLICATE_USERNAME' => '이미 사용 중인 유저이름입니다.',
  _ => null,
};
