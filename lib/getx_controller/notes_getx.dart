import 'package:database_revision_getx/controller/notes_db_controller.dart';
import 'package:database_revision_getx/model/note.dart';
import 'package:get/get.dart';

class NotesGetxController extends GetxController {
  static NotesGetxController get to => Get.find();
  List<Note> notes = <Note>[];
  final NotesDbController _notesDbController = NotesDbController();

  @override
  void onInit() {
    readNote();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    notes.clear();
    super.onClose();
  }

  Future<bool> createNote(Note note) async {
    int id = await _notesDbController.create(note);
    if (id != 0) {
      note.id = id;
      notes.add(note);
      update();
      return true;
    }
    return false;
  }

  Future<void> readNote() async {
    notes = await _notesDbController.read();
    update();
  }

  Future<bool> updateNote(Note updatedNote) async {
    bool updated = await _notesDbController.update(updatedNote);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == updatedNote.id);
      if (index != -1) {
        notes[index] = updatedNote;
        update();
      }
    }
    return false;
  }

  Future<bool> deleteNote(int id) async {
    bool deleted = await _notesDbController.delete(id);
    if (deleted) {
      // int index = notes.removeWhere((element) => element.id == id);
      int index = notes.indexWhere((element) => element.id == id);
      if (index != -1) {
        notes.removeAt(index);
        update();
        return true;
      }
    }
    return false;
  }

  // void clear(){
  //   // notes.clear();
  //   notes = [];
  // }

}
