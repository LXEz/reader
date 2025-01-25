import 'package:flutter/material.dart';
import 'package:reader/models/note.dart';
import 'note_screen.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Note? _createNote() {
    if (_titleController.text.isNotEmpty ||
        _contentController.text.isNotEmpty) {
      return Note(
        title: _titleController.text.isEmpty ? '无标题' : _titleController.text,
        content: _contentController.text,
        createTime: DateTime.now().toString().split(' ')[0],
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final note = _createNote();
        Navigator.pop(context, note);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('添加笔记'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '标题',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: '内容',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final note = _createNote();
                  if (note != null) {
                    Navigator.pop(context, note);
                  }
                },
                child: const Text('保存'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
