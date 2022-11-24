import 'package:core/core.dart';
import 'package:ditonton/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_state.dart';

class MovieDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/detail';
  final MovieDetailBloc movieDetailLocater = locator();
  final int id;

  MovieDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => movieDetailLocater,
      child: Scaffold(
          body: MovieDetailMain(
        id: id,
      )),
    );
  }
}

class MovieDetailMain extends StatefulWidget {
  final int id;

  MovieDetailMain({required this.id});

  @override
  State<MovieDetailMain> createState() => _MovieDetailMainState();
}

class _MovieDetailMainState extends State<MovieDetailMain> {
  late MovieDetailBloc movieDetailBloc;

  @override
  void initState() {
    movieDetailBloc = BlocProvider.of<MovieDetailBloc>(
      context,
    );
    movieDetailBloc.add(EventLoadDetailMovie(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocListener(
        bloc: movieDetailBloc,
        listener: (context, state) {
          if (state is StateWatchlistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is StateWatchlistFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder(
          bloc: movieDetailBloc,
          builder: (context, state) {
            if (state is StateMovieDetailInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateWatchlistFailure) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            } else if (state is StateLoadDetailMovieFailure) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            } else {
              return Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movieDetailBloc.movie.posterPath}',
                    width: screenWidth,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 48 + 8),
                    child: DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: kRichBlack,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                            right: 16,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movieDetailBloc.movie.title,
                                        style: kHeading5,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (!movieDetailBloc
                                              .isAddedToWatchlist) {
                                            movieDetailBloc.add(
                                              EventAddWatchlist(
                                                movie: movieDetailBloc.movie,
                                              ),
                                            );
                                          } else {
                                            movieDetailBloc.add(
                                              EventRemoveWatchlist(
                                                movie: movieDetailBloc.movie,
                                              ),
                                            );
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            movieDetailBloc.isAddedToWatchlist
                                                ? Icon(Icons.check)
                                                : Icon(Icons.add),
                                            Text('Watchlist'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _showGenres(
                                            movieDetailBloc.movie.genres),
                                      ),
                                      Text(
                                        _showDuration(
                                            movieDetailBloc.movie.runtime),
                                      ),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: movieDetailBloc
                                                    .movie.voteAverage /
                                                2,
                                            itemCount: 5,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: kMikadoYellow,
                                            ),
                                            itemSize: 24,
                                          ),
                                          Text(
                                              '${movieDetailBloc.movie.voteAverage}')
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Overview',
                                        style: kHeading6,
                                      ),
                                      Text(
                                        movieDetailBloc.movie.overview,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Recommendations',
                                        style: kHeading6,
                                      ),
                                      Container(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final movie = movieDetailBloc
                                                .movieRecommendations[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    MovieDetailPage.ROUTE_NAME,
                                                    arguments: movie.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: movieDetailBloc
                                              .movieRecommendations.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  color: Colors.white,
                                  height: 4,
                                  width: 48,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      // initialChildSize: 0.5,
                      minChildSize: 0.25,
                      // maxChildSize: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: kRichBlack,
                      foregroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
