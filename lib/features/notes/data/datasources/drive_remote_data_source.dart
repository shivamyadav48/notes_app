import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class DriveNotesRemoteDataSource {
  final _storage = const FlutterSecureStorage();

  /// Get authenticated HTTP client using stored access token
  Future<http.Client> _getAuthClient() async {
    final accessToken = await _storage.read(key: 'access_token');
    if (accessToken == null) throw Exception('No access token found');

    final authClient = authenticatedClient(
      http.Client(),
      AccessCredentials(
        AccessToken(
          'Bearer',
          accessToken,
          DateTime.now().toUtc().add(Duration(hours: 1)),
        ),
        null,
        ['https://www.googleapis.com/auth/drive.file'],
      ),
    );
    return authClient;
  }

  /// Get the Google Drive API instance
  Future<drive.DriveApi> _getDriveApi() async {
    final client = await _getAuthClient();
    return drive.DriveApi(client);
  }

  /// Get or create a folder named 'DriveNotes' in Google Drive
  Future<String> _getOrCreateDriveNotesFolder() async {
    final driveApi = await _getDriveApi();

    final response = await driveApi.files.list(
      q: "name = 'DriveNotes' and mimeType = 'application/vnd.google-apps.folder' and trashed = false",
    );
    final files = response.files;

    if (files != null && files.isNotEmpty) {
      return files.first.id!;
    }

    final folder = drive.File()
      ..name = 'DriveNotes'
      ..mimeType = 'application/vnd.google-apps.folder';

    final created = await driveApi.files.create(folder);
    return created.id!;
  }

  /// List all text/plain notes in 'DriveNotes' folder
  Future<List<drive.File>> listNotes() async {
    final driveApi = await _getDriveApi();
    final folderId = await _getOrCreateDriveNotesFolder();

    final files = await driveApi.files.list(
      q: "'$folderId' in parents and mimeType = 'text/plain' and trashed = false",
      $fields: 'files(id, name, createdTime, modifiedTime)',
    );
    return files.files ?? [];
  }

  /// Download and return note content as string
  Future<String> getNoteContent(String fileId) async {
    final driveApi = await _getDriveApi();
    final media = await driveApi.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    );

    if (media is drive.Media) {
      final bytes = await http.ByteStream(media.stream).toBytes();
      return utf8.decode(bytes);
    } else {
      throw Exception('Failed to download file: Unexpected response type');
    }
  }

  /// Create a new note in DriveNotes folder
  Future<void> createNote(String title, String content) async {
    final driveApi = await _getDriveApi();
    final folderId = await _getOrCreateDriveNotesFolder();

    final contentBytes = Uint8List.fromList(utf8.encode(content));
    final media = drive.Media(Stream.value(contentBytes), contentBytes.length);

    final file = drive.File()
      ..name = title
      ..parents = [folderId]
      ..mimeType = 'text/plain';

    await driveApi.files.create(file, uploadMedia: media);
  }

  /// Update existing note by fileId
  Future<void> updateNote(String fileId, String title, String newContent) async {
    final driveApi = await _getDriveApi();
    final file = drive.File()
      ..name = title; // This sets the title/name of the file

    // Prepare the content
    final contentBytes = Uint8List.fromList(utf8.encode(newContent));
    final media = drive.Media(Stream.value(contentBytes), contentBytes.length);

    // Update both metadata and content
    await driveApi.files.update(file, fileId, uploadMedia: media);
  }

  /// Delete a note by fileId
  Future<void> deleteNote(String fileId) async {
    final driveApi = await _getDriveApi();
    await driveApi.files.delete(fileId);
  }
}
