import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/core/widgets/custom_back_button.dart';
import 'package:flutter_animations_example/core/widgets/custom_icon_button.dart';
import 'package:flutter_animations_example/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_cubit.dart';
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_state.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_api_results_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_screen_arguments.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/cast_members_cards_list.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/genres_cards_list.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_details_rating_row.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_poster_widget.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/recommended_movies_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieScreen extends StatefulWidget {
  final MovieScreenArgumentsModel movieScreenArgumentsModel;
  const MovieScreen({
    super.key,
    required this.movieScreenArgumentsModel,
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late final pageViewController = PageController(
      initialPage: widget.movieScreenArgumentsModel.selectedMovieIndex);

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initialFunction();
    super.initState();
  }

  void initialFunction() {
    context.read<MoviesLoadingCubit>().getMovieDetails(
          widget
              .movieScreenArgumentsModel
              .moviesList[widget.movieScreenArgumentsModel.selectedMovieIndex]
              .id,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      controller: pageViewController,
      itemCount: widget.movieScreenArgumentsModel.moviesList.length,
      onPageChanged: (value) {
        final movieId = widget.movieScreenArgumentsModel.moviesList[value].id;
        context.read<MoviesLoadingCubit>().getMovieDetails(movieId);
      },
      itemBuilder: (context, index) {
        return BlocBuilder<MoviesLoadingCubit, MoviesLoadingState>(
          buildWhen: (previous, current) => current.maybeWhen(
            loadingMovieDetails: () => true,
            movieDetailsLoadedSuccess: (movie) => true,
            movieDetailsLoadedFailure: (error) => true,
            orElse: () => false,
          ),
          builder: (context, state) {
            return state.maybeWhen(
              loadingMovieDetails: () => const CustomLoadingIndicator(),
              movieDetailsLoadedSuccess: (movieResultsModel) =>
                  buildMovieDetailsScreen(movieResultsModel, context),
              movieDetailsLoadedFailure: (error) => Text(error),
              orElse: () => const SizedBox.shrink(),
            );
          },
        );
      },
    ));
  }

  CustomScrollView buildMovieDetailsScreen(
      MovieApiResultsModel movieResultsModel, BuildContext context) {
    return CustomScrollView(
      cacheExtent: 0,
      slivers: [
        buildAppBar(movieResultsModel, context),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FadeInUp(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MovieDetailsRatingRow(
                          movieModel: movieResultsModel.movieModel),
                      const VerticalSpace(verticalSpcae: 15),
                      GenresCardsList(
                          genresList: movieResultsModel.movieModel.genres),
                      const VerticalSpace(verticalSpcae: 10),
                      CastMembersCardsList(
                          castMembersList: movieResultsModel.castMembersList),
                      const VerticalSpace(verticalSpcae: 10),
                      ...buildValidatedSection(
                          movieResultsModel.movieModel.overview, 'overview:'),
                      ...buildValidatedSection(
                          movieResultsModel.movieModel.releaseDate,
                          'release date:'),
                      ...buildValidatedSection(
                          movieResultsModel.movieModel.status, 'status:'),
                      ...buildValidatedSection(
                          movieResultsModel.movieModel.budget.toString(),
                          'budget:'),
                      ...buildValidatedSection(
                          movieResultsModel.movieModel.revenue.toString(),
                          'revenue:'),
                      ...buildValidatedSection(
                          movieResultsModel.movieModel.homepage, 'home page:'),
                      const VerticalSpace(verticalSpcae: 15),
                      Text(
                        'Recommended:',
                        style: context.appTheme.textTheme.headlineSmall,
                      ),
                      const VerticalSpace(verticalSpcae: 15),
                      RecommendedMoviesList(
                          recommendedMoviesList:
                              movieResultsModel.recommendedMoviesList),
                      const VerticalSpace(verticalSpcae: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildValidatedSection(String? data, String title) {
    if (data != null) {
      if (data.isNotEmpty) {
        return [
          Text(
            title,
            style: context.appTheme.textTheme.headlineSmall,
          ),
          const VerticalSpace(verticalSpcae: 15),
          Text(data),
          const VerticalSpace(verticalSpcae: 15),
          const Divider(),
          const VerticalSpace(verticalSpcae: 5),
        ];
      }
    }
    return [];
  }

  SliverAppBar buildAppBar(
      MovieApiResultsModel movieApiResultsModel, BuildContext context) {
    return SliverAppBar(
      leading: buildActionsBar(),
      leadingWidth: double.infinity,
      expandedHeight: 500,
      pinned: true,
      scrolledUnderElevation: 0,
      floating: false,
      flexibleSpace: buildFlexiblePosterWidget(movieApiResultsModel, context),
    );
  }

  Padding buildActionsBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeft(
            child: const CustomBackButton(),
          ),
          FadeInRight(
            child: const CustomIconButton(
              iconData: Icons.favorite,
            ),
          ),
        ],
      ),
    );
  }

  FlexibleSpaceBar buildFlexiblePosterWidget(
      MovieApiResultsModel movieApiResultsModel, BuildContext context) {
    return FlexibleSpaceBar(
      background: MoviePosterWidget(
        movieApiResultsModel: movieApiResultsModel,
      ),
      title: buildGradientWidget(context, movieApiResultsModel.movieModel),
      titlePadding: EdgeInsets.zero,
    );
  }

  Widget buildGradientWidget(BuildContext context, Movie movieModel) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.only(
          top: 25,
          left: 20,
        ),
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.appTheme.canvasColor,
              context.appTheme.canvasColor.withOpacity(0.0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: buildTitleWidget(movieModel, context),
      ),
    );
  }

  Row buildTitleWidget(Movie movieModel, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              movieModel.title ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: context.appTheme.colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
