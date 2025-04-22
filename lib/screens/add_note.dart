import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import '../blocs/bloc.dart';
import '../blocs/event.dart';
import '../model/note.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  NoteCategory _category = NoteCategory.Work;

  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _category = widget.note!.category;
    }
    super.initState();
  }

  void showTopToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      left: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}


  void _saveNote() {
    if (_titleController.text.trim().isEmpty || _contentController.text.trim().isEmpty) {
      showTopToast(context, "Title and content cannot be empty");
      return;
    }


    final note = Note(
      id: widget.note?.id ?? const Uuid().v4(),
      title: _titleController.text,
      content: _contentController.text,
      category: _category,
    );

    final bloc = context.read<NoteBloc>();
    widget.note == null
        ? bloc.add(AddNote(note))
        : bloc.add(UpdateNote(note));

    Navigator.pop(context);
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFFFF8FA),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.note == null ? "Add Note" : "Edit Note"),
        leading: const BackButton(color: Colors.black),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: _inputDecoration("Title"),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: _inputDecoration("Content"),
            ),

            const SizedBox(height: 14),

            InputDecorator(
              decoration: _inputDecoration("Category"),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<NoteCategory>(
                  value: _category,
                  isExpanded: true,
                  items: NoteCategory.values.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c.name),
                    );
                  }).toList(),
                  onChanged: (c) => setState(() => _category = c!),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade100,
                  foregroundColor: Colors.black,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(widget.note == null ? "Save" : "Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
