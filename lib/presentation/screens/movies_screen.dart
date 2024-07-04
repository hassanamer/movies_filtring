import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_filtring/constants/my_colors.dart';
import 'package:movies_filtring/data/model/movie_model.dart';
import 'package:movies_filtring/domain/cubit/movies_cubit.dart';
import 'package:movies_filtring/presentation/widgets/MovieItem.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<MovieModel> allMovies = [];
  List<MovieModel> searchedMovies = [];
  bool _isSearch = false;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allMovies = BlocProvider.of<MoviesCubit>(context).getAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearch
            ? BackButton(
          color: MyColors.grey,
        )
            : null,
        title: _isSearch ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildBarActions(),
        backgroundColor: MyColors.yellow,
      ),
      body: buildBlocWidget(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _textEditingController,
      cursorColor: MyColors.grey,
      decoration: InputDecoration(
        hintText: "Find A Movie...",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.grey,
          fontSize: 16,
        ),
      ),
      style: TextStyle(
        color: MyColors.grey,
        fontSize: 16,
      ),
      onChanged: (searchCharacter) {
        addSearchedMoviesToSearcheList(searchCharacter);
      },
    );
  }

  void addSearchedMoviesToSearcheList(String searchCharacter) {
    setState(() {
      searchedMovies = allMovies
          .where((movie) =>
          movie.title.toLowerCase().startsWith(searchCharacter))
          .toList();
    });
  }

  List<Widget> _buildBarActions() {
    if (_isSearch) {
      return [
        IconButton(
          onPressed: () {
            _clearSearchData();
            _stopSearching();
          },
          icon: Icon(Icons.clear, color: MyColors.grey),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(Icons.search),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearch = true;
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearch = false;
      _clearSearchData();
    });
  }

  void _clearSearchData() {
    setState(() {
      _textEditingController.clear();
      searchedMovies.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return Text(
      "Movies",
      style: TextStyle(color: MyColors.grey),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
      if (state is MoviesLoaded) {
        allMovies = (state).movies;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.yellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.grey,
        child: Column(
          children: [buildMoviesList()],
        ),
      ),
    );
  }

  Widget buildMoviesList() {
    final List<MovieModel> displayedMovies =
    _textEditingController.text.isEmpty ? allMovies : searchedMovies;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: displayedMovies.length,
      itemBuilder: (context, index) {
        return MovieItem(movieModel: displayedMovies[index]);
      },
    );
  }
}
