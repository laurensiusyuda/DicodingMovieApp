import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_state.dart';

class TvSeriesDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/detail-tv-series';
  final TvSeriesDetailBloc tvSeriesDetailLocator = locator();
  final int id;

  TvSeriesDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => tvSeriesDetailLocator,
      child: Scaffold(
        body: TvSeriesDetailMain(
          id: id,
        ),
      ),
    );
  }
}

class TvSeriesDetailMain extends StatefulWidget {
  final int id;

  TvSeriesDetailMain({required this.id});

  @override
  State<TvSeriesDetailMain> createState() => _TvSeriesDetailMainState();
}

class _TvSeriesDetailMainState extends State<TvSeriesDetailMain> {
  late TvSeriesDetailBloc tvSeriesDetailBloc;

  @override
  void initState() {
    tvSeriesDetailBloc = BlocProvider.of<TvSeriesDetailBloc>(
      context,
    );
    tvSeriesDetailBloc.add(EventLoadDetailTvSeries(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocListener(
        bloc: tvSeriesDetailBloc,
        listener: (context, state) {
          if (state is StateWatchlistTvSeriesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is StateWatchlistTvSeriesSuccess) {
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
          bloc: tvSeriesDetailBloc,
          builder: (context, state) {
            if (state is StateTvSeriesDetailInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateWatchlistTvSeriesFailure) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            } else if (state is StateDetailTvSeriesFailure) {
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
                        'https://image.tmdb.org/t/p/w500${tvSeriesDetailBloc.tvSeries.posterPath}',
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
                                        tvSeriesDetailBloc.tvSeries.name,
                                        style: kHeading5,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (!tvSeriesDetailBloc
                                              .isAddedToWatchlist) {
                                            tvSeriesDetailBloc.add(
                                              EventAddWatchlist(
                                                tvSeries:
                                                    tvSeriesDetailBloc.tvSeries,
                                              ),
                                            );
                                          } else {
                                            tvSeriesDetailBloc.add(
                                              EventRemoveWatchlist(
                                                tvSeries:
                                                    tvSeriesDetailBloc.tvSeries,
                                              ),
                                            );
                                          }
                                          BlocListener(
                                            bloc: tvSeriesDetailBloc,
                                            listener: (context, state) {
                                              if (state
                                                  is StateDetailTvSeriesSuccess) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      state.message,
                                                    ),
                                                  ),
                                                );
                                              } else if (state
                                                  is StateDetailTvSeriesFailure) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      state.message,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            tvSeriesDetailBloc
                                                    .isAddedToWatchlist
                                                ? Icon(Icons.check)
                                                : Icon(Icons.add),
                                            Text('Watchlist'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _showGenres(
                                            tvSeriesDetailBloc.tvSeries.genres),
                                      ),
                                      Text(
                                        tvSeriesDetailBloc.tvSeries.firstAirDate
                                            .toString(),
                                      ),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: tvSeriesDetailBloc
                                                    .tvSeries.voteAverage /
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
                                              '${tvSeriesDetailBloc.tvSeries.voteAverage}')
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Overview',
                                        style: kHeading6,
                                      ),
                                      Text(
                                        tvSeriesDetailBloc.tvSeries.overview,
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
                                            final tvSeries = tvSeriesDetailBloc
                                                .tvSeriesRecommendations[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    TvSeriesDetailPage
                                                        .ROUTE_NAME,
                                                    arguments: tvSeries.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
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
                                          itemCount: tvSeriesDetailBloc
                                              .tvSeriesRecommendations.length,
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
}
