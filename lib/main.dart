import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noto/const.dart';
import 'package:noto/model/note_model.dart';
import 'package:noto/pages/notes_page.dart';
import 'package:noto/simple_bloc_observer.dart';
import 'add_notes_cubit.dart';
import 'pages/edit_note_page.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();
  await Hive.openBox<NoteModel>(kOpenNoteBox);
  Hive.registerAdapter(NoteModelAdapter());
  runApp(const NotoApp());
}

class NotoApp extends StatelessWidget {
  const NotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddNotesCubit()),
      ],
      child: MaterialApp(
        routes: {
          NotesPage.id: (context) => const NotesPage(),
          EditNotePage.id: (context) => const EditNotePage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Poppins',
        ),
        home: const NotesPage(),
      ),
    );
  }
}