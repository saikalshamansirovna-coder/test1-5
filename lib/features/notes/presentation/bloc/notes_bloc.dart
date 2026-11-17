import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_usecase.dart';

import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/create_note_usecase.dart';
import '../../domain/usecases/update_note_usecase.dart';
import '../../domain/usecases/delete_note_usecase.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUseCase getNotesUseCase;
  final CreateNoteUseCase createNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;

  NotesBloc({
    required this.getNotesUseCase,
    required this.createNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
  }) : super(NotesInitial()) {
    on<LoadNotesEvent>((event, emit) async {
      await loadNotes(emit);
    });

    on<CreateNoteEvent>((event, emit) async {
      try {
        await createNoteUseCase(
          CreateNoteParams(
            title: event.title,
            content: event.content,
            animationId: event.animationId,
          ),
        );

        await loadNotes(emit);
      } catch (e) {
        emit(NotesError(e.toString()));
      }
    });

    on<UpdateNoteEvent>((event, emit) async {
      try {
        await updateNoteUseCase(event.note);
        await loadNotes(emit);
      } catch (e) {
        emit(NotesError(e.toString()));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      try {
        await deleteNoteUseCase(event.id);
        await loadNotes(emit);
      } catch (e) {
        emit(NotesError(e.toString()));
      }
    });
  }

  Future<void> loadNotes(Emitter<NotesState> emit) async {
    emit(NotesLoading());

    try {
      final notes = await getNotesUseCase(NoParams());
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
