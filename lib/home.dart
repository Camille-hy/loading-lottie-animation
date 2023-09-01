import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool disposed = false;
  late Map<String, dynamic> postData = {};

  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 5));
    final url = 'https://jsonplaceholder.typicode.com/posts/1';
    try {
      final response = await http.get(Uri.parse(url));
      if (!disposed && response.statusCode == 200) {
        setState(() {
          postData = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Animation'),
      ),
      body: Center(
        child: isLoading
            ? Lottie.network(
                'https://lottie.host/45c92cbc-23fa-49ee-a902-4e732db2a518/JAHaPQKMp7.json',
                width: 200,
                height: 200,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User ID: ${postData['userId'] ?? ''}'),
                  Text('Post ID: ${postData['id'] ?? ''}'),
                  Text('Title: ${postData['title'] ?? ''}'),
                  Text('Body: ${postData['body'] ?? ''}'),
                ],
              ),
      ),
    );
  }
}
