import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Book {
  final String title;
  final String author;
  final String coverImage;

  Book({required this.title, required this.author, required this.coverImage});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      coverImage: json['coverImage'],
    );
  }
}

Future<List<Book>> loadBooks() async {
  final String response = await rootBundle.loadString('assets/books.json');
  final data = await json.decode(response);
  return (data['books'] as List).map((book) => Book.fromJson(book)).toList();
}
