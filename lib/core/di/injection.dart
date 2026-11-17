import 'package:get_it/get_it.dart';

import '../database/app_database.dart';

import '../../features/notes/data/datasources/note_local_data_source.dart';
import '../../features/notes/data/repositories/note_repository_impl.dart';

import '../../features/notes/domain/repositories/note_repository.dart';

import '../../features/notes/domain/usecases/get_notes_usecase.dart';
import '../../features/notes/domain/usecases/get_note_by_id_usecase.dart';
import '../../features/notes/domain/usecases/create_note_usecase.dart';
import '../../features/notes/domain/usecases/update_note_usecase.dart';
import '../../features/notes/domain/usecases/delete_note_usecase.dart';

import '../../features/notes/presentation/bloc/notes_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Data Source
  getIt.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSource(getIt<AppDatabase>()),
  );

  // Repository
  getIt.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(getIt<NoteLocalDataSource>()),
  );

  // Use Cases
  getIt.registerFactory(() => GetNotesUseCase(getIt<NoteRepository>()));

  getIt.registerFactory(() => GetNoteByIdUseCase(getIt<NoteRepository>()));

  getIt.registerFactory(() => CreateNoteUseCase(getIt<NoteRepository>()));

  getIt.registerFactory(() => UpdateNoteUseCase(getIt<NoteRepository>()));

  getIt.registerFactory(() => DeleteNoteUseCase(getIt<NoteRepository>()));

  // Bloc
  getIt.registerFactory(
    () => NotesBloc(
      getNotesUseCase: getIt<GetNotesUseCase>(),
      createNoteUseCase: getIt<CreateNoteUseCase>(),
      updateNoteUseCase: getIt<UpdateNoteUseCase>(),
      deleteNoteUseCase: getIt<DeleteNoteUseCase>(),
    ),
  );
}
