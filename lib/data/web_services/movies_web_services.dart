import 'package:dio/dio.dart';
import 'package:movies_filtring/constants/strings.dart';

class MovieWebServices {
  late Dio dio;

  MovieWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllMovies() async {
    try {
      Response response = await dio.get("classic");
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
