import 'package:flutter_animations_example/features/home_screen/data/models/cast_member_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/video_model.dart';

class MovieApiResultsModel {
  final Movie movieModel;
  final List<Movie> recommendedMoviesList;
  final List<CastMemberModel> castMembersList;
  final VideoModel? teaserVideoModel;

  MovieApiResultsModel({
    required this.movieModel,
    required this.recommendedMoviesList,
    required this.castMembersList,
    required this.teaserVideoModel,
  });
}
