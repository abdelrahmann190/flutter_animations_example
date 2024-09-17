import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/routing/app_router.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_cubit.dart';
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_state.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/home_screen_section_header_widget.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movies_custom_carousel_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesCarouselBuilder extends StatelessWidget {
  const PopularMoviesCarouselBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: BlocBuilder<MoviesLoadingCubit, MoviesLoadingState>(
        buildWhen: (previous, current) => current.maybeWhen(
          loadingPopularMovies: () => true,
          popularMoviesLoadedSuccess: (moviesList) => true,
          popularMoviesLoadedFailure: (error) => true,
          orElse: () => false,
        ),
        builder: (context, state) {
          return state.maybeWhen(
            popularMoviesLoadedSuccess: (moviesList) {
              return buildSuccessWidget(context, moviesList);
            },
            loadingPopularMovies: () {
              return const CustomLoadingIndicator();
            },
            popularMoviesLoadedFailure: (error) {
              return Text(error);
            },
            orElse: () {
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  Column buildSuccessWidget(BuildContext context, List<Movie> moviesList) {
    return Column(
      children: [
        HomeScreenSectionHeaderWidget(
          label: 'Popular',
          onViewAllButtonPressed: () {
            context.pushNamed(
              AppRoutes.viewAllScreen,
              arguments: moviesList,
            );
          },
        ),
        const VerticalSpace(verticalSpcae: 15),
        Expanded(child: MoviesCustomCarouselWidget(moviesList: moviesList)),
      ],
    );
  }
}
