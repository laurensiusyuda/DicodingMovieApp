import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_entities/genre.dart';
import 'package:tv/domain/entities/tv_entities/tv_detail.dart';
import '../../bloc/tv/watchlist_tv/watchlist_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../bloc/tv/tv_recomendation/tv_recomendation_bloc.dart';
import '../../bloc/tv/tv_recomendation/tv_recomendation_event.dart';

import '../../bloc/tv/tv_detail/tv_detail_bloc.dart';
import '../../bloc/tv/tv_detail/tv_detail_event.dart';
import '../../bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/tv-detail';
  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);
  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchTvDetail(widget.id));
      context.read<WatchlistTvBloc>().add(LoadWatchlistStatus(widget.id));
      context
          .read<TvRecommendationBloc>()
          .add(GetTvRecommendationId(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedWatchlist = context.select<WatchlistTvBloc, bool>((bloc) {
      if (bloc.state is HasStatus) {
        return (bloc.state as HasStatus).status;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<TvDetailBloc, StateRequest>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HasData) {
            final tv = state.result;
            return SafeArea(
              child: DetailContent(tv, isAddedWatchlist),
            );
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailContent extends StatelessWidget {
  final TvDetailEntity tv;
  late bool isAddedWatchlist;

  DetailContent(this.tv, this.isAddedWatchlist, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const watchlistAddSuccessMessage = 'Added to Watchlist';
    const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(AddWatchlist(tv));
                                } else {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(RemoveFromWatchlist(tv));
                                }

                                final message = context.select<WatchlistTvBloc,
                                    String>((value) => (value.state
                                        is HasStatus)
                                    ? (value.state as HasStatus).status == false
                                        ? watchlistAddSuccessMessage
                                        : watchlistRemoveSuccessMessage
                                    : !isAddedWatchlist
                                        ? watchlistAddSuccessMessage
                                        : watchlistRemoveSuccessMessage);

                                if (message == watchlistAddSuccessMessage ||
                                    message == watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                                isAddedWatchlist = !isAddedWatchlist;
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              _showDuration(tv.numberOfEpisodes),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationBloc, StateRequest>(
                              builder: (context, state) {
                                if (state is Loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is Error) {
                                  return Text(state.message);
                                } else if (state is HasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.routeName,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
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
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<TvGenreEntity> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name;
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
