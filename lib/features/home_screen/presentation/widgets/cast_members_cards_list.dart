import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/theming/sizing/space_manager.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/cast_member_model.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_poster_network_image.dart';

class CastMembersCardsList extends StatelessWidget {
  final List<CastMemberModel> castMembersList;
  const CastMembersCardsList({
    super.key,
    required this.castMembersList,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: castMembersList
            .map((castMemberModel) =>
                CastMemberCard(castMemberModel: castMemberModel))
            .toList(),
      ),
    );
  }
}

class CastMemberCard extends StatelessWidget {
  final CastMemberModel castMemberModel;
  const CastMemberCard({super.key, required this.castMemberModel});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1200),
      delay: const Duration(milliseconds: 250),
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white24,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 75,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: MoviePosterNetworkImage(
                    posterPath: castMemberModel.profilePath),
              ),
            ),
            const HorizontalSpace(horizontalSpace: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(castMemberModel.name ?? ''),
                Text(
                  castMemberModel.character ?? '',
                  style: context.appTheme.textTheme.labelSmall!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
