import 'package:flutter/material.dart';
import 'package:reader/database/database_helper.dart';
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
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Row(
                  children: [
                    const Text(
                      '学习助手',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            final dbHelper = DatabaseHelper.instance;
                            await dbHelper.exportDatabase();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('数据库导出成功'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('数据库导出失败'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text("导出数据库"))
                  ],
                )),
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
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                try {
                  final dbHelper = DatabaseHelper.instance;
                  await dbHelper.exportDatabase();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('数据库导出成功'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('数据库导出失败'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
              child: const Text("导出数据库"))),
    );
  }
}
