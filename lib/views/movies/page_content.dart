import 'package:flutter/material.dart';
import 'package:flutter_structure/bloc/movies_bloc.dart';
import 'package:flutter_structure/models/movies/movies_data.dart';
import 'package:flutter_structure/views/movies/selected_movie.dart';
import 'package:transparent_image/transparent_image.dart';

Stream<MoviesData> stream;

void setStream(int value) {
  switch (value) {
    case 1:
      {
        stream = bloc.popMovies;
        //print('popMovies-' + stream.toString());
        break;
      }
    case 2:
      {
        stream = bloc.topMovies;
        //print('topMovies-' + stream.toString());
        break;
      }
    case 3:
      {
        stream = bloc.antMovies;
        //print('antMovies-' + stream.toString());
        break;
      }
  }
}

Image image;
String imageURL;

class PageContent extends StatelessWidget {
  const PageContent({Key key, this.value}) : super(key: key);
  final int value;

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies(value);
    setStream(value);
    return StreamBuilder<MoviesData>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<MoviesData> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: GridView.builder(
              itemCount: snapshot.data.results.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.55,
                crossAxisSpacing: 3.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          image = Image.network(
                            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
                            fit: BoxFit.fill,
                          );
                          imageURL =
                              'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}';
                          Navigator.of(context).push(
                            PageRouteBuilder<BuildContext>(
                              transitionDuration:
                                  const Duration(milliseconds: 1500),
                              pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) =>
                                  SelectedMovie(
                                movieId: snapshot.data.results[index].id,
                                image: image,
                                index: index,
                                title: snapshot.data.results[index].title,
                                imageURL: imageURL,
                              ),
                              transitionsBuilder: (BuildContext context,
                                      Animation<double> anim,
                                      Animation<double> secondaryAnim,
                                      Widget child) =>
                                  FadeTransition(
                                child: child,
                                opacity: Tween<double>(
                                  begin: 0.0,
                                  end: 1.0,
                                ).animate(anim),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 150.0,
                          child: Hero(
                            tag: 'image-$index',
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              image:
                                  'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, top: 4.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            snapshot.data.results[index].title,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        //print(snapshot.data.toString());
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
