import '../../domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.createdTime,
    required super.modifiedTime,
  });

  factory NoteModel.fromDriveFile(dynamic file, {String content = ''}) {
    return NoteModel(
      id: file.id ?? '',
      title: file.name ?? '',
      content: content,
      createdTime: (file.createdTime ?? DateTime.now()).toUtc(),
      modifiedTime: (file.modifiedTime ?? DateTime.now()).toUtc(),
    );
  }
}
