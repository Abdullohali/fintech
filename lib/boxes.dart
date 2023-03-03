import 'package:hive/hive.dart';
import 'package:lesson_for_fintech/model/hive_user.dart';

class Boxes {
  static Box<HiveUser> hiveBox = Hive.box<HiveUser>('all_users');
  static List<HiveUser> hiveList = hiveBox.values.toList();
}
