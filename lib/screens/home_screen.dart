import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/bloc.dart';
import '../blocs/state.dart';
import '../widgets/note.dart';
import '../widgets/category_dropdown.dart';
import 'add_note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FF), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F4FF),
        elevation: 0,
        title: const Text(
          "NoteIt",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: Category(),
          )
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          final notes = state.filteredNotes;
          if (notes.isEmpty) {
            return const Center(
              child: Text(
                "No notes available",
                style: TextStyle(color: Colors.black54),
              ),
            );
          }
          return GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1,
            children: notes.map((note) => NoteCard(note: note)).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 249, 178, 202),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
