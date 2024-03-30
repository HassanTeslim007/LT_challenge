import 'package:flutter/material.dart';
import 'package:lt_challenge/core/shared/spacer.dart';
import 'package:lt_challenge/core/utils/utils.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';
import 'package:lt_challenge/features/video/presentation/views/video_player.dart';

class SearchTile extends StatelessWidget {
  final Item item;
  const SearchTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(item: item)));
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  item.thumbnail ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        Text('Unable to load Image')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ySpace(10),
            Text(
              item.title ?? 'Title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              item.channelTitle ?? 'Channel',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text.rich(
              TextSpan(text: item.description ?? 'Description', children: [
                if (item.description!.isNotEmpty) WidgetSpan(child: xSpace(30)),
                TextSpan(text: formatDate(item.publishTime!))
              ]),
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
