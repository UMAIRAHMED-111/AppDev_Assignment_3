import 'package:flutter/material.dart';
import '../model/note.dart';
import '../widgets/chip.dart';

void showNoteDetailSheet(BuildContext context, Note note) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    backgroundColor: Colors.white,
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Chips(
                label: note.categoryText,
                color: note.color,
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            note.content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}
