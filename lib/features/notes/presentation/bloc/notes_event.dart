import 'package:equatable/equatable.dart';

import '../../domain/entities/note_entity.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotesEvent extends NotesEvent {}

class CreateNoteEvent extends NotesEvent {
  final String title;
  final String content;
  final int animationId;

  const CreateNoteEvent({
    required this.title,
    required this.content,
    required this.animationId,
  });

  @override
  List<Object?> get props => [title, content, animationId];
}

class UpdateNoteEvent extends NotesEvent {
  final NoteEntity note;

  const UpdateNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NotesEvent {
  final int id;

  const DeleteNoteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
