import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับโหลดไฟล์
import 'menu_page.dart'; // นำเข้าหน้า Menu

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> books = []; // รายการหนังสือ
  List<Map<String, dynamic>> filteredBooks =
      []; // รายการหนังสือที่กรองตามการค้นหา

  @override
  void initState() {
    super.initState();
    _loadBooks(); // โหลดข้อมูลหนังสือจากไฟล์
  }

  // ฟังก์ชันโหลดข้อมูลจาก books.json
  Future<void> _loadBooks() async {
    final String response = await rootBundle.loadString('assets/books.json');
    final data = await json.decode(response);
    setState(() {
      books = List<Map<String, dynamic>>.from(data['books']);
      filteredBooks = []; // เริ่มต้นให้ filteredBooks ว่างเปล่า
    });
  }

  // ฟังก์ชันกรองหนังสือที่ค้นหา
  void _filterBooks() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredBooks = books.where((book) {
        return book['title']!.toLowerCase().contains(query) ||
            book['author']!.toLowerCase().contains(query) ||
            book['category']!.toLowerCase().contains(query) ||
            book['ISBN']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // กลับไปยังหน้าหลัก
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // กล่องค้นหาที่มีมุมโค้งและไอคอนค้นหา
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey), // กำหนดสีกรอบ
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  _filterBooks(); // เรียกใช้งานฟังก์ชันกรองเมื่อมีการพิมพ์
                },
                decoration: InputDecoration(
                  labelText: 'Search...',
                  border: InputBorder.none, // ปิดกรอบใน TextField
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _filterBooks(); // เรียกใช้งานฟังก์ชันกรองเมื่อกดไอคอนค้นหา
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // แสดงรายการหนังสือที่กรองตามคำค้นหา
            if (filteredBooks.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: filteredBooks.length,
                  itemBuilder: (context, index) {
                    final book = filteredBooks[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      leading: Image.asset(
                        book['coverImage'], // แสดงภาพหน้าปกหนังสือ
                        width: 50,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                      title: Text(book['title']),
                      subtitle: Text(
                          '${book['author']} | ${book['category']} | ISBN: ${book['ISBN']}'),
                    );
                  },
                ),
              ),
            ] else if (_searchController.text.isNotEmpty) ...[
              // แสดงข้อความเมื่อไม่มีผลลัพธ์
              Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ],
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
                Navigator.popUntil(
                    context, ModalRoute.withName('/')); // กลับไปยังหน้า Home
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // ฟังก์ชันสำหรับกดปุ่ม Search
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MenuPage()), // เปลี่ยนไปยังหน้า Menu
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
