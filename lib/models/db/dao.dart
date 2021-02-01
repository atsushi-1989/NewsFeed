import 'package:moor/moor.dart';
import 'package:news_feed_two/models/db/database.dart';

part 'dao.g.dart';

@UseDao(tables: [ArticleRecords])
class NewsDao extends DatabaseAccessor<MyDatabase>{

}