import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_structure/bloc/movies_bloc.dart';
import 'package:flutter_structure/models/movies/poster_images.dart';
class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    this.controller,
    this.onPageSelected,
    this.color= Colors.white,
  }) : super(listenable: controller);

  final PageController controller;

  final ValueChanged<int> onPageSelected;

  final Color color;

  static const double _kDotSize = 5.0;

  static const double _kMaxZoom = 2.0;

  static const double _kDotSpacing = 10.0;

  Widget _buildDot(int index) {
    final double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    final double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Container(
      width: _kDotSpacing,
      child:  Center(
        child:  Material(
          color: Colors.white,
          type: MaterialType.circle,
          child:  Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child:  InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }
@override
  Widget build(BuildContext context) {
    return StreamBuilder<PosterImages>(
      stream: bloc.movieImages,
      builder: (BuildContext context,
          AsyncSnapshot<PosterImages> snapshot) {
        if (snapshot.hasData) {
          return  Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(snapshot.data.results.length, _buildDot),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        //print(snapshot.data.toString());
        return Center(child: Container());
      },
    );

  }
}
