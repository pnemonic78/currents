import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currentsapi_core/parallax/parallax_image.dart';
import 'package:currentsapi_core/ui/flutter_ext.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

const _cardRadius = Radius.circular(4.0);

class NewsItem extends StatelessWidget {
  final News news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final imageWidth = width;
    final imageHeight = imageWidth / 1.5;
    final imageExtent = imageHeight * 0.75;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final Color textBG = theme.isDarkMode ? Colors.white54 : Colors.black54;

    final icon = Icon(
      Icons.image,
      color: Colors.grey,
      size: max(imageWidth, imageHeight),
    );

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ParallaxImage(
            extent: imageExtent,
            child: news.isValidImage
                ? CachedNetworkImage(
                    key: Key(news.id),
                    imageUrl: news.image!,
                    placeholder: (context, url) => icon,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  )
                : icon,
          ),
          Container(
            width: imageWidth,
            height: imageExtent,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.transparent, textBG],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: _cardRadius,
                bottomRight: _cardRadius,
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  news.title,
                  style: textTheme.headlineMedium!
                      .copyWith(color: colorScheme.onPrimary),
                ),
                Text(
                  timeago.format(news.published, clock: DateTime.now()),
                  style: textTheme.bodySmall!
                      .copyWith(color: colorScheme.onPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
