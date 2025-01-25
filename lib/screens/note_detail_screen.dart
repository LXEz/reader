import 'package:flutter/material.dart';

class NoteDetailScreen extends StatefulWidget {
  final String title;
  final String content;
  final String createTime;
  final Function(String, String)? onUpdate;

  const NoteDetailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.createTime,
    this.onUpdate,
  });

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_isEditing) {
                widget.onUpdate?.call(
                  _titleController.text,
                  _contentController.text,
                );
              }
              setState(() {
                _isEditing = !_isEditing;
              });
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
              widget.createTime,
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
    );
  }
}
