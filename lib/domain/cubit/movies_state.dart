part of 'movies_cubit.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesLoaded extends MoviesState {
  final List<MovieModel> movies;

  MoviesLoaded(this.movies);
}
