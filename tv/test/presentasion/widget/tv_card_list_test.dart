import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/presentation/widget/Tv_card_list.dart';

void main() {
  final tTv = TvEntity(
    backdropPath: '/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg',
    genreIds: [14, 12, 28],
    id: 338953,
    originalName: 'Fantastic Beasts: The Secrets of Dumbledore',
    overview:
        'Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald\'s growing legion of followers.',
    popularity: 3456.961,
    posterPath: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
    firstAirDate: '2022-04-06',
    name: 'Fantastic Beasts: The Secrets of Dumbledore',
    voteAverage: 6.9,
    voteCount: 1795,
  );

  group('Tv card Widget Test', () {
    Widget _makeTestableWidget() {
      return MaterialApp(home: Scaffold(body: TvCard(tTv)));
    }

    testWidgets('Testing if title Tv shows', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget());
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
