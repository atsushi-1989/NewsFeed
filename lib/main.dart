import 'package:flutter/material.dart';
import 'package:news_feed_two/view/screens/home_screen.dart';
import 'package:news_feed_two/view/style/style.dart';
import 'package:news_feed_two/viewmodels/head_line_viewmodel.dart';
import 'package:news_feed_two/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => NewsListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => HeadLineViewModel(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NewsFeed",
      theme: ThemeData(brightness: Brightness.dark, fontFamily: BoldFont),
      home: HomeScreen(),
    );
  }
}
