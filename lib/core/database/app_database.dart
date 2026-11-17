import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'note_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'notes_db'));

  @override
  int get schemaVersion => 1;
}
