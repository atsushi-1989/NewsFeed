import 'package:flutter/material.dart';
import 'package:news_feed_two/data/category_info.dart';
import 'package:news_feed_two/data/search_type.dart';
import 'package:news_feed_two/models/model/news_model.dart';
import 'package:news_feed_two/view/cmponets/article_tile.dart';
import 'package:news_feed_two/view/cmponets/category_chips.dart';
import 'package:news_feed_two/view/cmponets/search_bar.dart';
import 'package:news_feed_two/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getNews(
          searchType: SearchType.CATEGORY, category: categories[0]));
    }

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
                child: Consumer<NewsListViewModel>(
                  builder: (context, model, child) {
                    return model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: model.articles.length,
                            itemBuilder: (context, int position) => ArticleTile(
                                  article: model.articles[position],
                                  onArticleClicked: (article) =>
                                      _opneArticleWebPage(article, context),
                                ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //FABの更新処理
  Future<void> onRefresh(BuildContext context) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
    print("NewsListPage.onRefresh");
  }

  //キーワード記事取得処理
  Future<void> getKeywordNews(BuildContext context, keyword) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
    print('NewsListPage.getKeywordNews');
  }

  //カテゴリー記事取得処理
  Future<void> getCategoryNews(BuildContext context, Category category) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
    print('NewsListPage.getCategoryNews / category: ${category.nameJp}');
  }

  //TODO
  _opneArticleWebPage(Article article, BuildContext context) {
    print("_openArticleWebPage: ${article.url}");
  }
}
