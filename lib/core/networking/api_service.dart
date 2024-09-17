import 'package:flutter_animations_example/core/networking/api_constants.dart';
import 'package:flutter_animations_example/core/networking/dio_factory.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/cast_member_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_api_results_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/video_model.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_api/tmdb_api.dart';

@singleton
class ApiService {
  final TMDB tmdbWithCustomLogs = TMDB(
    dio: DioFactory.getDio(),
    ApiKeys(
      ApiConstants.apiKey,
      'apiReadAccessTokenv4',
    ),
  );

  Future<List<Movie>> getPopularMovies() async {
    final json = await tmdbWithCustomLogs.v3.movies.getPopular();

    final List popularMoviesList = json['results'];
    return _mapMoviesListThroughMovieModel(popularMoviesList);
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final json = await tmdbWithCustomLogs.v3.movies.getNowPlaying();

    final List nowPlayingMoviesList = json['results'];
    return _mapMoviesListThroughMovieModel(nowPlayingMoviesList);
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final json = await tmdbWithCustomLogs.v3.movies.getUpcoming();

    final List upcomingMoviesList = json['results'];
    return _mapMoviesListThroughMovieModel(upcomingMoviesList);
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final json = await tmdbWithCustomLogs.v3.movies.getTopRated();

    final List topRatedMoviesList = json['results'];
    return _mapMoviesListThroughMovieModel(topRatedMoviesList);
  }

  /// Get movie details depending on oon the movie id.
  /// Movie details function performs 3 api calls, for movie details cast members and recommended movies
  /// Returns null if the movie id is null.
  /// Returns MovieResultsModel if the movie id is not null.
  Future<MovieApiResultsModel?> getMovieDetails(int? movieId) async {
    if (movieId == null) {
      return null;
    }

    final movieDetailsModel = await _getMovieDetailsModelFromApi(movieId);
    final castMembersList = await _getCastMembersModelList(movieId);
    final recommendedMoviesList =
        await _getRecommendedMoviesListFromApi(movieId);
    final teaserVideoModel = await _getTeaserVideo(movieId);
    return MovieApiResultsModel(
      movieModel: movieDetailsModel,
      recommendedMoviesList: recommendedMoviesList,
      castMembersList: castMembersList,
      teaserVideoModel: teaserVideoModel,
    );
  }

  /// Fetches movie details from the API.
  Future<Movie> _getMovieDetailsModelFromApi(int movieId) async {
    final movieDetailsJson = await tmdbWithCustomLogs.v3.movies
        .getDetails(movieId) as Map<String, dynamic>;
    return Movie.fromJson(movieDetailsJson);
  }

  /// Fetches and maps the cast members list.
  Future<List<CastMemberModel>> _getCastMembersModelList(int movieId) async {
    final castMembersJson =
        await tmdbWithCustomLogs.v3.movies.getCredits(movieId);
    final List castMembersList = castMembersJson['cast'];
    return castMembersList
        .map((json) => CastMemberModel.fromJson(json))
        .toList();
  }

  Future<List<Movie>> _getRecommendedMoviesListFromApi(int movieId) async {
    final json = await tmdbWithCustomLogs.v3.movies.getSimilar(movieId);
    final List recommendedMoviesList = json['results'];
    return _mapMoviesListThroughMovieModel(recommendedMoviesList);
  }

  List<Movie> _mapMoviesListThroughMovieModel(List moviesList) {
    return moviesList.map((movieModel) => Movie.fromJson(movieModel)).toList();
  }

  Future<VideoModel?> _getTeaserVideo(int movieId) async {
    final videosList = await _getVideosList(movieId);
    if (videosList != null && videosList.isNotEmpty) {
      return videosList.first;
    }
    return null;
  }

  Future<List<VideoModel?>?> _getVideosList(int movieId) async {
    final json = await tmdbWithCustomLogs.v3.movies.getVideos(movieId);
    final List videosListJson = json['results'];

    return videosListJson
        .map((videoModel) => VideoModel.fromJson(videoModel))
        .toList();
  }
}
