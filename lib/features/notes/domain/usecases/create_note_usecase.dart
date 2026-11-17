import '../../../../core/base/base_usecase.dart';
import '../entities/note_entity.dart';
import '../repositories/note_repository.dart';

class CreateNoteParams {
  final String title;
  final String content;
  final int animationId;

  const CreateNoteParams({
    required this.title,
    required this.content,
    required this.animationId,
  });
}

class CreateNoteUseCase extends BaseUseCase<void, CreateNoteParams> {
  final NoteRepository repository;

  CreateNoteUseCase(this.repository);

  @override
  Future<void> call(CreateNoteParams params) {
    final now = DateTime.now();
    return repository.add(
      NoteEntity(
        id: 0, // реальный id назначит база (autoIncrement)
        title: params.title,
        content: params.content,
        animationId: params.animationId,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }
}
