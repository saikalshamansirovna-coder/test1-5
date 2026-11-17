import '../../../../core/base/base_usecase.dart';
import '../entities/note_entity.dart';
import '../repositories/note_repository.dart';

class GetNoteByIdUseCase extends BaseUseCase<NoteEntity?, int> {
  final NoteRepository repository;

  GetNoteByIdUseCase(this.repository);

  @override
  Future<NoteEntity?> call(int id) => repository.getById(id);
}
