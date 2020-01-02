import 'dart:async';
import 'package:flutter_structure/data/api/movie_api.dart';
import 'package:flutter_structure/models/movies/movie_info.dart';
import 'package:flutter_structure/models/movies/movies_data.dart';
import 'package:flutter_structure/models/movies/poster_images.dart';


class Repository {
  final MovieApiProvider moviesApiProvider = MovieApiProvider();

  Future<MoviesData> fetchPopularMovies() => moviesApiProvider.fetchPopularMovieList();
  Future<MoviesData> fetchTopMovies() => moviesApiProvider.fetchTopMovieList();
  Future<MoviesData> fetchAnticipatedMovies() => moviesApiProvider.fetchAnticipatedMovieList();
  Future<PosterImages> fetchImages(int movieId)=>moviesApiProvider.fetchImages(movieId);

  Future<MovieInfo> fetchMovie(int movieId)=>moviesApiProvider.fetchMovie(movieId);

}