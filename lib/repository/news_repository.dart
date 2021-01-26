import 'package:flutter/material.dart';
import 'package:news_feed_two/data/category_info.dart';
import 'package:news_feed_two/data/search_type.dart';

class NewsRepository {
  Future<void> getNews(
      {@required SearchType searchType,
      String keyword,
      Category category}) async {
    //TODO
    print(
        "[Repository] searchType: $searchType / keyword: $keyword / categoy: ${category.nameJp}");
  }
}
