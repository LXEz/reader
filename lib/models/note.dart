class Note {
  final int? id;
  final String title;
  final String content;
  final String createTime;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createTime': createTime,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createTime: map['createTime'],
    );
  }
}
