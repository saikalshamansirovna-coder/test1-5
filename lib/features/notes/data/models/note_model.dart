import 'package:drift/drift.dart';

import '../../../../core/base/base_model.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/note_entity.dart';

class NoteModel extends BaseModel<NoteEntity> {
  final int id;
  final String title;
  final String content;
  final int animationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.animationId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Drift-строка -> модель
  factory NoteModel.fromRow(Note row) => NoteModel(
        id: row.id,
        title: row.title,
        content: row.content,
        animationId: row.animationId,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  /// Entity -> модель
  factory NoteModel.fromEntity(NoteEntity e) => NoteModel(
        id: e.id,
        title: e.title,
        content: e.content,
        animationId: e.animationId,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  /// Для INSERT: id не задаём, его выдаст autoIncrement
  NotesCompanion toInsertCompanion() => NotesCompanion.insert(
        title: title,
        content: content,
        animationId: Value(animationId),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Для UPDATE: createdAt не трогаем
  NotesCompanion toUpdateCompanion() => NotesCompanion(
        title: Value(title),
        content: Value(content),
        animationId: Value(animationId),
        updatedAt: Value(updatedAt),
      );

  @override
  NoteEntity toEntity() => NoteEntity(
        id: id,
        title: title,
        content: content,
        animationId: animationId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
