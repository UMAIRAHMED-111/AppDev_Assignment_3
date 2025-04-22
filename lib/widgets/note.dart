import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/note.dart';
import '../screens/add_note.dart';
import '../screens/note_detail.dart';
import '../blocs/bloc.dart';
import '../blocs/event.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showNoteDetailSheet(context, note),
      child: Transform.rotate(
        angle: -0.08, 
        child: Container(
          constraints: const BoxConstraints(minHeight: 150), 
          decoration: BoxDecoration(
            color: note.color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(14, 14, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              Expanded(
                child: Text(
                  note.content,
                  style: const TextStyle(
                    fontSize: 13.2,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    note.categoryText,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          final updatedNote = Note(
                            id: note.id,
                            title: note.title,
                            content: note.content,
                            category: note.category,
                            isPinned: !note.isPinned,
                          );
                          context.read<NoteBloc>().add(UpdateNote(updatedNote));
                        },
                        child: Icon(
                          note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                          size: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),

    
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddNoteScreen(note: note),
                            ),
                          );
                        },
                        child: const Icon(Icons.edit, size: 16, color: Colors.black87),
                      ),
                      const SizedBox(width: 8),

     
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Delete Note?"),
                              content: const Text("Are you sure you want to delete this note?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<NoteBloc>().add(DeleteNote(note.id));
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Icon(Icons.delete, size: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
