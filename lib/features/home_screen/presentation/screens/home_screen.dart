import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/home_screen_header_widget.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/now_playing_movies_builder.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/popular_movies_carousel_builder.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/top_rated_movies_builder.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/upcoming_movies_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
            children: [
              HomeScreenHeaderWidget(),
              VerticalSpace(verticalSpcae: 5),
              PopularMoviesCarouselBuilder(),
              VerticalSpace(verticalSpcae: 15),
              UpcomingMoviesBuilder(),
              VerticalSpace(verticalSpcae: 15),
              TopRatedMoviesBuilder(),
              VerticalSpace(verticalSpcae: 15),
              NowPlayingMoviesBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
