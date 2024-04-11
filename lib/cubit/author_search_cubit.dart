import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ball_squad/services/author_api.dart';

part 'author_search_state.dart';

class AuthorSearchCubit extends Cubit<AuthorSearchState> {
  final AuthorApi _authorApi;

  AuthorSearchCubit(this._authorApi) : super(AuthorSearchInitial());

  void searchAuthor(String name) async {
    emit(AuthorSearchLoading());
    try {
      final authors = await _authorApi.searchAuthor(name);
      emit(AuthorSearchLoaded(authors));
    } catch (error) {
      print("Error while searching authors: $error");
      emit(AuthorSearchError("Failed to fetch authors."));
    }
  }
}
