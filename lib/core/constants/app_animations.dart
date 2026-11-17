/// Список из 5 Lottie-анимаций, доступных для прикрепления к заметке.
class AppAnimations {
  AppAnimations._();

  static const int defaultId = 1;

  static const List<int> ids = [1, 2, 3, 4, 5];

  static const Map<int, String> names = {
    1: 'Пульс',
    2: 'Звезда',
    3: 'Мяч',
    4: 'Квадрат',
    5: 'Сердце',
  };

  static String pathOf(int id) => 'assets/lottie/animation_${ids.contains(id) ? id : defaultId}.json';
}
