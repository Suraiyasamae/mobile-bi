import 'dart:convert'; // สำหรับการจัดการ JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับการโหลดไฟล์
import 'search_page.dart';
import 'menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LibraryPage(),
        '/search': (context) => const SearchPage(),
        '/menu': (context) => const MenuPage(),
      },
    );
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<dynamic> books = [];

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    // โหลดข้อมูลจากไฟล์ JSON
    final String response = await rootBundle.loadString('assets/books.json');
    final data = await json.decode(response);
    setState(() {
      books = data['books'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Library',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton('Popular', screenWidth),
                const SizedBox(width: 20),
                _buildCategoryButton('Romance', screenWidth),
                const SizedBox(width: 20),
                _buildCategoryButton('Poetry', screenWidth),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: books.take(3).map((book) {
                return Container(
                  height: 180,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(book[
                          'coverImage']), // Use the cover image from the book data
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Books',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildSeeAllButton(screenWidth),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return BookListItem(
                    title: books[index]['title'],
                    author: books[index]['author'],
                    coverImage: books[index]['coverImage'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // ฟังก์ชันสำหรับกดปุ่ม Home
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.pushNamed(context, '/menu');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, double screenWidth) {
    bool isSelected = category == 'Romance';

    return Container(
      width: screenWidth * 0.25,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Color.fromARGB(255, 255, 255, 255)
            : const Color.fromARGB(255, 12, 12, 12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      alignment: Alignment.center,
      child: Text(
        category,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildBookCoverPlaceholder() {
    return Container(
      height: 121,
      width: 79,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Icon(
          Icons.book,
          color: Colors.black54,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildSeeAllButton(double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: const Text(
        'See all',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class BookListItem extends StatelessWidget {
  final String title;
  final String author;
  final String coverImage;

  const BookListItem({
    Key? key,
    required this.title,
    required this.author,
    required this.coverImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ภาพปกหนังสือ
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(coverImage), // ใช้ AssetImage สำหรับการแสดงภาพ
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ชื่อหนังสือ
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // ชื่อนักเขียน
                Text(
                  author,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  // ฟังก์ชั่นแก้ไข
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // ฟังก์ชั่นลบ
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
