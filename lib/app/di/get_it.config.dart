// GENERATED CODE - DO NOT MODIFY BY HAND

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
import 'package:happit_flutter/app/modules/auth/data/repository/auth_repository.dart'
    as _i825;
import 'package:happit_flutter/app/modules/auth/data/repository/token_repository.dart'
    as _i413;
import 'package:happit_flutter/app/modules/auth/data/repository/user_repository.dart'
    as _i643;
import 'package:happit_flutter/app/modules/auth/presentation/bloc/auth_bloc.dart'
    as _i1003;
import 'package:happit_flutter/app/modules/auth/presentation/bloc/sign_up_bloc.dart'
    as _i760;
import 'package:happit_flutter/app/modules/habit/data/repository/habit_repository.dart'
    as _i14;
import 'package:happit_flutter/app/modules/habit/data/repository/record_repository.dart'
    as _i418;
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_create_bloc.dart'
    as _i281;
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_edit_bloc.dart'
    as _i122;
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart'
    as _i837;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i558.FlutterSecureStorage>(
        () => registerModule.secureStorage);
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i825.AuthRepository>(
        () => _i825.AuthRepository(gh<_i361.Dio>()));
    gh.singleton<_i14.HabitRepository>(
        () => _i14.HabitRepository(gh<_i361.Dio>()));
    gh.singleton<_i418.RecordRepository>(
        () => _i418.RecordRepository(gh<_i361.Dio>()));
    await gh.singletonAsync<_i413.TokenRepository>(
      () {
        final i = _i413.TokenRepository(gh<_i558.FlutterSecureStorage>());
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i281.HabitCreateBloc>(
        () => _i281.HabitCreateBloc(gh<_i14.HabitRepository>()));
    gh.factory<_i122.HabitEditBloc>(
        () => _i122.HabitEditBloc(gh<_i14.HabitRepository>()));
    gh.factory<_i643.UserRepository>(() => _i643.UserRepository(
          gh<_i361.Dio>(),
          gh<_i413.TokenRepository>(),
        ));
    gh.singleton<_i846.AuthorizeInterceptor>(
        () => registerModule.authorizeInterceptor(
              gh<_i558.FlutterSecureStorage>(),
              gh<_i825.AuthRepository>(),
            ));
    gh.factory<_i1003.AuthBloc>(() => _i1003.AuthBloc(
          gh<_i825.AuthRepository>(),
          gh<_i643.UserRepository>(),
          gh<_i413.TokenRepository>(),
        ));
    gh.factory<_i837.HabitListBloc>(() => _i837.HabitListBloc(
          gh<_i14.HabitRepository>(),
          gh<_i643.UserRepository>(),
        ));
    gh.factory<_i760.SignUpBloc>(
        () => _i760.SignUpBloc(gh<_i643.UserRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i189.RegisterModule {}
