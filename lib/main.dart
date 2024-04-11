import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ball_squad/cubit/author_search_cubit.dart';
import 'package:ball_squad/services/author_api.dart';
import 'package:ball_squad/author_works_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Author Search',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BlocProvider(
        create: (context) => AuthorSearchCubit(AuthorApi()), // AuthorApi nesnesini geçin
        child: const AuthorSearchPage(title: 'Author Search'),
      ),
    );
  }
}

class AuthorSearchPage extends StatelessWidget {
  const AuthorSearchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final AuthorSearchCubit _authorSearchCubit = BlocProvider.of<AuthorSearchCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'), // Arka plan fotoğrafının yolu
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Çerçeveli yuvarlak fotoğraf alanı
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.deepPurple, // Çerçeve rengi
                foregroundColor: Colors.black, // Çerçeve kenar rengi
                child: ClipOval(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/author_gifs/authors_gif.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Search by author name',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _authorSearchCubit.searchAuthor(_controller.text);
                },
                child: Text('Search'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<AuthorSearchCubit, AuthorSearchState>(
                  builder: (context, state) {
                    if (state is AuthorSearchLoading) {
                      return CircularProgressIndicator();
                    } else if (state is AuthorSearchLoaded) {
                      return Expanded(
                        child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black.withOpacity(0.3)),
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                        ),

                          child: ListView.builder(
                            itemCount: state.authors['docs'].length,
                            itemBuilder: (context, index) {
                              final author = state.authors['docs'][index];
                              return ListTile(
                                title: Text(author['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text('${author['birth_date']} / ${author['death_date']} - ${author['top_work']}' ),

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AuthorWorksScreen(authorKey: author['key']),
                                    ),
                                  );
                                },

                              );
                            },
                          ),
                        ),
                      );
                    } else if (state is AuthorSearchError) {
                      return Text(state.message);
                    }
                    return Container(); // Duruma göre boş bir container döndür
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
