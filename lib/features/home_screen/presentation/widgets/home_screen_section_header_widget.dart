import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';

class HomeScreenSectionHeaderWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onViewAllButtonPressed;
  const HomeScreenSectionHeaderWidget(
      {super.key, required this.label, this.onViewAllButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.appTheme.textTheme.headlineSmall,
        ),
        TextButton(
          onPressed: onViewAllButtonPressed,
          child: const Text(
            'View all',
          ),
        ),
      ],
    );
  }
}
