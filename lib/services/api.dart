import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:project_assignment/models/detail_model.dart';
import 'package:project_assignment/models/now_playing_model.dart';
import 'package:project_assignment/models/popular_model.dart';
import 'package:project_assignment/models/search_model.dart';
import 'package:project_assignment/models/top_rate_model.dart';
import 'package:http/http.dart' as http;
import 'package:project_assignment/models/upcoming_model.dart';
import 'package:project_assignment/utils/utils.dart';

late String endPoint;

class ApiServices {
  Future<TopRateModel> getTopRateMovies() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // log("Success");
      return TopRateModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load API");
  }

  Future<PopularModel>getPopularMovies() async{
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      // log("Success");
      return PopularModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Fail to load API");
  }

  Future<NowPlayingModel>getNowPlingMovies() async{
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      // log("Success");
      return NowPlayingModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Fail to load API");
  }

  Future<UpComingModel>getUpComingMovies() async{
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return UpComingModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Fail to load API");
  }

  Future<SearchModel> getSearchMovies(String textSearch) async {
    endPoint = "search/movie?query=$textSearch";
    final url = "$baseUrl$endPoint";
    print("search url is: " + url);
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MjU5MWZkNjM5ODZkYjM5ZTAyOTRhZDk3NTRkM2I1ZSIsIm5iZiI6MTczNjc4Mjg2Ny4wODMwMDAyLCJzdWIiOiI2Nzg1MzQxM2VlODRmYTRkZWY3YmEwNDEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.uev7TXEUvjxzkM8njkwOWLFnAz4GSqE9q5U6TWsC1xs',
    });

    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception(
        "Failed to load API! Status code: ${response.statusCode}, Response: ${response.body}");
  }

  Future<DetailModel> getDetailMovies(int id) async {
    endPoint = "movie/$id";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // log("Success");
      return DetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load API! Status code: ${response.statusCode}, Response: ${response.body}");
  }
}
