import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  final double verticalSpcae;
  const VerticalSpace({super.key, required this.verticalSpcae});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: verticalSpcae,
    );
  }
}

class HorizontalSpace extends StatelessWidget {
  final double horizontalSpace;
  const HorizontalSpace({super.key, required this.horizontalSpace});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontalSpace,
    );
  }
}
