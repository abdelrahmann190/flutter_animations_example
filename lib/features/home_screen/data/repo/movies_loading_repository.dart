import 'package:flutter_animations_example/core/networking/api_result.dart';
import 'package:flutter_animations_example/core/networking/api_service.dart';
import 'package:flutter_animations_example/core/networking/error_handler.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_api_results_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class MoviesLoadingRepository {
  final ApiService _apiService;

  MoviesLoadingRepository(this._apiService);

  Future<ApiResult<List<Movie>>> getPopularMovies() async {
    try {
      final result = await _apiService.getPopularMovies();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<List<Movie>>> getUpcomingMovies() async {
    try {
      final result = await _apiService.getUpcomingMovies();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await _apiService.getNowPlayingMovies();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await _apiService.getTopRatedMovies();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<MovieApiResultsModel>> getMovieDetails(int? movieId) async {
    try {
      final result = await _apiService.getMovieDetails(movieId);
      return ApiResult.success(result!);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }
}
