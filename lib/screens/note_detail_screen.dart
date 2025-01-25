import 'package:flutter/material.dart';
import '../models/note.dart';
import '../database/database_helper.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;
  final Function? onUpdate;

  const NoteDetailScreen({
    super.key,
    required this.note,
    this.onUpdate,
    required String title,
    required String content,
    required String createTime,
  });

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEditing = false;
  final dbHelper = DatabaseHelper.instance;
  String _originalTitle = '';
  String _originalContent = '';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _originalTitle = widget.note.title;
    _originalContent = widget.note.content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_hasUnsavedChanges()) {
      final updatedNote = Note(
        id: widget.note.id,
        title: _titleController.text,
        content: _contentController.text,
        createTime: widget.note.createTime,
      );
      await dbHelper.updateNote(updatedNote);
      widget.onUpdate?.call();
    }
    return true;
  }

  bool _hasUnsavedChanges() {
    return _titleController.text != _originalTitle ||
        _contentController.text != _originalContent;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note.title),
          actions: [
            IconButton(
              icon: Icon(_isEditing ? Icons.save : Icons.edit),
              onPressed: () async {
                if (_isEditing) {
                  final updatedNote = Note(
                    id: widget.note.id,
                    title: _titleController.text,
                    content: _contentController.text,
                    createTime: widget.note.createTime,
                  );
                  await dbHelper.updateNote(updatedNote);
                  // setState(() {
                  //   widget.note=
                  // });
                  widget.onUpdate?.call();
                }
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                if (widget.note.id != null) {
                  await dbHelper.deleteNote(widget.note.id!);
                  widget.onUpdate?.call();
                  if (mounted) Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.note.createTime,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Expanded(
                  child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
