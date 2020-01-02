class PosterImages {
  PosterImages.fromJson(Map<String, dynamic> parsedJson) {
    _posters = parsedJson['backdrops'];
    //print(_id.toString());
    final List<String> temp = <String>[];
    final int length=_posters.length>10?10:_posters.length;
    for (int i = 0; i < length; i++) {
      final String result = _posters[i]['file_path'];
      temp.add(result);
    }
    _results = temp;
  }

  List<dynamic> _posters;
  List<String> _results = <String>[];

  List<String> get results => _results;
}
