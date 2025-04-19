import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/app_exceptions.dart';


class LocalDataSource {
  static const String _notesKey = 'offline_notes';

  Future saveNoteOffline(String id, String title, String content) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notes = prefs.getStringList(_notesKey) ?? [];
      notes.add('$id|$title|$content');
      await prefs.setStringList(_notesKey, notes);
    } catch (e) {
      throw DriveException('Failed to save note offline: $e');
    }
  }

  Future<List<Map<String, String>>> getOfflineNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notes = prefs.getStringList(_notesKey) ?? [];
      return notes.map((note) {
        final parts = note.split('|');
        return {'id': parts[0], 'title': parts[1], 'content': parts[2]};
      }).toList();
    } catch (e) {
      throw DriveException('Failed to fetch offline notes: $e');
    }
  }

  Future clearOfflineNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_notesKey);
    } catch (e) {
      throw DriveException('Failed to clear offline notes: $e');
    }
  }
}
