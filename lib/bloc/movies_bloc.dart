import 'package:flutter_structure/data/services/movies_repo.dart';
import 'package:flutter_structure/models/movies/movie_info.dart';
import 'package:flutter_structure/models/movies/movies_data.dart';
import 'package:flutter_structure/models/movies/poster_images.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final Repository _repository = Repository();
  final PublishSubject<MoviesData> _moviesFetcher =
      PublishSubject<MoviesData>();
  final PublishSubject<PosterImages> _imageFetcher =
      PublishSubject<PosterImages>();
  final PublishSubject<MovieInfo> _movieFetcher = PublishSubject<MovieInfo>();

  Observable<MoviesData> get popMovies => _moviesFetcher.stream;

  Observable<MoviesData> get topMovies => _moviesFetcher.stream;

  Observable<MoviesData> get antMovies => _moviesFetcher.stream;

  Observable<PosterImages> get movieImages => _imageFetcher.stream;

  Observable<MovieInfo> get movie => _movieFetcher.stream;

  void fetchImages(int movieId) async {
    final PosterImages images = await _repository.fetchImages(movieId);
    _imageFetcher.sink.add(images);
  }
  void fetchMovie(int movieId) async {
    final MovieInfo movie= await _repository.fetchMovie(movieId);
    _movieFetcher.sink.add(movie);
  }

  void fetchAllMovies(int value) async {
    MoviesData movies;
    switch (value) {
      case 1:
        {
          movies = await _repository.fetchPopularMovies();
          break;
        }
      case 2:
        {
          movies = await _repository.fetchTopMovies();
          break;
        }
      case 3:
        {
          movies = await _repository.fetchAnticipatedMovies();
          break;
        }
    }

    _moviesFetcher.sink.add(movies);
  }

  void dispose() {
    _moviesFetcher.close();
  }
}

final MoviesBloc bloc = MoviesBloc();
