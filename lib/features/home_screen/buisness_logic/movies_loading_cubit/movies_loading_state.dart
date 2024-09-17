import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_api_results_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_loading_state.freezed.dart';

@freezed
class MoviesLoadingState<T> with _$MoviesLoadingState<T> {
  const factory MoviesLoadingState.initial() = _Initial;

  /// Popular movies loading states
  const factory MoviesLoadingState.loadingPopularMovies() =
      _LoadingPopularMovies;
  const factory MoviesLoadingState.popularMoviesLoadedSuccess(
      List<Movie> moviesList) = _PopularMoviesLoadedSuccess;
  const factory MoviesLoadingState.popularMoviesLoadedFailure(String error) =
      _PopularMoviesLoadedFailure;

  /// Now playing movies loading states
  const factory MoviesLoadingState.loadingNowPlayingMovies() =
      _LoadingNowPlayingMovies;
  const factory MoviesLoadingState.nowPlayingMoviesLoadedSuccess(
      List<Movie> moviesList) = _NowPlayingMoviesLoadedSuccess;
  const factory MoviesLoadingState.nowPlayingMoviesLoadedFailure(String error) =
      _NowPlayingMoviesLoadedFailure;

  /// Upcoming movies loading states
  const factory MoviesLoadingState.loadingUpcomingMovies() =
      _LoadingUpcomingMovies;
  const factory MoviesLoadingState.upcomingMoviesLoadedSuccess(
      List<Movie> moviesList) = _UpcomingMoviesLoadedSuccess;
  const factory MoviesLoadingState.upcomingMoviesLoadedFailure(String error) =
      _UpcomingMoviesLoadedFailure;

  /// Upcoming movies loading states
  const factory MoviesLoadingState.loadingTopRatedMovies() =
      _LoadingTopRatedMovies;
  const factory MoviesLoadingState.topRatedMoviesLoadedSuccess(
      List<Movie> moviesList) = _TopRatedMoviesLoadedSuccess;
  const factory MoviesLoadingState.topRatedMoviesLoadedFailure(String error) =
      _TopRatedMoviesLoadedFailure;

  /// Movie details loading states
  const factory MoviesLoadingState.loadingMovieDetails() = _LoadingMovieDetails;
  const factory MoviesLoadingState.movieDetailsLoadedSuccess(
      MovieApiResultsModel movie) = _MovieDetailsLoadedSuccess;
  const factory MoviesLoadingState.movieDetailsLoadedFailure(String error) =
      _MovieDetailsLoadedFailure;
}
