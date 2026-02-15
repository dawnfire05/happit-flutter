// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:happit_flutter/app/di/authorize_interceptor.dart' as _i846;
import 'package:happit_flutter/app/di/get_it.dart' as _i189;
import 'package:happit_flutter/app/modules/auth/data/repository/auth_data_source.dart'
    as _i639;
import 'package:happit_flutter/app/modules/auth/data/repository/auth_repository_impl.dart'
    as _i570;
import 'package:happit_flutter/app/modules/auth/data/repository/token_repository.dart'
    as _i413;
import 'package:happit_flutter/app/modules/auth/data/repository/user_data_source.dart'
    as _i113;
import 'package:happit_flutter/app/modules/auth/domain/repository/auth_repository.dart'
    as _i403;
import 'package:happit_flutter/app/modules/auth/domain/usecase/get_current_user_use_case.dart'
    as _i942;
import 'package:happit_flutter/app/modules/auth/domain/usecase/logout_use_case.dart'
    as _i190;
import 'package:happit_flutter/app/modules/auth/domain/usecase/sign_in_use_case.dart'
    as _i135;
import 'package:happit_flutter/app/modules/auth/domain/usecase/sign_up_use_case.dart'
    as _i1017;
import 'package:happit_flutter/app/modules/auth/presentation/bloc/auth_bloc.dart'
    as _i1003;
import 'package:happit_flutter/app/modules/auth/presentation/bloc/sign_up_bloc.dart'
    as _i760;
import 'package:happit_flutter/app/modules/habit/data/repository/habit_data_source.dart'
    as _i1024;
import 'package:happit_flutter/app/modules/habit/data/repository/habit_repository_impl.dart'
    as _i332;
import 'package:happit_flutter/app/modules/habit/data/repository/record_data_source.dart'
    as _i296;
import 'package:happit_flutter/app/modules/habit/data/repository/record_repository_impl.dart'
    as _i430;
import 'package:happit_flutter/app/modules/habit/domain/repository/habit_repository.dart'
    as _i734;
import 'package:happit_flutter/app/modules/habit/domain/repository/record_repository.dart'
    as _i961;
import 'package:happit_flutter/app/modules/habit/domain/usecase/check_record_use_case.dart'
    as _i7;
import 'package:happit_flutter/app/modules/habit/domain/usecase/create_habit_use_case.dart'
    as _i55;
import 'package:happit_flutter/app/modules/habit/domain/usecase/delete_habit_use_case.dart'
    as _i389;
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_grass_use_case.dart'
    as _i664;
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_habit_use_case.dart'
    as _i460;
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_habits_use_case.dart'
    as _i508;
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_records_use_case.dart'
    as _i284;
import 'package:happit_flutter/app/modules/habit/domain/usecase/uncheck_record_use_case.dart'
    as _i104;
import 'package:happit_flutter/app/modules/habit/domain/usecase/update_habit_use_case.dart'
    as _i320;
import 'package:happit_flutter/app/modules/habit/presentation/bloc/grass_bloc.dart'
    as _i962;
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_create_bloc.dart'
    as _i735;
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_edit_bloc.dart'
    as _i248;
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart'
    as _i637;
