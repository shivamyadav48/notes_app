import 'package:drive_notes/features/notes/presentation/providers/notes_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  test('initial state of notesListProvider should be loading', () async {
    final container = ProviderContainer();

    final notes = container.read(notesListProvider);

    expect(notes, isA<AsyncValue>());
    expect(notes.isLoading, true);
  });
}
