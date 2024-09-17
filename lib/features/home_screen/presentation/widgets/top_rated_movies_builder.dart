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

class TopRatedMoviesBuilder extends StatelessWidget {
  const TopRatedMoviesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesLoadingCubit, MoviesLoadingState>(
      buildWhen: (previous, current) => current.maybeWhen(
        loadingTopRatedMovies: () => true,
        topRatedMoviesLoadedSuccess: (moviesList) => true,
        topRatedMoviesLoadedFailure: (error) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return state.maybeWhen(
          loadingTopRatedMovies: () => const CustomLoadingIndicator(),
          topRatedMoviesLoadedSuccess: (moviesList) =>
              buildNewMoviesBuilder(moviesList, context),
          topRatedMoviesLoadedFailure: (error) => Text(error),
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
          label: 'Top Rated',
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
