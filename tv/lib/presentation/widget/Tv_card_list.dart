import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import '../pages/tv/tv_detail_page.dart';
import 'package:flutter/material.dart';

class TvCard extends StatelessWidget {
  final TvEntity tvPopularEntity;

  const TvCard(this.tvPopularEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TvDetailPage.routeName,
            arguments: tvPopularEntity.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tvPopularEntity.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tvPopularEntity.overview ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: tvPopularEntity.posterPath != ""
                    ? CachedNetworkImage(
                        imageUrl: '$baseImageUrl${tvPopularEntity.posterPath}',
                        width: 80,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : Container(
                        color: Colors.white,
                        child: Image.asset('assets/bg_no_pictures.png',
                            width: 80, height: 100)),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
