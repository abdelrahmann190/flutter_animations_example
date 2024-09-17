import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/routing/app_router.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_screen_arguments.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_poster_network_image.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieScreenArgumentsModel movieScreenArgumentsModel;
  const MovieCardWidget({
    super.key,
    required this.movieScreenArgumentsModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 300,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            AppRoutes.movieScreen,
            arguments: movieScreenArgumentsModel,
          );
        },
        child: buildCardWidget(context),
      ),
    );
  }

  Widget buildCardWidget(BuildContext context) {
    final movieModel = movieScreenArgumentsModel
        .moviesList[movieScreenArgumentsModel.selectedMovieIndex];
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildMovieCardWidget(movieModel),
        buildBlurContainer(),
        buildMovieTitleAndRaitingRow(movieModel, context),
      ],
    );
  }

  Card buildMovieCardWidget(Movie movieModel) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: MoviePosterNetworkImage(
          posterPath: movieModel.posterPath,
        ),
      ),
    );
  }

  Positioned buildBlurContainer() {
    return Positioned(
      bottom: 0,
      left: 4,
      right: 4,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: const VerticalSpace(verticalSpcae: 50),
        ),
      ),
    );
  }

  Positioned buildMovieTitleAndRaitingRow(
      Movie movieModel, BuildContext context) {
    return Positioned(
      left: 15,
      bottom: 15,
      right: 15,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 75,
            child: Text(
              movieModel.title ?? '',
              style: context.appTheme.textTheme.labelMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                movieModel.voteAverage!.toStringAsFixed(1),
                style: context.appTheme.textTheme.labelMedium,
              ),
              const HorizontalSpace(horizontalSpace: 5),
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ],
          )
        ],
      ),
    );
  }
}
