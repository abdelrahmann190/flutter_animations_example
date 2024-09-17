import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';

class MovieScreenArgumentsModel {
  final List<Movie> moviesList;
  final int selectedMovieIndex;

  MovieScreenArgumentsModel(
      {required this.moviesList, required this.selectedMovieIndex});
}
