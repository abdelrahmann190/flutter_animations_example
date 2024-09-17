import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/widgets/custom_icon_button.dart';

class HomeScreenHeaderWidget extends StatelessWidget {
  const HomeScreenHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Movies Portal',
              style: context.appTheme.textTheme.headlineMedium,
            ),
            const CustomIconButton(iconData: Icons.search),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
