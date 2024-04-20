import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'author_works_state.dart';

class AuthorWorksCubit extends Cubit<AuthorWorksState> {
  AuthorWorksCubit() : super(AuthorWorksInitial());

  Future<void> fetchWorks(String authorKey) async {
    emit(AuthorWorksLoading());
    try {
      var response = await Dio().get('https://openlibrary.org/authors/$authorKey/works.json');
      emit(AuthorWorksLoaded(response.data['entries']));
    } catch (e) {
      print(e);
      emit(AuthorWorksError('Failed to load works'));
    }
  }
}
