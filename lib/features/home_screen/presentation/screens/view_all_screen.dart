import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/core/widgets/custom_back_button.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_screen_arguments.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_card_widget.dart';

class ViewAllScreen extends StatelessWidget {
  final List<Movie> moviesList;
  const ViewAllScreen({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const CustomBackButton(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: List.generate(moviesList.length, (index) {
                  if (index.isEven) {
                    return FadeInLeft(
                      child: MovieCardWidget(
                        movieScreenArgumentsModel: MovieScreenArgumentsModel(
                            moviesList: moviesList, selectedMovieIndex: index),
                      ),
                    );
                  }
                  return const VerticalSpace(verticalSpcae: 25);
                }),
              ),
              Column(
                children: List.generate(moviesList.length, (index) {
                  if (index.isOdd) {
                    return FadeInRightBig(
                      child: MovieCardWidget(
                        movieScreenArgumentsModel: MovieScreenArgumentsModel(
                            moviesList: moviesList, selectedMovieIndex: index),
                      ),
                    );
                  }
                  return const VerticalSpace(verticalSpcae: 25);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
