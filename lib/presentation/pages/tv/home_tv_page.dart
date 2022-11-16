import 'package:ditonton/domain/entities/tv.dart';

import 'package:ditonton/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/searchtv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';

import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_state.dart';

import 'package:ditonton/presentation/bloc/tv/tv_popular/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular/tv_popular_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular/tv_popular_state.dart';

import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_state.dart';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_series';

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    super.initState();
    context.read<OnTheAirTvBloc>().add(FetchOnTheAirTvEvent());
    context.read<PopularTvBloc>().add(FetchPopularTvEvent());
    context.read<TopRatedTvBloc>().add(FetchTopRatedTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicoding - TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTv.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
              ),
              BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
                builder: (context, state) {
                  if (state is OnTheAirTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OnTheAirTvLoaded) {
                    return TvList(state.result);
                  } else if (state is OnTheAirTvError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, PopularTvState>(
                builder: (context, state) {
                  if (state is PopularTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvLoaded) {
                    return TvList(state.result);
                  } else if (state is PopularTvError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
                  if (state is TopRatedTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvLoaded) {
                    return TvList(state.result);
                  } else if (state is TopRatedTvError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvs.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
