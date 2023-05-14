import 'dart:convert';

import 'package:film_app/models/movies_model.dart';
import 'package:http/http.dart';

class ApiService {
  final apiKey = "api_key=36a1d94faeedfbb1781bd124896724b2";
  final popular = "https://api.themoviedb.org/3/movie/popular?";

  //Get Popular movies
  Future<List<Movie>> getMovies({required int page}) async {
    //Send Request
    Response response = await get(Uri.parse("$popular$apiKey&page=$page"));
    //Check Response StatusCode
    if (response.statusCode == 200) {
      //Extract Response Body
      Map<String, dynamic> body = jsonDecode(response.body);
      //Extract Results From Body
      List<dynamic> data = body['results'];
      //Map to Movie Model
      List<Movie> movies = data.map((movie) => Movie.fromJson(movie)).toList();

      return movies;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
