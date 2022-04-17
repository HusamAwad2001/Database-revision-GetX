import 'package:database_revision_getx/preferences/user_preferences.dart';
import 'package:database_revision_getx/screens/app/create_note_screen.dart';
import 'package:database_revision_getx/screens/app/launch_screen.dart';
import 'package:database_revision_getx/screens/app/notes_screen.dart';
import 'package:database_revision_getx/screens/auth/create_account_screen.dart';
import 'package:database_revision_getx/screens/auth/login_screen.dart';
import 'package:database_revision_getx/storage/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DbProvider().initDatabase();
  await UserPreferences().initPreferences();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('en')],
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/create_account_screen': (context) => CreateAccountScreen(),
        '/notes_screen': (context) => NotesScreen(),
        '/create_note_screen': (context) => CreateNoteScreen(),
      },
    );
  }
}
