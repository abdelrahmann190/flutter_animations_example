import 'package:flutter/material.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_api_results_model.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_poster_network_image.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/poster_video_player_widget.dart';

class MoviePosterWidget extends StatelessWidget {
  final MovieApiResultsModel movieApiResultsModel;
  const MoviePosterWidget({
    super.key,
    required this.movieApiResultsModel,
  });

  @override
  Widget build(BuildContext context) {
    return movieApiResultsModel.teaserVideoModel != null
        ? PosterVideoPlayerWidget(movieApirResultsModel: movieApiResultsModel)
        : MoviePosterNetworkImage(
            posterPath: movieApiResultsModel.movieModel.posterPath,
          );
  }
}
