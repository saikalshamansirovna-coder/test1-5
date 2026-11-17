import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/extensions/animation_extensions.dart';

/// Показывает одну из 5 Lottie-анимаций по её id.
class NoteAnimation extends StatelessWidget {
  final int animationId;
  final double size;
  final bool animate;

  const NoteAnimation({
    super.key,
    required this.animationId,
    this.size = 48,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        animationId.lottiePath,
        repeat: true,
        animate: animate,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => const Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
