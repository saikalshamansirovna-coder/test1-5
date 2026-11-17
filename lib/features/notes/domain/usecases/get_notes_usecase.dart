import '../../../../core/base/base_usecase.dart';
import '../entities/note_entity.dart';
import '../repositories/note_repository.dart';

class GetNotesUseCase extends BaseUseCase<List<NoteEntity>, NoParams> {
  final NoteRepository repository;

  GetNotesUseCase(this.repository);

  @override
  Future<List<NoteEntity>> call(NoParams params) => repository.getAll();
}
