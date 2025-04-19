import '../repositories/notes_repository.dart';

class CreateNoteUseCase {
  final NotesRepository repository;

  CreateNoteUseCase(this.repository);

  Future<void> call(String title, String content) {
    return repository.createNote(title, content);
  }
}
