import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../../data/models/note_model.dart';
import '../datasources/drive_remote_data_source.dart';

class NotesRepositoryImpl implements NotesRepository {
  final DriveNotesRemoteDataSource remote;

  NotesRepositoryImpl(this.remote);

  @override
  Future<List<Note>> getNotes() async {
    final files = await remote.listNotes();
    final notes = <Note>[];

    for (final file in files) {
      final content = await remote.getNoteContent(file.id!);
      notes.add(NoteModel.fromDriveFile(file, content: content));
    }

    return notes;
  }

  @override
  Future<void> createNote(String title, String content) {
    return remote.createNote(title, content);
  }

  @override
  Future<void> updateNote(String id, String title, String content) {
    return remote.updateNote(id, title, content);
  }

  @override
  Future<void> deleteNote(String id) {
    return remote.deleteNote(id);
  }
}
