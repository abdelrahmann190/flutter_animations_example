import 'package:bloc/bloc.dart';
import 'package:flutter_animations_example/features/home_screen/buisness_logic/movies_loading_cubit/movies_loading_state.dart';
import 'package:flutter_animations_example/features/home_screen/data/repo/movies_loading_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MoviesLoadingCubit extends Cubit<MoviesLoadingState> {
  final MoviesLoadingRepository _moviesLoadingRepository;

  MoviesLoadingCubit(this._moviesLoadingRepository)
      : super(
          const MoviesLoadingState.initial(),
        ) {
    initialize();
  }

  @override
  // ignore: must_call_super
  Future<void> close() async {}

  void initialize() {
    getPopularMovies();
    getNowPlayingMovies();
    getUpcomingMovies();
    getTopRatedMovies();
  }

  void getPopularMovies() async {
    emit(
      const MoviesLoadingState.loadingPopularMovies(),
    );
    final apiResult = await _moviesLoadingRepository.getPopularMovies();
    apiResult.when(
      success: (moviesList) {
        emit(MoviesLoadingState.popularMoviesLoadedSuccess(moviesList));
      },
      failure: (error) {
        emit(
          MoviesLoadingState.popularMoviesLoadedFailure(
              error.apiErrorModel.message ??
                  error.apiErrorModel.code.toString()),
        );
      },
    );
  }

  void getUpcomingMovies() async {
    emit(
      const MoviesLoadingState.loadingUpcomingMovies(),
    );
    final apiResult = await _moviesLoadingRepository.getUpcomingMovies();
    apiResult.when(
      success: (moviesList) {
        emit(
          MoviesLoadingState.upcomingMoviesLoadedSuccess(moviesList),
        );
      },
      failure: (error) {
        emit(
          MoviesLoadingState.nowPlayingMoviesLoadedFailure(
              error.apiErrorModel.message ?? ''),
        );
      },
    );
  }

  void getTopRatedMovies() async {
    emit(
      const MoviesLoadingState.loadingTopRatedMovies(),
    );
    final apiResult = await _moviesLoadingRepository.getTopRatedMovies();
    apiResult.when(
      success: (moviesList) {
        emit(
          MoviesLoadingState.topRatedMoviesLoadedSuccess(moviesList),
        );
      },
      failure: (error) {
        emit(
          MoviesLoadingState.nowPlayingMoviesLoadedFailure(
              error.apiErrorModel.message ?? ''),
        );
      },
    );
  }

  void getNowPlayingMovies() async {
    emit(
      const MoviesLoadingState.loadingNowPlayingMovies(),
    );
    final apiResult = await _moviesLoadingRepository.getNowPlayingMovies();
    apiResult.when(
      success: (moviesList) {
        emit(
          MoviesLoadingState.nowPlayingMoviesLoadedSuccess(moviesList),
        );
      },
      failure: (error) {
        emit(
          MoviesLoadingState.nowPlayingMoviesLoadedFailure(
            error.apiErrorModel.message ?? '',
          ),
        );
      },
    );
  }

  void getMovieDetails(int? movieId) async {
    emit(
      const MoviesLoadingState.loadingMovieDetails(),
    );
    final apiResult = await _moviesLoadingRepository.getMovieDetails(movieId);
    apiResult.when(success: (movie) {
      emit(
        MoviesLoadingState.movieDetailsLoadedSuccess(
          movie,
        ),
      );
    }, failure: (error) {
      emit(
        MoviesLoadingState.movieDetailsLoadedFailure(
          error.apiErrorModel.message ?? error.apiErrorModel.code.toString(),
        ),
      );
    });
  }
}
