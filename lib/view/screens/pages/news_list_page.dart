import 'package:flutter/material.dart';
import 'package:news_feed_two/data/category_info.dart';
import 'package:news_feed_two/view/cmponets/category_chips.dart';
import 'package:news_feed_two/view/cmponets/search_bar.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //検索ワード
              SearchBar(
                onSearch: (keyword) => getKeywordNews(context, keyword),
              ),

              //カテゴリー選択Chips
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
              ),

              //Todo 記事表示
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //FABの更新処理
  onRefresh(BuildContext context) {
    print("NewsListPage.onRefresh");
  }

  //TODO キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    print('NewsListPage.getKeywordNews');
  }

  //TODO カテゴリー記事取得処理
  getCategoryNews(BuildContext context, Category category) {
    print('NewsListPage.getCategoryNews / category: ${category.nameJp}');
  }
}
