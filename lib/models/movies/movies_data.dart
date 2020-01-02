class MoviesData {
  MoviesData.fromJson(Map<String, dynamic> parsedJson) {
    //print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    final List<_Result> temp = <_Result>[];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      final _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  int _page;
  int _totalResults;
  int _totalPages;
  List<_Result> _results = <_Result>[];

  List<_Result> get results => _results;

  int get totalPages => _totalPages;

  int get totalResults => _totalResults;

  int get page => _page;
}

class _Result {
  _Result(dynamic result) {
    _id = result['id'];
    _title = result['title'];
    _posterPath = result['poster_path'];
    _originalLanguage = result['original_language'];
    _originalTitle = result['original_title'];
    _overview = result['overview'];
  }

  int _id;
  String _title;
  String _posterPath;
  String _originalLanguage;
  String _originalTitle;
  String _overview;

  String get overview => _overview;

  String get originalTitle => _originalTitle;

  String get originalLanguage => _originalLanguage;

  String get posterPath => _posterPath;

  String get title => _title;

  int get id => _id;
}
