import 'package:flutter/material.dart';
import 'package:flutter_structure/bloc/movies_bloc.dart';
import 'package:flutter_structure/models/movies/poster_images.dart';

class MovieImages extends StatelessWidget {
  const MovieImages({Key key, this.controller}) : super(key: key);
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PosterImages>(
      stream: bloc.movieImages,
      builder: (BuildContext context, AsyncSnapshot<PosterImages> snapshot) {
        return PageView.builder(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: snapshot.hasData?snapshot.data.results.length:1,
          itemBuilder: (BuildContext context, int index) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 240.0,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w780${snapshot.data.results[index]}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}
