import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../models/note_model.dart';

class NoteLocalDataSource {
  final AppDatabase db;

  NoteLocalDataSource(this.db);

  Future<List<NoteModel>> getAll() async {
    final query = db.select(db.notes)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);
    final rows = await query.get();
    return rows.map(NoteModel.fromRow).toList();
  }

  Future<NoteModel?> getById(int id) async {
    final row = await (db.select(db.notes)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : NoteModel.fromRow(row);
  }

  Future<void> insert(NoteModel model) async {
    await db.into(db.notes).insert(model.toInsertCompanion());
  }

  Future<void> update(NoteModel model) async {
    await (db.update(db.notes)..where((t) => t.id.equals(model.id)))
        .write(model.toUpdateCompanion());
  }

  Future<void> delete(int id) async {
    await (db.delete(db.notes)..where((t) => t.id.equals(id))).go();
  }
}
