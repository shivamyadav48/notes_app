class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdTime;
  final DateTime modifiedTime;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdTime,
    required this.modifiedTime,
  });
}
