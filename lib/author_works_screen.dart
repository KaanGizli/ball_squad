import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AuthorWorksScreen extends StatefulWidget {
  final String authorKey;

  const AuthorWorksScreen({Key? key, required this.authorKey})
      : super(key: key);

  @override
  _AuthorWorksScreenState createState() => _AuthorWorksScreenState();
}

class _AuthorWorksScreenState extends State<AuthorWorksScreen> {
  late Future<List<dynamic>> _worksFuture;

  @override
  void initState() {
    super.initState();
    _worksFuture = fetchWorks();
  }

  Future<List<dynamic>> fetchWorks() async {
    try {
      var response = await Dio().get(
          'https://openlibrary.org/authors/${widget.authorKey}/works.json');
      return response.data['entries'];
    } catch (e) {
      print(e);
      throw Exception('Failed to load works');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author\'s Works'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/bcknew.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: _worksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final works = snapshot.data!;
              return ListView.builder(
                itemCount: works.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(
                          works[index]['title'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
