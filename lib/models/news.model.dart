import 'dart:convert';

class NewsFirebase {
  final String content;
  final String date;
  final String description;
  final int id;
  final String image;
  final String title;
  final String url;

  NewsFirebase({
    required this.content,
    required this.date,
    required this.description,
    required this.id,
    required this.image,
    required this.title,
    required this.url,
  });

  factory NewsFirebase.fromRawJson(String str) =>
      NewsFirebase.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsFirebase.fromJson(Map<String, dynamic> json) => NewsFirebase(
        content: json["content"],
        date: json["date"],
        description: json["description"],
        id: json["id"],
        image: json["image"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "date": date,
        "description": description,
        "id": id,
        "image": image,
        "title": title,
        "url": url,
      };
}
