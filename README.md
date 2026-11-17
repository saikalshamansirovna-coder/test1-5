# Notes App

Clean Architecture + Bloc + Get-It + Drift + Lottie.

## Запуск
```
flutter create . --project-name notes_app --platforms=android,windows
flutter pub get
flutter run -d windows        # или -d <android-устройство>
```
`flutter create .` только добавляет папки платформ, файлы lib/ и pubspec.yaml не трогает.

Если нужно пересоздать Drift-код: `dart run build_runner build --delete-conflicting-outputs`

## Структура
- core/base — BaseUseCase<Type, Params>, BaseRepository<T, ID>, BaseModel<T> (Generics, BaseClasses)
- core/database — Drift (таблица Notes, AppDatabase)
- core/di — Get-It
- core/extensions — DateExtensions, StringExtensions, ContextExtensions, AnimationIdExtension
- features/notes/domain — entity, repository (интерфейс), use cases
- features/notes/data — model, local data source, repository impl
- features/notes/presentation — NotesBloc, страницы, виджеты (Lottie справа у заметки рядом с кнопкой удаления)
