import 'package:flutter/material.dart';
import 'package:movies_filtring/constants/my_colors.dart';
import 'package:movies_filtring/constants/strings.dart';
import 'package:movies_filtring/data/model/movie_model.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({Key? key, required this.movieModel}) : super(key: key);

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, moviesDetailsScreenRoute,arguments: movieModel),
        child: Hero(
          tag: movieModel.id,
          child: GridTile(
            child: Container(
              color: MyColors.grey,
              child:FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: "assets/images/loading.gif",
                image: movieModel.image,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/placeholder.png');
                },
              )

            ),
            footer: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: Colors.black45,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${movieModel.title}',
                style: TextStyle(
                  height: 1.3,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
