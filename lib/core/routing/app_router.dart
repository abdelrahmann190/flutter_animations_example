import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/di/injectable_configuration.dart';
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_cubit.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_screen_arguments.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/screens/home_screen.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/screens/movie_screen.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/screens/view_all_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => getIt<MoviesLoadingCubit>(),
              child: const HomeScreen(),
            );
          },
        );
      case AppRoutes.movieScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => getIt<MoviesLoadingCubit>(),
              child: MovieScreen(
                movieScreenArgumentsModel:
                    settings.arguments as MovieScreenArgumentsModel,
              ),
            );
          },
        );
      case AppRoutes.viewAllScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => getIt<MoviesLoadingCubit>(),
              child: ViewAllScreen(
                moviesList: settings.arguments as List<Movie>,
              ),
            );
          },
        );
      default:
        return null;
    }
  }
}

class AppRoutes {
  static const String homeScreen = '/homeScreen';
  static const String movieScreen = '/movieScreen';
  static const String viewAllScreen = '/viewAllScreen';
}
