import '../model/note.dart';

class NoteState {
  final List<Note> notes;
  final NoteCategory? selectedCategory;

  NoteState({required this.notes, this.selectedCategory});

  List<Note> get filteredNotes {
    final filtered = selectedCategory == null
        ? notes
        : notes.where((n) => n.category == selectedCategory).toList();
    filtered.sort((a, b) => (b.isPinned ? 1 : 0).compareTo(a.isPinned ? 1 : 0));
    return filtered;
  }

  NoteState copyWith({
    List<Note>? notes,
    NoteCategory? selectedCategory,
    bool overrideCategory = false,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      selectedCategory: overrideCategory ? selectedCategory : this.selectedCategory,
    );
  }
}
