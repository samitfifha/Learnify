import 'package:intl/intl.dart';

class Thread {
  Thread(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.tag,
      this.comments});
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String tag;

  final List? comments;

  factory Thread.fromJson(Map<String, dynamic> data) {
    return Thread(
      id: data['_id'] as String,
      title: data['title'] as String,
      content: data['content'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      comments: data['comments'] as List?,
      tag: data['tag'] as String,
    );
  }
}
