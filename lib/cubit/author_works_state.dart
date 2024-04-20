import 'package:equatable/equatable.dart';

part of 'author_works_cubit.dart';

abstract class AuthorWorksState extends Equatable {
  const AuthorWorksState();

  @override
  List<Object?> get props => [];
}

class AuthorWorksInitial extends AuthorWorksState {}

class AuthorWorksLoading extends AuthorWorksState {}

class AuthorWorksLoaded extends AuthorWorksState {
  final List<dynamic> works;

  const AuthorWorksLoaded(this.works);

  @override
  List<Object?> get props => [works];
}

class AuthorWorksError extends AuthorWorksState {
  final String message;

  const AuthorWorksError(this.message);

  @override
  List<Object?> get props => [message];
}
