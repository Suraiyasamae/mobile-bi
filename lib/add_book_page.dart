import 'dart:convert'; // สำหรับการจัดการ JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับการโหลดไฟล์

class AddBookPage extends StatelessWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // ฟอร์มสำหรับกรอกชื่อหนังสือ
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Book Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // ฟอร์มสำหรับกรอกชื่อนักเขียน
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Author Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // ฟังก์ชันสำหรับเลือกภาพ
                ElevatedButton(
                  onPressed: () {
                    // ฟังก์ชันที่ใช้สำหรับเพิ่มรูปภาพ
                    // เช่น ใช้ image picker
                  },
                  child: const Text('Choose Cover Image'),
                ),
                const SizedBox(height: 20),
                // ปุ่มสำหรับเพิ่มข้อมูล
                ElevatedButton(
                  onPressed: () {
                    // ฟังก์ชันสำหรับเพิ่มข้อมูลหนังสือ
                    // สามารถทำการจัดการข้อมูลที่กรอกไว้และบันทึก
                    Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
                  },
                  child: const Text('Add Book'),
                ),
                const SizedBox(height: 10),
                // ปุ่มสำหรับยกเลิก
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // ยกเลิกการเพิ่มและกลับไปยังหน้าก่อนหน้า
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
