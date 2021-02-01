import 'package:flutter/material.dart';
import 'package:news_feed_two/data/search_type.dart';
import 'package:news_feed_two/models/model/news_model.dart';
import 'package:news_feed_two/view/cmponets/head_line_item.dart';
import 'package:news_feed_two/view/cmponets/page_transformer.dart';
import 'package:news_feed_two/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

import '../news_web_page_screen.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        //TODO
        body: Consumer<HeadLineViewModel>(
          builder: (context, model, child) {
            if (model.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return PageTransformer(
                pageViewBuilder: (context, pageVisibilityResolbver) {
                  return PageView.builder(
                      controller: PageController(viewportFraction: 0.85),
                      itemCount: model.articles.length,
                      itemBuilder: (context, index) {
                        final article = model.articles[index];
                        final pageVisibility = pageVisibilityResolbver
                            .resolvePageVisibility(index);
                        final visibleFraction = pageVisibility.visibleFraction;
                        return HeadLineItem(
                          article: model.articles[index],
                          pageVisibility: pageVisibility,
                          onArticleClicked: (article) =>
                              _openArticleWebPage(context, article),
                        );
                      });
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => onRefresh(context),
        ),
      ),
    );
  }

  //TODO
  onRefresh(BuildContext context) async {
    print("HeadLinePage.onRefresh");
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }

  _openArticleWebPage(BuildContext context, Article article) {
    print("HeadLinePage. _openArticleWebPage: ${article.url}");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(
              article: article,
            )));
  }
}
