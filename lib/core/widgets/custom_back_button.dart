import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/extensions/build_context_extensions.dart';
import 'package:flutter_animations_example/core/widgets/custom_icon_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
        iconData: Icons.arrow_back_ios_new,
        onPressed: () {
          context.pop();
        });
  }
}
