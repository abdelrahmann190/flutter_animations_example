import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_screen_arguments.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_card_widget.dart';

class DoubleRowsMoviesListView extends StatelessWidget {
  final List<Movie> moviesList;
  const DoubleRowsMoviesListView({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 615,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: moviesList.length ~/ 2,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (secIndex) {
              return ZoomIn(
                child: SizedBox(
                  width: 180,
                  height: 300,
                  child: MovieCardWidget(
                    movieScreenArgumentsModel: MovieScreenArgumentsModel(
                      moviesList: moviesList,
                      selectedMovieIndex:
                          secIndex.isEven ? index * 2 : (index * 2 + 1),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
