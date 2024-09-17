import 'package:flutter/material.dart';
import 'package:flutter_animations_example/features/home_screen/data/models/movie_api_results_model.dart';
import 'package:flutter_animations_example/features/home_screen/presentation/widgets/movie_poster_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PosterVideoPlayerWidget extends StatefulWidget {
  final MovieApiResultsModel movieApirResultsModel;
  const PosterVideoPlayerWidget(
      {super.key, required this.movieApirResultsModel});

  @override
  State<PosterVideoPlayerWidget> createState() =>
      _PosterVideoPlayerWidgetState();
}

class _PosterVideoPlayerWidgetState extends State<PosterVideoPlayerWidget> {
  bool isVisible = true;
  late final controller = YoutubePlayerController(
    initialVideoId: widget.movieApirResultsModel.teaserVideoModel!.key ?? '',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildYoutubePlayer();
  }

  Widget buildOverLayPosterImage() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: MoviePosterNetworkImage(
          posterPath: widget.movieApirResultsModel.movieModel.posterPath,
        ),
      ),
    );
  }

  YoutubePlayer buildYoutubePlayer() {
    return YoutubePlayer(
      thumbnail: buildOverLayPosterImage(),
      aspectRatio: 2 / 1,
      controller: controller,
      bottomActions: const [],
      topActions: const [],
      onReady: () => setState(() {
        isVisible = !isVisible;
      }),
      onEnded: (metaData) => () => setState(() {
            isVisible = !isVisible;
          }),
      showVideoProgressIndicator: false,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
    );
  }
}
