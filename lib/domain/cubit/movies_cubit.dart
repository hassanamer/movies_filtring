import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_filtring/data/model/movie_model.dart';
import 'package:movies_filtring/data/repositories/movie_repositories.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MovieRepository movieRepository;
   List<MovieModel> movies = [];
  MoviesCubit(this.movieRepository) : super(MoviesInitial());
  List<MovieModel> getAllMovies(){
    movieRepository.getAllMovies().then((movies) {
      emit(MoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
