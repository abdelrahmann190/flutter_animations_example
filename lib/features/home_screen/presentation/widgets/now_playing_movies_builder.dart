import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/routing/app_router.dart';
import 'package:flutter_animations_example/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_cubit.dart';
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_state.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/double_rows_movies_list_view.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/home_screen_section_header_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class NowPlayingMoviesBuilder extends StatelessWidget {
  const NowPlayingMoviesBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesLoadingCubit, MoviesLoadingState>(
      buildWhen: (previous, current) => current.maybeWhen(
        loadingNowPlayingMovies: () => true,
        nowPlayingMoviesLoadedSuccess: (moviesList) => true,
        nowPlayingMoviesLoadedFailure: (error) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return state.maybeWhen(
          loadingNowPlayingMovies: () => const CustomLoadingIndicator(),
          nowPlayingMoviesLoadedSuccess: (moviesList) =>
              buildNewMoviesBuilder(moviesList, context),
          nowPlayingMoviesLoadedFailure: (error) => Text(error),
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget buildNewMoviesBuilder(List<Movie> moviesList, BuildContext context) {
    return Column(
      children: [
        HomeScreenSectionHeaderWidget(
          label: 'New',
          onViewAllButtonPressed: () {
            context.pushNamed(
              AppRoutes.viewAllScreen,
              arguments: moviesList,
            );
          },
        ),
        FadeInUp(
          child: DoubleRowsMoviesListView(moviesList: moviesList),
        ),
      ],
    );
  }
}
