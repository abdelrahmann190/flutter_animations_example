import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/routing/app_router.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_screen_arguments.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_poster_network_image.dart';

class RecommendedMoviesList extends StatelessWidget {
  final List<Movie> recommendedMoviesList;
  const RecommendedMoviesList({super.key, required this.recommendedMoviesList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          recommendedMoviesList.length,
          (index) => RecommendedMovieCard(
            recommendedMoviesList: recommendedMoviesList,
            selectedMovieIndex: index,
          ),
        ),
      ),
    );
  }
}

class RecommendedMovieCard extends StatelessWidget {
  final List<Movie> recommendedMoviesList;
  final int selectedMovieIndex;
  const RecommendedMovieCard(
      {super.key,
      required this.recommendedMoviesList,
      required this.selectedMovieIndex});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: GestureDetector(
        onTap: () {
          context.pushReplacementNamed(AppRoutes.movieScreen,
              arguments: MovieScreenArgumentsModel(
                moviesList: recommendedMoviesList,
                selectedMovieIndex: selectedMovieIndex,
              ));
        },
        child: Container(
          padding: const EdgeInsets.only(right: 15),
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white24,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 75,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: MoviePosterNetworkImage(
                    posterPath:
                        recommendedMoviesList[selectedMovieIndex].posterPath,
                  ),
                ),
              ),
              const HorizontalSpace(horizontalSpace: 15),
              SizedBox(
                width: 150,
                child: Text(
                  recommendedMoviesList[selectedMovieIndex].title ?? '',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
