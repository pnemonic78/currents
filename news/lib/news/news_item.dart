import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currentsapi_core/parallax/parallax_image.dart';
import 'package:currentsapi_core/ui/flutter_ext.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

const _cardRadius = Radius.circular(4.0);

class NewsItem extends StatelessWidget {
  final Article article;
  final ValueChanged<Article>? onPressed;

  static const imageAspectRatio = 1.5;

  const NewsItem({
    super.key,
    required this.article,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final imageWidth = width;
    final imageHeight = imageWidth / imageAspectRatio;
    final imageExtent = imageHeight * 0.75;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final Color textBG = theme.isDarkMode ? Colors.black38 : Colors.white38;

    final icon = Icon(
      Icons.image,
      color: Colors.grey,
      size: max(imageWidth, imageHeight),
    );

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => onPressed?.call(article),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                article.isValidImage
                    ? ParallaxImage(
                        extent: imageExtent,
                        child: CachedNetworkImage(
                          key: Key(article.id),
                          imageUrl: article.image!,
                          placeholder: (context, url) => icon,
                          width: imageWidth,
                          height: imageHeight,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        color: textBG,
                        width: imageWidth,
                        height: imageExtent,
                      ),
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  width: imageWidth,
                  height: imageExtent,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, textBG],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: _cardRadius,
                      bottomRight: _cardRadius,
                    ),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    timeago.format(article.published, clock: DateTime.now()),
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
              child: Text(
                article.title,
                style: textTheme.titleLarge!.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
