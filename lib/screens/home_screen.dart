import 'package:flutter/material.dart';
import 'note_screen.dart';
import 'voice_to_text_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('学习助手'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '学习助手',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.note_add),
              title: const Text('笔记列表'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoteScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mic),
              title: const Text('语音记录'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VoiceToTextScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('欢迎使用学习助手！'),
      ),
    );
  }
}
