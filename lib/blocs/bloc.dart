import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../model/note.dart';
import 'event.dart';
import 'state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final Box<Note> noteBox = Hive.box<Note>('notes');

  NoteBloc() : super(NoteState(notes: [])) {
    on<LoadNotes>((event, emit) {
      final notes = noteBox.values.toList();
      print("Notes persisted in Hive: ${notes.map((n) => n.title).toList()}");
      emit(state.copyWith(notes: notes));
    });

    on<AddNote>((event, emit) {
      noteBox.put(event.note.id, event.note);
      print("Note Added to Hive: ${event.note.title}");
      add(LoadNotes());
    });

    on<DeleteNote>((event, emit) {
      noteBox.delete(event.id);
      emit(state.copyWith(notes: noteBox.values.toList()));
    });

    on<UpdateNote>((event, emit) {
      noteBox.put(event.note.id, event.note);
      emit(state.copyWith(notes: noteBox.values.toList()));
    });

    on<FilterNotesByCategory>((event, emit) {
      emit(state.copyWith(
        selectedCategory: event.category,
        overrideCategory: true,
      ));
    });
  }
}
