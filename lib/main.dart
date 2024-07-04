import 'package:flutter/material.dart';
import 'package:movies_filtring/app_router.dart';


void main() {
  runApp( MoviesFilters(appRouter: AppRouter(),));
}

class MoviesFilters extends StatelessWidget {

final AppRouter appRouter;

  const MoviesFilters({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generatingRoute,
    );
  }
}