import 'package:flutter/material.dart';

class CarouselAnimtaedDotIndicator extends StatefulWidget {
  final int carouselLength;
  final int currentIndex;
  const CarouselAnimtaedDotIndicator({
    super.key,
    required this.carouselLength,
    required this.currentIndex,
  });

  @override
  State<CarouselAnimtaedDotIndicator> createState() =>
      _CarouselAnimtaedDotIndicatorState();
}

class _CarouselAnimtaedDotIndicatorState
    extends State<CarouselAnimtaedDotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.carouselLength, (index) {
        final bool isCurrentItem = widget.currentIndex == index;
        return AnimatedContainer(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isCurrentItem ? Colors.blue : Colors.grey,
          ),
          height: 5,
          width: isCurrentItem ? 40 : 5,
          duration: const Duration(milliseconds: 200),
        );
      }),
    );
  }
}
