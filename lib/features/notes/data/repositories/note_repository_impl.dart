import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_data_source.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl(this.localDataSource);

  @override
  Future<List<NoteEntity>> getAll() async {
    final models = await localDataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<NoteEntity?> getById(int id) async {
    final model = await localDataSource.getById(id);
    return model?.toEntity();
  }

  @override
  Future<void> add(NoteEntity item) =>
      localDataSource.insert(NoteModel.fromEntity(item));

  @override
  Future<void> update(NoteEntity item) =>
      localDataSource.update(NoteModel.fromEntity(item));

  @override
  Future<void> delete(int id) => localDataSource.delete(id);
}
