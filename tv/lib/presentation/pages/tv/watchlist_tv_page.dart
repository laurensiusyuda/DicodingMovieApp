import 'package:core/core.dart';
import 'package:tv/presentation/widget/Tv_card_list.dart';
import '../../bloc/tv/watchlist_tv/watchlist_event.dart';
import '../../bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  static const routeName = '/watchlist-tv';

  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistTvBloc>().add(WatchlistTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, StateRequest>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is Empty) {
              return const Center(
                child: Text('Empty favorite'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
