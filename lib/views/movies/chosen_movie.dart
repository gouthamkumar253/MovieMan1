import 'package:flutter/material.dart';
import 'package:flutter_structure/bloc/movies_bloc.dart';
import 'package:flutter_structure/models/movies/movie_info.dart';
import 'package:flutter_structure/views/movies/dots_indicator.dart';
import 'package:flutter_structure/views/movies/movie_images.dart';

class ChosenMovie extends StatefulWidget {
  //const ChosenMovie({Key key, this.movieId}) : super(key: key);
  const ChosenMovie(
      {Key key, this.movieId, this.image, this.index, this.imageURL})
      : super(key: key);
  final int movieId;
  final Image image;
  final int index;
  final String imageURL;
  static const Duration _kDuration = const Duration(milliseconds: 300);
  static const Cubic _kCurve = Curves.ease;

  @override
  _ChosenMovieState createState() => _ChosenMovieState();
}
class _ChosenMovieState extends State<ChosenMovie> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    bloc.fetchImages(widget.movieId);
    return Container(
      height: 400.0,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          MovieImages(controller: controller),
          Positioned(
            top: 200,
            left: 110,
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: DotsIndicator(
                  controller: controller,
                  onPageSelected: (int page) {
                    controller.animateToPage(
                      page,
                      duration: ChosenMovie._kDuration,
                      curve: ChosenMovie._kCurve,
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 175.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 100.0,
                height: 150.0,
                child: Hero(
                  tag: 'image-${widget.index}',
                  child: widget.image,
                ),
              ),
            ),
          ),
          Positioned(
            top: 250.0,
            left: 130,
            child: Container(
              child: MovieDetails(movieId: widget.movieId),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key key, this.movieId}) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    bloc.fetchMovie(movieId);
    return StreamBuilder<MovieInfo>(
      stream: bloc.movie,
      builder: (BuildContext context, AsyncSnapshot<MovieInfo> snapshot) {
        if (snapshot.hasData) {
          //snapshot.data.genres.forEach((dynamic f) => print(f.toString()));
          return Container(
            width: 225.0,
            height: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF878c9a),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: snapshot.data.adult.toString().startsWith('f')
                              ? const Text(
                                  'PG',
                                  style: TextStyle(
                                    color: const Color(0xFF878c9a),
                                  ),
                                )
                              : const Text(
                                  'PG-13',
                                  style: TextStyle(
                                    color: const Color(0xFF878c9a),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Material(
                        type: MaterialType.circle,
                        color: const Color(0xFF878c9a),
                        child: Container(
                          width: 6.0,
                          height: 6.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 20,
                        child: Text(
                          snapshot.data.releaseDate.substring(0, 4),
                          style: const TextStyle(
                            color: Color(0xFF878c9a),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Material(
                        type: MaterialType.circle,
                        color: const Color(0xFF878c9a),
                        child: Container(
                          width: 6.0,
                          height: 6.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 20,
                        child: Text(
                          ((snapshot.data.runtime / 60).floor()).toString() +
                              ' hrs ' +
                              (snapshot.data.runtime % 60).toString() +
                              ' mins',
                          style: const TextStyle(
                            color: Color(0xFF878c9a),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  snapshot.data.title,
                  //maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    fontFamily: 'Rock Salt',
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
