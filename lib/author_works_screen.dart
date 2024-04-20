import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ball_squad/cubit/author_works_cubit.dart'; // AuthorWorksCubit dosyasını import ediyoruz

class AuthorWorksScreen extends StatelessWidget {
  final String authorKey;

  const AuthorWorksScreen({Key? key, required this.authorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author\'s Works'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bcknew.png'), // Arkaplan resminin yolu
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider(
          create: (context) => AuthorWorksCubit()..fetchWorks(authorKey), // AuthorWorksCubit'ı sağlıyoruz ve verileri getiriyoruz
          child: AuthorWorksList(),
        ),
      ),
    );
  }
}

class AuthorWorksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorWorksCubit, AuthorWorksState>(
      builder: (context, state) {
        if (state is AuthorWorksLoading) {
          // Yüklenme durumunda
          return Center(child: CircularProgressIndicator());
        } else if (state is AuthorWorksLoaded) {
          // Yükleme tamamlandığında
          return ListView.builder(
            itemCount: state.works.length,
            itemBuilder: (context, index) {
              final work = state.works[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      work['title'],
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
        } else if (state is AuthorWorksError) {
          // Hata durumunda
          return Center(child: Text('Error: ${state.message}'));
        } else {
          // Diğer durumlar için varsayılan bir durum
          return Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
