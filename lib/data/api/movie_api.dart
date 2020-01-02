import 'dart:async';
import 'dart:convert';

import 'package:flutter_structure/models/movies/movie_info.dart';
import 'package:flutter_structure/models/movies/movies_data.dart';
import 'package:flutter_structure/models/movies/poster_images.dart';
import 'package:http/http.dart' show Client, Response;

class MovieApiProvider {
  Client client = Client();
  final String _apiKey = '83771f720f367fe6a39b3b6049daacbd';

  Future<MoviesData> fetchPopularMovieList() async {
    final Response response = await client
        .get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
    //print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MoviesData.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<MoviesData> fetchTopMovieList() async {
    final Response response = await client
        .get('https://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey');
    //print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MoviesData.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<MoviesData> fetchAnticipatedMovieList() async {
    final Response response = await client
        .get('https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey');
    //print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MoviesData.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<PosterImages> fetchImages(int movieId) async {
    final Response response = await client.get(
        'https://api.themoviedb.org/3/movie/$movieId/images?api_key=$_apiKey');
    //print('fetchImages'+ response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return PosterImages.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<MovieInfo> fetchMovie(int movieId) async {
   // print('Control is here-$movieId');
    final Response response = await client.get(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey&language=en-US');
    //print('fetchMovie'+ response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MovieInfo.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
