import '../constants/app_animations.dart';

extension AnimationIdExtension on int {
  String get lottiePath => AppAnimations.pathOf(this);

  String get animationName => AppAnimations.names[this] ?? 'Анимация $this';
}
