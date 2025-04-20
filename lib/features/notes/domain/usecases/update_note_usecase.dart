import '../repositories/notes_repository.dart';

class UpdateNoteUseCase {
  final NotesRepository repository;

  UpdateNoteUseCase(this.repository);

  Future<void> call(String id, String title, String content) {
    return repository.updateNote(id, title, content);
  }
}