import 'package:happit_flutter/app/modules/habit/presentation/bloc/record_bloc.dart'
    as _i778;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    await gh.singletonAsync<_i413.TokenRepository>(() {
      final i = _i413.TokenRepository(gh<_i558.FlutterSecureStorage>());
      return i.init().then((_) => i);
    }, preResolve: true);
    gh.singleton<_i639.AuthDataSource>(
      () => _i639.AuthDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i113.UserDataSource>(
      () => _i113.UserDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i1024.HabitDataSource>(
      () => _i1024.HabitDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i296.RecordDataSource>(
      () => _i296.RecordDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i403.AuthRepository>(
      () => _i570.AuthRepositoryImpl(
        gh<_i639.AuthDataSource>(),
        gh<_i113.UserDataSource>(),
        gh<_i413.TokenRepository>(),
      ),
    );
    gh.singleton<_i846.AuthorizeInterceptor>(
      () => registerModule.authorizeInterceptor(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i639.AuthDataSource>(),
      ),
    );
    gh.singleton<_i734.HabitRepository>(
      () => _i332.HabitRepositoryImpl(gh<_i1024.HabitDataSource>()),
    );
    gh.singleton<_i961.RecordRepository>(
      () => _i430.RecordRepositoryImpl(gh<_i296.RecordDataSource>()),
    );
    gh.lazySingleton<_i942.GetCurrentUserUseCase>(
      () => _i942.GetCurrentUserUseCase(gh<_i403.AuthRepository>()),
    );
    gh.lazySingleton<_i190.LogoutUseCase>(
      () => _i190.LogoutUseCase(gh<_i403.AuthRepository>()),
    );
    gh.lazySingleton<_i135.SignInUseCase>(
      () => _i135.SignInUseCase(gh<_i403.AuthRepository>()),
    );
    gh.lazySingleton<_i1017.SignUpUseCase>(
      () => _i1017.SignUpUseCase(gh<_i403.AuthRepository>()),
    );
    gh.factory<_i760.SignUpBloc>(
      () => _i760.SignUpBloc(gh<_i1017.SignUpUseCase>()),
    );
    gh.factory<_i1003.AuthBloc>(
      () => _i1003.AuthBloc(
        gh<_i135.SignInUseCase>(),
        gh<_i1017.SignUpUseCase>(),
        gh<_i942.GetCurrentUserUseCase>(),
        gh<_i190.LogoutUseCase>(),
      ),
    );
    gh.lazySingleton<_i55.CreateHabitUseCase>(
      () => _i55.CreateHabitUseCase(gh<_i734.HabitRepository>()),
    );
    gh.lazySingleton<_i389.DeleteHabitUseCase>(
      () => _i389.DeleteHabitUseCase(gh<_i734.HabitRepository>()),
    );
    gh.lazySingleton<_i460.GetHabitUseCase>(
      () => _i460.GetHabitUseCase(gh<_i734.HabitRepository>()),
    );
    gh.lazySingleton<_i508.GetHabitsUseCase>(
      () => _i508.GetHabitsUseCase(gh<_i734.HabitRepository>()),
    );
    gh.lazySingleton<_i320.UpdateHabitUseCase>(
      () => _i320.UpdateHabitUseCase(gh<_i734.HabitRepository>()),
    );
    gh.lazySingleton<_i7.CheckRecordUseCase>(
      () => _i7.CheckRecordUseCase(gh<_i961.RecordRepository>()),
    );
    gh.lazySingleton<_i664.GetGrassUseCase>(
      () => _i664.GetGrassUseCase(gh<_i961.RecordRepository>()),
    );
    gh.lazySingleton<_i284.GetRecordsUseCase>(
      () => _i284.GetRecordsUseCase(gh<_i961.RecordRepository>()),
    );
    gh.lazySingleton<_i104.UncheckRecordUseCase>(
      () => _i104.UncheckRecordUseCase(gh<_i961.RecordRepository>()),
    );
    gh.factory<_i962.GrassBloc>(
      () => _i962.GrassBloc(gh<_i664.GetGrassUseCase>()),
    );
    gh.factory<_i248.HabitEditBloc>(
      () => _i248.HabitEditBloc(
        gh<_i460.GetHabitUseCase>(),
        gh<_i320.UpdateHabitUseCase>(),
        gh<_i389.DeleteHabitUseCase>(),
      ),
    );
    gh.factory<_i735.HabitCreateBloc>(
      () => _i735.HabitCreateBloc(gh<_i55.CreateHabitUseCase>()),
    );
    gh.factory<_i637.HabitListBloc>(
      () => _i637.HabitListBloc(
        gh<_i508.GetHabitsUseCase>(),
        gh<_i664.GetGrassUseCase>(),
      ),
    );
    gh.factory<_i778.RecordBloc>(
      () => _i778.RecordBloc(
        gh<_i284.GetRecordsUseCase>(),
        gh<_i7.CheckRecordUseCase>(),
        gh<_i104.UncheckRecordUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i189.RegisterModule {}
