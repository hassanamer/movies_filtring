import 'package:flutter/material.dart';
import 'package:movies_filtring/constants/my_colors.dart';
import 'package:movies_filtring/data/model/movie_model.dart';

class MoviesDetailsScreen extends StatelessWidget {
  final MovieModel movieModel;

  const MoviesDetailsScreen({super.key, required this.movieModel});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 700,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movieModel.title,
          style: TextStyle(
              color: MyColors.grey, fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: movieModel.id,
          child: Image.network(
            movieModel.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget movieInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: TextStyle(
                  color: MyColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          TextSpan(
              text: value,
              style: TextStyle(color: MyColors.white, fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildDvider(double endIndent) {
    return Divider(
      color: MyColors.yellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      movieInfo("Movie Title : ", movieModel.title),
                      buildDvider(315),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
                SizedBox(height: 670,)
              ],
            ),
          )
          // SliverList(delegate: delegate)
        ],
      ),
    );
  }
}
