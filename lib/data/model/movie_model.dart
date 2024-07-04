class MovieModel{
late int id ;
late String title;
late String image;

MovieModel.fromJson(Map<String,dynamic> json){
id = json["id"];
title = json["title"];
image = json["posterURL"];
}
}