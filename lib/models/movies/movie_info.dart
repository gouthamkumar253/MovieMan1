class MovieInfo {
  MovieInfo.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _adult = parsedJson['adult'];
    _genres = parsedJson['genres'];
    _title = parsedJson['title'];
    _overview = parsedJson['overview'];
    _releaseDate = parsedJson['release_date'];
    _runTime = parsedJson['runtime'];
  }

  int _id;
  bool _adult;
  List<dynamic> _genres;
  String _title;
  String _overview;
  String _releaseDate;
  int _runTime;

  int get id => _id;

  bool get adult => _adult;

  List<dynamic> get genres => _genres;

  String get title => _title;

  String get overview => _overview;

  String get releaseDate => _releaseDate;

  int get runtime => _runTime;
}
