import 'package:moor/moor.dart';

part 'database.g.dart';

class ArticleRecords extends Table {
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishDate => text()();
  TextColumn get content => text()();
}

@UseMoor(tables: [ArticleRecords])
class MyDatabase {}
