import 'package:sqflite/sqflite.dart';
import '../DB/Database.dart';
import '../DB/List.dart';
import '../DB/User.dart';
import '../Data/AllAnotherData.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import 'api.dart';

class verifications {
  verifications._();
  static final verifications instance = verifications._();

  List<String> select = [];
  int userid = 0;
  List<String> resultfood = [];

  Future<List<String>> verification() async {
    Database db = await DBProvider.instance.database;

    if (DBuser.userId.contains(userid)) {
      final foodId = await db.rawQuery('SELECT foodid FROM list where userid = ?', [userid]);
      List<String> foodIDValue = foodId.map((e) => e['foodid'].toString()).toList();

      List<String> foodNameValue = [];
      for (String id in foodIDValue) {
        final foodId2 = await db.rawQuery('SELECT foodname FROM food where foodid = ?', [id]);
        foodNameValue.addAll(foodId2.map((e) => e['foodname'].toString()));
      }
      select.addAll(foodNameValue);
    } else {
      select = [
        ...(await AllObligationData().getValueCheck()),
        ...(await AllRecommendationData().getValueCheck2()),
        ...(await AllAnotherData().getValueCheck3()),
        ...(await Foodselect()),
      ];
    }

    List<String> resultvalues = await Api.instance.result();

    List<String> result = select.where((str) => resultvalues.any((s) => s.contains(str))).toSet().toList();
    if (result.isEmpty) result.add("No");

    List<String> selHira = [];
    for (String str in result) {
      final selHiraQuery = await db.rawQuery('''
        SELECT hiragana 
        FROM k_add 
        WHERE hiragana = ? OR kanji = ? OR eigo = ? OR otherName = ?
      ''', [str, str, str, str]);

      selHira.addAll(selHiraQuery.map((row) => row['hiragana'].toString()).where((hiragana) => !selHira.contains(hiragana)));
    }

    for (String foodName in result) {
      final foodQuery = await db.rawQuery('SELECT foodid FROM food WHERE foodname = ?', [foodName]);

      for (Map<String, dynamic> row in foodQuery) {
        final foodId = row['foodid'].toString();
        final selId = foodId.substring(0, 2);

        Map<String, String> id = {...AllObligationData.Gimu, ...AllRecommendationData.Sui};
        final targetId = id.keys.firstWhere((key) => id[key] == foodName, orElse: () => '');

        if (targetId.contains(selId)) {
          resultfood.add(foodName);
        }
      }
    }

    resultfood.addAll(selHira);
    return resultfood;
  }

  void selectName(String UserName) async {
    DBlist dbList = DBlist();
    userid = await dbList.selectUserId(UserName);
  }

  Future<List<String>> Foodselect() async {
    Database db = await DBProvider.instance.database;
    List<Map<String, dynamic>> g = [];

    Map<String, String> obligationMappings = {
      'えび': 'GA%', 'くるみ': 'GB%', 'かに': 'GC%', '小麦': 'GD%', 'そば': 'GE%', '卵': 'GF%', '乳': 'GG%', '落花生': 'GH%',
      'あわび': 'SB%', 'いか': 'SC%', 'オレンジ': 'SF%', 'いくら': 'SD%', 'ごま': 'SI%', 'さけ': 'SJ%', 'さば': 'SK%', '大豆': 'SL%',
      '鶏肉': 'SM%', 'バナナ': 'NB%', '豚肉': 'SO%', 'まつたけ': 'SP%', 'もも': 'SQ%', 'やまいも': 'SR%', 'りんご': 'SS%',
      'ゼラチン': 'ST%', 'アーモンド': 'SA%', 'カシューナッツ': 'SE%', 'キウイフルーツ': 'SG%',
    };

    for (var value in select) {
      if (obligationMappings.containsKey(value)) {
        g.addAll(await db.rawQuery('SELECT foodname FROM food WHERE foodid LIKE ?', [obligationMappings[value]]));
      }
    }

    return g.map((data) => data['foodname'].toString()).toList();
  }
}
