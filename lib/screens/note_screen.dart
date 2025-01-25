import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('笔记列表'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: 0, // TODO: 实现笔记列表
        itemBuilder: (context, index) {
          return const Card(
            child: ListTile(
              title: Text('示例笔记'),
              subtitle: Text('2024-03-21'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 实现添加笔记功能
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
