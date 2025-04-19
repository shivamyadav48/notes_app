import '../entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Future<void> createNote(String title, String content);
  Future<void> updateNote(String id, String content);
  Future<void> deleteNote(String id);
}
