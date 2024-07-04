import 'package:flutter/material.dart';
import 'package:movies_filtring/constants/strings.dart';
import 'package:movies_filtring/data/model/movie_model.dart';
import 'package:movies_filtring/data/repositories/movie_repositories.dart';
import 'package:movies_filtring/data/web_services/movies_web_services.dart';
import 'package:movies_filtring/domain/cubit/movies_cubit.dart';
import 'package:movies_filtring/presentation/screens/movies_details_screen.dart';
import 'package:movies_filtring/presentation/screens/movies_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late MovieRepository movieRepository;
  late MoviesCubit moviesCubit;

  AppRouter() {
    movieRepository = MovieRepository(MovieWebServices());
    moviesCubit = MoviesCubit(movieRepository);
  }

  Route? generatingRoute(RouteSettings settings) {
    switch (settings.name) {

      case moviesScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MoviesCubit(movieRepository),
            child: const MoviesScreen(),
          ),
        );

      case moviesDetailsScreenRoute:
        final movie = settings.arguments as MovieModel;
        return MaterialPageRoute(builder: (_) => MoviesDetailsScreen(movieModel: movie,));
    }
  }
}
