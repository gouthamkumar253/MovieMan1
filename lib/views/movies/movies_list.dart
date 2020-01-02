import 'package:flutter/material.dart';
import 'package:flutter_structure/views/movies/page_content.dart';

Color color = const Color(0xFF323232);
Color indicatorColor = const Color(0xFF009688);

class MoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        body: NestedScrollView(
          controller: ScrollController(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: color,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.list),
                    iconSize: 34.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    iconSize: 34.0,
                    onPressed: () {},
                  ),
                ],
                title: const Text('Movies'),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white30,
                  indicatorColor: indicatorColor,
                  indicatorWeight: 2.5,
                  tabs: const <Tab>[
                    Tab(
                      child: Text('NOW PLAYING'),
                    ),
                    Tab(
                      child: Text('TOP BOX OFFICE'),
                    ),
                    Tab(
                      child: Text('ANTICIPATED'),
                    ),
                    Tab(
                      child: Text('UPCOMING'),
                    ),
                    Tab(
                      child: Text('TRENDING'),
                    ),
                    Tab(
                      child: Text('TOP RATED'),
                    ),
                    Tab(
                      child: Text('NEW DVDS'),
                    ),
                    Tab(
                      child: Text('UPCOMING DVDS'),
                    ),
                    Tab(
                      child: Text('TOP RENTALS'),
                    ),
                    Tab(
                      child: Text('ON NETFLIX'),
                    ),
                    Tab(
                      child: Text('ON AMAZON'),
                    ),
                    Tab(
                      child: Text('IMDB TOP 250'),
                    ),
                  ],
                ),
              ),
            ];
          },
          body:  TabBarView(
            children: const <Widget>[
              PageContent(value: 1),
              PageContent(value: 2),
              PageContent(value: 3),
              PageContent(value: 1),
              PageContent(value: 2),
              PageContent(value: 3),
              PageContent(value: 1),
              PageContent(value: 2),
              PageContent(value: 3),
              PageContent(value: 1),
              PageContent(value: 2),
              PageContent(value: 3),
            ],
          ),
        ),
      ),
    );
  }
}
