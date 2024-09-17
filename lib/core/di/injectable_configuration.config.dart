// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_animations_example/core/networking/api_service.dart'
    as _i3;
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_cubit.dart'
    as _i5;
import 'package:flutter_animations_example/features/home_screen/data/repo/movies_loading_repository.dart'
    as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiService>(() => _i3.ApiService());
    gh.singleton<_i4.MoviesLoadingRepository>(
        () => _i4.MoviesLoadingRepository(gh<_i3.ApiService>()));
    gh.lazySingleton<_i5.MoviesLoadingCubit>(
        () => _i5.MoviesLoadingCubit(gh<_i4.MoviesLoadingRepository>()));
    return this;
  }
}
