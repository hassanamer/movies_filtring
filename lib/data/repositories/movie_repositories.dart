import 'package:movies_filtring/data/model/movie_model.dart';
import 'package:movies_filtring/data/web_services/movies_web_services.dart';

class MovieRepository{
  late MovieWebServices movieWebServices;

  MovieRepository(this.movieWebServices);

  Future<List<MovieModel>> getAllMovies() async {
    final movies = await movieWebServices.getAllMovies();
    return movies.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}