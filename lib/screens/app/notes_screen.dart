import 'package:database_revision_getx/getx_controller/notes_getx.dart';
import 'package:database_revision_getx/mixins/helpers.dart';
import 'package:database_revision_getx/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'NOTES',
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create_note_screen');
            },
            icon: const Icon(Icons.note_add),
          ),
          IconButton(
            onPressed: () async {
              await logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GetBuilder<NotesGetxController>(
        init: NotesGetxController(),
        builder: (NotesGetxController controller) {
          if (controller.notes.isNotEmpty) {
            return ListView.builder(
              itemCount: controller.notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.note),
                  title: Text(controller.notes[index].title),
                  subtitle: Text(
                      controller.notes[index].status == 1 ? 'Done' : 'Waiting'),
                  trailing: IconButton(
                    onPressed: () async {
                      await delete(controller.notes[index].id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () {},
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.grey.shade500,
                    size: 80,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future logout() async {
    bool status = await UserPreferences().logout();
    if (status) {
      // Provider.of<NotesProvider>(context, listen: false).clear();
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  Future delete(int id) async {
    // bool deleted =
    //     await Provider.of<NotesProvider>(context, listen: false).delete(id);
    bool deleted = await NotesGetxController.to.deleteNote(id);
    String message =
        deleted ? 'Note deleted successfully' : 'Failed to delete note';
    showSnackBar(context, message: message, error: !deleted);
  }
}
