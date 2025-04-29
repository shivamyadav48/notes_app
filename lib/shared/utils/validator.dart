class Validators {
  static String? validateNoteTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title can not be empty';
    }
    return null;
  }

  static String? validateNoteContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Note content can not be empty';
    }
    return null;
  }
}
