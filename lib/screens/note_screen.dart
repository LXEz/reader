import 'package:flutter/material.dart';
import 'note_detail_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Note> notes = [
    Note(
      title: '今日工作计划',
      content: '1. 完成项目文档\n2. 参加团队会议\n3. 代码审查',
      createTime: '2024-03-21',
    ),
    Note(
      title: '学习笔记',
      content: 'Flutter 状态管理方案对比：\n- Provider\n- Riverpod\n- Bloc',
      createTime: '2024-03-20',
    ),
    Note(
      title: '购物清单',
      content: '- 水果\n- 面包\n- 牛奶',
      createTime: '2024-03-19',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('笔记列表'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(notes[index].title),
              subtitle: Text(notes[index].createTime),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(
                      title: notes[index].title,
                      content: notes[index].content,
                      createTime: notes[index].createTime,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('添加新笔记'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: '标题'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: '内容'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  setState(() {
                    notes.insert(
                      0,
                      Note(
                        title: titleController.text,
                        content: contentController.text,
                        createTime: DateTime.now().toString().substring(0, 10),
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }
}

class Note {
  final String title;
  final String content;
  final String createTime;

  const Note({
    required this.title,
    required this.content,
    required this.createTime,
  });
}
