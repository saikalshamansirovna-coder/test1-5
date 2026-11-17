import 'package:flutter/material.dart';

import '../../../../core/constants/app_animations.dart';
import '../../../../core/extensions/animation_extensions.dart';
import '../../../../core/extensions/context_extensions.dart';
import 'note_animation.dart';

/// Горизонтальный выбор одной из 5 анимаций.
class AnimationPicker extends StatelessWidget {
  final int selectedId;
  final ValueChanged<int> onSelected;

  const AnimationPicker({
    super.key,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: AppAnimations.ids.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final id = AppAnimations.ids[index];
          final selected = id == selectedId;
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => onSelected(id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 84,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: selected
                    ? context.colors.primaryContainer
                    : context.colors.surfaceContainerHighest,
                border: Border.all(
                  color: selected ? context.colors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NoteAnimation(animationId: id, size: 52),
                  const SizedBox(height: 4),
                  Text(
                    id.animationName,
                    style: context.theme.textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
