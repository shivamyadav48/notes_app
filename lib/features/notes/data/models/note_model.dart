import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/note.dart';

part 'note_model.g.dart';

@JsonSerializable()
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

  ///  For local JSON storage
  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
