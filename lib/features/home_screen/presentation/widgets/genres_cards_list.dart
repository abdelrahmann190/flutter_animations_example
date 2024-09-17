import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';

class GenresCardsList extends StatelessWidget {
  final List<Genre>? genresList;
  const GenresCardsList({
    super.key,
    required this.genresList,
  });

  @override
  Widget build(BuildContext context) {
    if (genresList != null) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: genresList!
              .map(
                (genre) => GenreCard(genre: genre),
              )
              .toList(),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class GenreCard extends StatelessWidget {
  final Genre genre;
  const GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white24,
        ),
        child: Text(
          genre.name ?? '',
        ),
      ),
    );
  }
}
