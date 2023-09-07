import 'dart:core';

import 'content_type.dart';
import 'language.dart';
import 'region.dart';

class SearchRequest {
  // Valid value : Supported code can be found from /v1/available/languages
  String language;

  // Search news after the given date
  // Valid format : Date format should be YYYY-MM-ddTHH:mm:ss.ss±hh:mm, which follows the official standard of RFC 3339 Date and Time on the Internet
  DateTime? startDate;

  // Search news before the given date
  // Valid format : Date format should be YYYY-MM-ddTHH:mm:ss.ss±hh:mm, which follows the official standard of RFC 3339 Date and Time on the Internet
  DateTime? endDate;

  // Valid format : 1 for news, 2 for article and 3 for discussion content. All 3 types are chosen if there's no specification
  int type;

  // a country code representing news came from a region.
  // Valid value : Supported value can be found in /v1/available/regions
  String country;

  // category which the news belongs to
  // Valid value : Supported value can be found in /v1/available/categories
  String? category;

  // Filter results by website domain
  // Valid format : website primary domain name (without www or blog prefix)
  String? domain;

  // Remove website domain from results, allow you to blacklist any website from your search results
  // Valid format : website primary domain name (without www or blog prefix)
  String? domainNot;

  // Exact match of words in can be found in title or description.
  String? keywords;

  // page number to access older news from current search results
  // Valid format : Any integer number larger than zero
  int pageNumber;

  // Number of articles in each page
  // Valid format : Any integer between 1 to 200
  int pageSize;

  // Total number of articles return in results. Try set this parameter to a small number ( around 30 ) if you have complex query
  // Valid format : Any integer between 1 to 200
  int limit;

  SearchRequest({
    this.language = Language.english,
    this.startDate,
    this.endDate,
    this.type = SearchContentType.news,
    this.country = Region.regionAll,
    this.category,
    this.domain,
    this.domainNot,
    this.keywords,
    this.pageNumber = 1,
    this.pageSize = 30,
    this.limit = 30,
  });
}
