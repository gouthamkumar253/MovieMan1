import 'package:flutter/material.dart';
import 'package:flutter_structure/bloc/movies_bloc.dart';
import 'package:flutter_structure/models/movies/movie_info.dart';
import 'package:flutter_structure/views/movies/chosen_movie.dart';
import 'package:flutter_structure/views/movies/page_content.dart';
import 'package:palette_generator/palette_generator.dart';

Color color1, color2;
TabBar tabBar = TabBar(
  isScrollable: true,
  labelColor: Colors.white,
  unselectedLabelColor: Colors.grey,
  indicatorColor: const Color(0xFF7896b9),
  tabs: <Widget>[
    Container(
      width: 90,
      child: const Tab(
        text: 'INFO',
      ),
    ),
    Container(
      width: 90,
      child: const Tab(
        text: 'CAST',
      ),
    ),
    Container(
      width: 90,
      child: const Tab(
        text: 'DETAILS',
      ),
    ),
  ],
);

class SelectedMovie extends StatefulWidget {
  const SelectedMovie(
      {Key key,
      this.title,
      this.movieId,
      this.image,
      this.index,
      this.imageURL})
      : super(key: key);
  final String imageURL;
  final int movieId;
  final Image image;
  final int index;
  final String title;

  @override
  _SelectedMovieState createState() => _SelectedMovieState();
}

class _SelectedMovieState extends State<SelectedMovie> {
  PaletteGenerator paletteGenerator;

  Future<void> updatePaletteGenerator() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.imageURL),
        maximumColorCount: 2);
    //print('this is the image url' + widget.imageURL);
    //print(paletteGenerator.colors.toList());
    setState(
      () {
        color1 = paletteGenerator.colors.first;
        color2 = paletteGenerator.colors.last;
      },
    );
  }

  Widget overview() {
    return StreamBuilder<MovieInfo>(
      stream: bloc.movie,
      builder: (BuildContext context, AsyncSnapshot<MovieInfo> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.overview);
        } else
          return const CircularProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _SliverAppBarDelegate(tabBar);
  }

  @override
  Widget build(BuildContext context) {
    updatePaletteGenerator();
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: ScrollController(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 350,
                backgroundColor: color1,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.home),
                    iconSize: 26.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    iconSize: 26.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    iconSize: 26.0,
                    onPressed: () {},
                  ),
                ],
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    //print(constraints.biggest.height);
                    return FlexibleSpaceBar(
                      background: ChosenMovie(
                        index: widget.index,
                        imageURL: widget.imageURL,
                        image: widget.image,
                        movieId: widget.movieId,
                      ),
                      collapseMode: CollapseMode.pin,
                      title: Container(
                        width: 150,
                        child: Text(
                          constraints.biggest.height == 80 ? widget.title : '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  tabBar,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: const <Widget>[
              //overview(),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color2,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
