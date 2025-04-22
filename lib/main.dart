import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/bloc.dart';
import 'blocs/event.dart'; 
import 'model/note.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(NoteCategoryAdapter());

  await Hive.openBox<Note>('notes');

  final noteBloc = NoteBloc();
  noteBloc.add(LoadNotes());

  runApp(
    BlocProvider(
      create: (_) => noteBloc,
      child: const NoteItApp(),
    ),
  );
}

class NoteItApp extends StatelessWidget {
  const NoteItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        canvasColor: Colors.white,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pink.shade200,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
