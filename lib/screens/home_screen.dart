import 'package:flutter/material.dart';
import 'package:reader/database/database_helper.dart';
import 'note_screen.dart';
import 'voice_to_text_screen.dart';
import 'package:reader/services/notification_service.dart';

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
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('设置提醒'),
              onTap: () {
                _showNotificationDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notification_important),
              title: const Text('立即提醒'),
              onTap: () {
                NotificationService.instance.showNotification(
                  id: 2,
                  title: '学习提醒',
                  body: '该复习笔记了！',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('已发送通知'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                NotificationService.instance.showNotification(
                  id: 2,
                  title: '这是一个测试 notification ',
                  body: '该复习笔记了！',
                );
              },
              child: const Text("展示一个notification"))),
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime != null) {
        final now = DateTime.now();
        var scheduledDate = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // 如果选择的时间已经过去，就设置为明天的这个时间
        if (scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }

        NotificationService.instance.scheduleNotification(
          id: 1,
          title: '学习提醒',
          body: '该复习笔记了！',
          scheduledDate: scheduledDate,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('提醒已设置为 ${selectedTime.format(context)}'),
          ),
        );
      }
    });
  }
}
