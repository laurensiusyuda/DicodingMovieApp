import 'package:core/core.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_event.dart';
import 'package:ditonton/presentation/widgets/Search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  final bool isSearchMovies;

  const SearchPage({Key? key, required this.isSearchMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSearchMovies == true ? 'Search Movies' : 'Search Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                if (isSearchMovies) {
                  context.read<SearchMoviesBloc>().add(OnQueryChanged(query));
                } else {
                  context.read<SearchTvBloc>().add(OnQueryChanged(query));
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isSearchMovies == true
                ? const SearchMovieBuilder()
                : const SearchTvBuilder(),
          ],
        ),
      ),
    );
  }
}

class SearchMovieBuilder extends StatelessWidget {
  const SearchMovieBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieEntity movieEntity;
    return BlocBuilder<SearchMoviesBloc, StateRequest>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                movieEntity = movie;
                return SearchCard(movieEntity, isSearchMovies: true);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}

class SearchTvBuilder extends StatelessWidget {
  const SearchTvBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TvEntity tvEntity;

    return BlocBuilder<SearchTvBloc, StateRequest>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tv = result[index];
                tvEntity = tv;
                return SearchCard(tvEntity, isSearchMovies: false);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}
