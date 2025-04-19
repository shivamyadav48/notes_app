import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class GetNotesUseCase {
  final NotesRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<Note>> call() {
    return repository.getNotes();
  }
}
