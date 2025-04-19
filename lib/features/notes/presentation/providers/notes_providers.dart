import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/drive_remote_data_source.dart';
import '../../data/repositories/notes_repository_impl.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/create_note_usecase.dart';
import '../../domain/usecases/delete_note_usecase.dart';
import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/update_note_usecase.dart';

final _remoteDataSourceProvider =
    Provider((ref) => DriveNotesRemoteDataSource());
final _notesRepositoryProvider =
    Provider((ref) => NotesRepositoryImpl(ref.read(_remoteDataSourceProvider)));

final getNotesUseCaseProvider =
    Provider((ref) => GetNotesUseCase(ref.read(_notesRepositoryProvider)));

final createNoteUseCaseProvider =
    Provider((ref) => CreateNoteUseCase(ref.read(_notesRepositoryProvider)));

final updateNoteUseCaseProvider =
    Provider((ref) => UpdateNoteUseCase(ref.read(_notesRepositoryProvider)));

final deleteNoteUseCaseProvider =
    Provider((ref) => DeleteNoteUseCase(ref.read(_notesRepositoryProvider)));

final notesListProvider = FutureProvider<List<Note>>((ref) {
  final usecase = ref.read(getNotesUseCaseProvider);
  return usecase();
});
