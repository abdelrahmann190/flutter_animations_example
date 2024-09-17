import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/helpers/date_time_helper.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_model.dart';

class MovieDetailsRatingRow extends StatelessWidget {
  final Movie movieModel;
  const MovieDetailsRatingRow({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildTextWidget(movieModel.voteAverage!.toStringAsFixed(1), context),
        const HorizontalSpace(horizontalSpace: 5),
        const Icon(
          Icons.star,
          color: Colors.grey,
          size: 15,
        ),
        const HorizontalSpace(horizontalSpace: 5),
        buildTextWidget(
            '${DateTimeHelper.formatMinutesString(movieModel.runtime)} - ${DateTime.parse(movieModel.releaseDate!).year}',
            context),
      ],
    );
  }

  buildTextWidget(String text, BuildContext context) {
    return Text(text,
        style: context.appTheme.textTheme.labelMedium!
            .copyWith(color: Colors.grey));
  }
}
