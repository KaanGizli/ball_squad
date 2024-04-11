import 'package:equatable/equatable.dart';

part of 'author_search_cubit.dart'; // 'part of' direktifi en üstte olmalıdır

abstract class AuthorSearchState extends Equatable {
  const AuthorSearchState();

  @override
  List<Object> get props => [];
}

class AuthorSearchInitial extends AuthorSearchState {}

class AuthorSearchLoading extends AuthorSearchState {}

class AuthorSearchLoaded extends AuthorSearchState {
  final dynamic authors;
  const AuthorSearchLoaded(this.authors);

  @override
  List<Object> get props => [authors];
}

class AuthorSearchError extends AuthorSearchState {
  final String message;
  const AuthorSearchError(this.message);

  @override
  List<Object> get props => [message];
}
