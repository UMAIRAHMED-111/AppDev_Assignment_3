import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
enum NoteCategory {
  @HiveField(0)
  Work,
  @HiveField(1)
  Personal,
  @HiveField(2)
  Study,
}

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final NoteCategory category;

  @HiveField(4)
  final bool isPinned;

  @HiveField(5)
  final String? imagePath;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.isPinned = false,
    this.imagePath,
  });

  Color get color {
    switch (category) {
      case NoteCategory.Work:
        return Colors.yellow.shade100;
      case NoteCategory.Personal:
        return Colors.blue.shade100;
      case NoteCategory.Study:
        return Colors.pink.shade100;
    }
  }

  String get categoryText {
    switch (category) {
      case NoteCategory.Work:
        return 'Work';
      case NoteCategory.Personal:
        return 'Personal';
      case NoteCategory.Study:
        return 'Study';
    }
  }
}
