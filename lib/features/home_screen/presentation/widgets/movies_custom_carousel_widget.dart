import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_screen_arguments.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/carousel_animated_dot_indicator.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_card_widget.dart';
import 'dart:math' as math;

import 'package:sensors_plus/sensors_plus.dart';

class MoviesCustomCarouselWidget extends StatefulWidget {
  final List<Movie> moviesList;
  const MoviesCustomCarouselWidget({
    super.key,
    required this.moviesList,
  });

  @override
  State<MoviesCustomCarouselWidget> createState() =>
      _MoviesCustomCarouselWidgetState();
}

class _MoviesCustomCarouselWidgetState
    extends State<MoviesCustomCarouselWidget> {
  final carouselLength = 7;
  final PageController _pageController = PageController(viewportFraction: 0.5);

  int currentIndex = 0;
  bool isCurrentIndex = false;
  double _tiltX = 0;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  @override
  void initState() {
    _initializeSensors();
    super.initState();
  }

  void _initializeSensors() {
    _gyroscopeSubscription =
        gyroscopeEventStream().listen((GyroscopeEvent event) {
      setState(() {
        // Adjust sensitivity here
        double newTiltX = _tiltX + event.y * 10;

        // Define thresholds to detect significant tilt changes
        if (newTiltX.abs() > 2.0) {
          _tiltX = newTiltX.clamp(-30.0, 30.0);
        }
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: carouselLength, // Number of cards
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              currentIndex = index;
            },
            itemBuilder: (context, index) {
              return _buildCard(index);
            },
          ),
        ),
        const VerticalSpace(verticalSpcae: 15),
        CarouselAnimtaedDotIndicator(
          carouselLength: carouselLength,
          currentIndex: currentIndex,
        ),
      ],
    );
  }

  Widget _buildCard(int index) {
    isCurrentIndex = currentIndex == index;
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;

        // Get the current scroll position of the PageView
        if (_pageController.position.haveDimensions) {
          // Calculate the relative position of each card to the center
          value = _pageController.page! - index;
        }

        // Reverse the direction of the tilt angle for both left and right cards
        double tiltAngle =
            (-value * math.pi / 8).clamp(-math.pi / 8, math.pi / 8);

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective effect
            ..rotateZ(tiltAngle), // Apply the reversed tilt angle
          alignment: FractionalOffset.center,
          child: buildMovieCardWidgetWithGyroscopeTransformEffect(index),
        );
      },
    );
  }

  Widget buildMovieCardWidgetWithGyroscopeTransformEffect(int index) {
    return Transform(
      transform: isCurrentIndex
          ? (Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(-pi / 180 * _tiltX))
          : Matrix4.identity(),
      alignment: FractionalOffset.center,
      child: MovieCardWidget(
        movieScreenArgumentsModel: MovieScreenArgumentsModel(
          moviesList: widget.moviesList,
          selectedMovieIndex: index,
        ),
      ),
    );
  }
}
