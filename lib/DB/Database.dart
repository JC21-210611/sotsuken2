import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sotsuken2/Data/AllObligationData.dart';
import 'package:sotsuken2/Data/AllRecommendationData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sotsuken2/Data/AllUserData.dart';

class DBProvider {

  DBProvider._();

  static final DBProvider instance = DBProvider._();
  Database? _database;

  // Databaseが存在するかどうか確認して、あったら返す。
  Future<Database> get database async {
    debugPrint("データベースが存在しているか確認しにきました");
    if (_database != null) return _database!;
    // Databaseがない場合に作成する。
    _database = await _initDatabase();
    return _database!;
  }
  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await database;

    return await db.query('food');
  }

  Future<Database> _initDatabase() async {
    debugPrint("_initDatabaseにきました");

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'ugoku3.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    debugPrint("_onCreateしにきました");

    await db.execute('PRAGMA foreign_keys = ON;');//外部キーON
    debugPrint("外部キー指定しました");

    //ユーザ表
    await db.execute('''
    CREATE TABLE user (
    userid INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT
    )
    ''');
    debugPrint("ユーザ表を作成しました");
    //カテゴリー表
    await db.execute('''
        CREATE TABLE category(
          categoryid TEXT PRIMARY KEY,
          categoryname TEXT
        )
    ''');debugPrint("カテゴリー表を作成しました");
    //美容表
    await db.execute('''
        CREATE TABLE beauty(
          beautyid TEXT PRIMARY KEY,
          beautyname TEXT,
          categoryid TEXT,
          FOREIGN KEY(categoryid) REFERENCES category(categoryid)
        )
    ''');debugPrint("美容表を作成しました");
    await db.execute('''
        CREATE TABLE k_add(
          addid INTEGER PRIMARY KEY AUTOINCREMENT,
          userid INTEGER,
          hiragana TEXT,
          kanji TEXT,
          eigo TEXT,
          otherName TEXT,
          categoryid TEXT,
          FOREIGN KEY(userid) REFERENCES user(userid) ON DELETE CASCADE,
          FOREIGN KEY(categoryid) REFERENCES category(categoryid)
        )
    ''');debugPrint("個人追加表を作成しました");
    //食品表
    await db.execute('''
        CREATE TABLE food(
          foodid TEXT PRIMARY KEY, 
          foodname TEXT,
          categoryid TEXT,
          FOREIGN KEY(categoryid) REFERENCES category(categoryid)
        )
    ''');debugPrint("食品表を作成しました");
    //リスト表
    await db.execute('''
        CREATE TABLE list(
          listid INTEGER PRIMARY KEY AUTOINCREMENT,
          userid INTEGER,
          foodid TEXT,
          beautyid INTEGER,
          addid INTEGER,
          FOREIGN KEY(userid) REFERENCES user(userid),
          FOREIGN KEY(foodid) REFERENCES food(foodid),
          FOREIGN KEY(beautyid) REFERENCES category(beautyid),
          FOREIGN KEY(addid) REFERENCES K_add(addid)
        )
    ''');debugPrint("リスト表を作成しました");

    //初期データ
    final categories = [
      {'categoryid': 'HG', 'categoryname': '表示義務'},
      {'categoryid': 'HS', 'categoryname': '表示推奨'},
      {'categoryid': 'BH', 'categoryname': '非推奨'},
      {'categoryid': 'TS', 'categoryname': '追加成分'},
    ];

    final foods = [
      {'foodid': 'GA1', 'foodname': 'えび', 'categoryid': 'HG'},
      {'foodid': 'GA2', 'foodname': '海老', 'categoryid': 'HG'},
      {'foodid': 'GA3', 'foodname': 'shrimp', 'categoryid': 'HG'},
      { 'foodid': 'GB1','foodname': 'くるみ','categoryid': 'HG'},
      { 'foodid': 'GB2','foodname': '胡桃','categoryid': 'HG'},
      { 'foodid': 'GB3','foodname': 'walnut','categoryid': 'HG'},
      { 'foodid': 'GC1','foodname': 'かに','categoryid': 'HG'},
      { 'foodid': 'GC2','foodname': '蟹','categoryid': 'HG'},
      { 'foodid': 'GC3','foodname': 'crab','categoryid': 'HG'},
      { 'foodid': 'GD1','foodname': 'こむぎ','categoryid': 'HG'},
      { 'foodid': 'GD2','foodname': '小麦','categoryid': 'HG'},
      { 'foodid': 'GD3','foodname': 'wheat','categoryid': 'HG'},
      { 'foodid': 'GE1','foodname': 'そば','categoryid': 'HG'},
      { 'foodid': 'GE2','foodname': '蕎麦','categoryid': 'HG'},
      { 'foodid': 'GE3','foodname': 'buckwheat','categoryid': 'HG'},
      { 'foodid': 'GF1','foodname': 'たまご','categoryid': 'HG'},
      { 'foodid': 'GF2','foodname': '卵','categoryid': 'HG'},
      { 'foodid': 'GF3','foodname': 'egg','categoryid': 'HG'},
      { 'foodid': 'GG1','foodname': '乳','categoryid': 'HG'},
      { 'foodid': 'GG2','foodname': 'dairy','categoryid': 'HG'},
      { 'foodid': 'GG3','foodname': '牛乳','categoryid': 'HG'},
      { 'foodid': 'GG4','foodname': 'milk','categoryid': 'HG'},
      { 'foodid': 'GH1','foodname': 'ピーナッツ','categoryid': 'HG'},
      { 'foodid': 'GH2','foodname': '落花生','categoryid': 'HG'},
      { 'foodid': 'GH3','foodname': 'peanut','categoryid': 'HG'},
      { 'foodid': 'SA1', 'foodname': 'アーモンド', 'categoryid': 'HS'},
      { 'foodid': 'SA2', 'foodname': '扁桃', 'categoryid': 'HS'},
      { 'foodid': 'SA3', 'foodname': 'almond', 'categoryid': 'HS'},
      { 'foodid': 'SB1','foodname': 'あわび','categoryid': 'HS'},
      { 'foodid': 'SB2','foodname': '鮑','categoryid': 'HS'},
      { 'foodid': 'SB3','foodname': 'abalone','categoryid': 'HS'},
      { 'foodid': 'SC1','foodname': 'いか','categoryid': 'HS'},
      { 'foodid': 'SC2','foodname': '烏賊','categoryid': 'HS'},
      { 'foodid': 'SC3','foodname': 'squid','categoryid': 'HS'},
      { 'foodid': 'SD1','foodname': 'いくら','categoryid': 'HS'},
      { 'foodid': 'SD2','foodname': '鮭卵','categoryid': 'HS'},
      { 'foodid': 'SD3','foodname': 'salmon roe','categoryid': 'HS'},
      { 'foodid': 'SE1','foodname': 'カシューナッツ','categoryid': 'HS'},
      { 'foodid': 'SE2','foodname': '加州','categoryid': 'HS'},
      { 'foodid': 'SE3','foodname': 'cashew nuts','categoryid': 'HS'},
      { 'foodid': 'SF1','foodname': 'オレンジ','categoryid': 'HS'},
      { 'foodid': 'SF2','foodname': '甘橙','categoryid': 'HS'},
      { 'foodid': 'SF3','foodname': 'orange','categoryid': 'HS'},
      { 'foodid': 'SG1','foodname': 'キウイ','categoryid': 'HS'},
      { 'foodid': 'SG2','foodname': 'キウイフルーツ','categoryid': 'HS'},
      { 'foodid': 'SG3','foodname': '彌猴桃','categoryid': 'HS'},
      { 'foodid': 'SG4','foodname': 'kiwi','categoryid': 'HS'},
      { 'foodid': 'SH1','foodname': 'ぎゅうにく','categoryid': 'HS'},
      { 'foodid': 'SH2','foodname': '牛肉','categoryid': 'HS'},
      { 'foodid': 'SH3','foodname': 'beef','categoryid': 'HS'},
      { 'foodid': 'SI1','foodname': 'ごま','categoryid': 'HS'},
      { 'foodid': 'SI2','foodname': '胡麻','categoryid': 'HS'},
      { 'foodid': 'SI3','foodname': 'sesame','categoryid': 'HS'},
      { 'foodid': 'SJ1','foodname': 'さけ','categoryid': 'HS'},
      { 'foodid': 'SJ2','foodname': '鮭','categoryid': 'HS'},
      { 'foodid': 'SJ3','foodname': 'salmon','categoryid': 'HS'},
      { 'foodid': 'SK1','foodname': 'さば','categoryid': 'HS'},
      { 'foodid': 'SK2','foodname': '鯖','categoryid': 'HS'},
      { 'foodid': 'SK3','foodname': 'mackerel','categoryid': 'HS'},
      { 'foodid': 'SL1','foodname': 'だいず','categoryid': 'HS'},
      { 'foodid': 'SL2','foodname': '大豆','categoryid': 'HS'},
      { 'foodid': 'SL3','foodname': 'soybean','categoryid': 'HS'},
      { 'foodid': 'SM1','foodname': 'とりにく','categoryid': 'HS'},
      { 'foodid': 'SM2','foodname': '鶏肉','categoryid': 'HS'},
      { 'foodid': 'SM3','foodname': 'chicken','categoryid': 'HS'},
      { 'foodid': 'SN1','foodname': 'バナナ','categoryid': 'HS'},
      { 'foodid': 'SN2','foodname': '甘蕉','categoryid': 'HS'},
      { 'foodid': 'SN3','foodname': 'banana','categoryid': 'HS'},
      { 'foodid': 'SO1','foodname': 'ぶたにく','categoryid': 'HS'},
      { 'foodid': 'SO2','foodname': '豚肉','categoryid': 'HS'},
      { 'foodid': 'SO3','foodname': 'pork','categoryid': 'HS'},
      { 'foodid': 'SP1','foodname': 'まつたけ','categoryid': 'HS'},
      { 'foodid': 'SP2','foodname': '松茸','categoryid': 'HS'},
      { 'foodid': 'SP3','foodname': 'matsutake mushroom','categoryid': 'HS'},
      { 'foodid': 'SQ1','foodname': 'もも','categoryid': 'HS'},
      { 'foodid': 'SQ2','foodname': '桃','categoryid': 'HS'},
      { 'foodid': 'SQ3','foodname': 'peach','categoryid': 'HS'},
      { 'foodid': 'SR1','foodname': 'やまいも','categoryid': 'HS'},
      { 'foodid': 'SR2','foodname': '山芋','categoryid': 'HS'},
      { 'foodid': 'SR3','foodname': 'yam','categoryid': 'HS'},
      { 'foodid': 'SS1','foodname': 'りんご','categoryid': 'HS'},
      { 'foodid': 'SS2','foodname': '林檎','categoryid': 'HS'},
      { 'foodid': 'SS3','foodname': 'apple','categoryid': 'HS'},
      { 'foodid': 'ST1','foodname': 'ゼラチン','categoryid': 'HS'},
      { 'foodid': 'ST2','foodname': '膠','categoryid': 'HS'},
      { 'foodid': 'ST3','foodname': 'gelatin','categoryid': 'HS'},
    ];
    // カテゴリの挿入
    for (final category in categories) {
      await db.insert('category', category);
    }
    // フードの挿入
    for (final food in foods) {
      await db.insert('food', food);
    }
  }

  //-ユーザ処理一覧-
  //ユーザの追加処理
  Future<int> insertUser(AllUserData row) async {
    debugPrint("insertUserにきました");
    Database db = await instance.database;
    return await db.insert('user', row.toMap());
  }

  //usernameを削除する
  Future deleteUser(String username) async {
    debugPrint('deleteUserにきました');
    Database db = await instance.database;
    return await db.delete('user', where: 'username = ?', whereArgs: [username],);
  }

  //usernameを更新する
  Future updateUser(String UserName,String afterName) async {
    debugPrint('updateUserにきました');
    Database db = await instance.database;
    final values = <String, String>{"username": afterName,};
    await db.update("user", values, where: "username=?", whereArgs: [UserName],);
  }

  //userId,userNameをlistに格納する処理
  static List<int> userId = [];
  static List<String> userName = [];
  Future<List<String>> selectlistUser() async {
    debugPrint("selectUserにきました");
    final db = await instance.database;
    final userData = await db.query('user');
    userId.clear(); // リストを再度使用する前にクリアする
    userName.clear();
    for (Map<String, dynamic?> userMap in userData) {
      userMap.forEach((key, value) {
        if (key == 'userid') {
          userId.add(value as int);
        } else if (key == 'username') {
          userName.add(value as String);
        }
      });
    }
    return userName;
  }


  //-list処理一覧-
  //ユーザIDセレクト用
  int selectid = 1; // 単一のint型変数として宣言
  Future<int> selectUserId(String sUserName) async {
    debugPrint("selectUserIdにきました");
    Database db = await instance.database;
    final List<Map<String, dynamic>> userid =
    await db.query('user', where: 'username = ?', whereArgs: [sUserName]);
    for (Map<String, dynamic?> userMap in userid) {
      if (userMap.containsKey('userid')) {
        selectid = userMap['userid'] as int;
        print('useridを出力：$selectid');
        break; // ループを抜ける
      }
    }
    return selectid;
  }

  //表示義務の追加処理
  Future<int> insertfood(int userid ,String checkKey) async {
    debugPrint("insertfoodにきました");
    Database db = await instance.database;
    return await db.insert('list', {'userid': userid, 'foodid': checkKey,'beautyid': '--', 'addid': 0});
  }

  //表示推奨の追加処理
  Future<int> insertfood2(int userid ,String checkKey) async {
    debugPrint("insertfood2にきました");
    Database db = await instance.database;
    return await db.insert('list', {'userid': userid, 'foodid': checkKey,'beautyid': '--', 'addid': 0});
  }

  //foodlistを削除する
  Future deletefood(int userid) async {
    debugPrint('deletefoodにきました');
    Database db = await instance.database;
    return await db.delete('list', where: 'userid = ?', whereArgs: [userid],);
  }

  //特定ユーザのlist表を削除する
  Future deletelist(int userid) async {
    debugPrint('deletelistにきました');
    Database db = await instance.database;
    return await db.delete('list', where: 'userid = ?', whereArgs: [userid],);
  }



  //-アレルゲン変更処理表示用-
  //あるユーザの表示義務登録情報を参照し、GimuListに格納する処理
  static List<String> Gimuvalue = [];//とあるユーザが登録したfoodidのリスト
  static List<String> Gimulist = [];//とあるユーザが登録したfoodNameのリスト

  //表示義務
  Future<List<String>> selectGimu(int userid) async {
    debugPrint("selectGimuにきました");
    final db = await instance.database;

    Gimuvalue.clear();
    Gimulist.clear();

    //すべてのfoodid
    final foodidlist = await db.rawQuery('select foodid from list where userid = ?', [userid]);
    debugPrint('foodidlistの内容：$foodidlist');

    final gim = AllObligationData.Gimu;
    debugPrint('表示義務の内容：$gim');

    for (Map<String, dynamic?> gimu in foodidlist) {
      gimu.forEach((key, value) {
        Gimuvalue.add(value as String); // foodidを1件ずつ格納
        debugPrint('Gimuvalueの内容：$Gimuvalue');
      });
    }

    debugPrint('最終的にGimuvalueに入れた内容：$Gimuvalue');

    for (int x = 0; x < Gimuvalue.length; x++) {
      gim.forEach((key, value) {
        if (Gimuvalue[x] == key) {
          Gimulist.add(value as String);
          debugPrint('Gimulistの内容：$Gimulist');
        }
      });
    }
    debugPrint('最終的にGimulistに入れた内容：$Gimulist');
    return Gimulist;
  }


  //表示推奨
  //あるユーザの表示推奨登録情報を参照し、SuiListに格納する処理
  static List<String> Suivalue = [];//とあるユーザが登録したfoodidのリスト
  static List<String> Suilist = [];//とあるユーザが登録したfoodNameのリスト

  //表示推奨
  Future<List<String>> selectSui(int userid) async {
    debugPrint("selectSuiにきました");
    final db = await instance.database;

    Suivalue.clear();
    Suilist.clear();

    //すべてのfoodid
    final foodidlist = await db.rawQuery('select foodid from list where userid = ?', [userid]);
    debugPrint('foodidlistの内容：$foodidlist');

    final sui = AllRecommendationData.Sui;
    debugPrint('表示推奨の内容：$sui');

    for (Map<String, dynamic?> sui in foodidlist) { //foodidはある
      sui.forEach((key, value) {
        Suivalue.add(value as String); // foodidを1件ずつ格納
        debugPrint('Suivalueの内容：$Suivalue');
      });
    }

    debugPrint('最終的にSuivalueに入れた内容：$Suivalue');

    for (int x = 0; x < Suivalue.length; x++) {
      sui.forEach((key, value) {
        if (Suivalue[x] == key) {
          Suilist.add(value as String);
          debugPrint('Suilistの内容：$Suilist');
        }
      });
    }
    debugPrint('最終的にSuilistに入れた内容：$Suilist');
    return Suilist;
  }






  //-追加成分の処理-
  //追加成分の新規登録処理(登録ボタンを押したときに実行)
  //個人追加表の追加処理
  Future<int> insertAdd(int userid ,String hiragana, String kanji, String eigo,String otherName) async {
    debugPrint("insertAddにきました");
    Database db = await instance.database;
    return await db.insert('k_add', {'userid': userid, 'hiragana': hiragana, 'kanji': kanji, 'eigo': eigo, 'otherName': otherName, 'categoryid': 'TS'});
  }


  //AddIDセレクト用
  static int addid = 1; // 単一のint型変数として宣言
  Future<int> selectAddId(int userid) async {
    debugPrint("selectAddIdにきました");
    Database db = await instance.database;

    final Addid = await db.rawQuery('select addid from k_add where userid = ?',[userid]);
    debugPrint('Addidをselectした内容：$Addid');

    for (Map<String, dynamic?> ADD in Addid) {//foodidはある
      ADD.forEach((key, value) {
        addid = value! as int; // foodidを1件ずつ格納
        debugPrint('追加されたaddid：$addid');
      });
    }
    return addid;
  }


  //リスト表に個人追加成分の追加処理
  Future<int> insertlistAdd(int userid ,int addid) async {
    debugPrint("insertlistAddにきました");
    Database db = await instance.database;
    return await db.insert('list', {'userid': userid,'foodid': '--','beautyid': '--', 'addid': addid});
  }



  static List<String> AddList = [];//登録された追加成分hiraganaの全表示

  //追加登録成分の参照処理
  Future<List<String>> selectAdd() async {
    debugPrint("selectAddにきました");
    final db = await instance.database;
    AddList.clear(); //前回のデータのクリア処理
    //すべてのhiragana
    final hiragana = await db.rawQuery('SELECT hiragana FROM k_add');
    debugPrint('hiraganaの内容：$hiragana');

    for (Map<String, dynamic?> ad in hiragana) {
      ad.forEach((key, value) {
        AddList.add(value as String); // hiraganaを1件ずつ格納
        debugPrint('AddListの内容：$AddList');
      });
    }
    debugPrint('最終的にAddListに入れた内容：$AddList');
    return AddList;
  }




  //とあるユーザがリスト表に登録した追加成分の表示
  //アレルゲンの変更画面の表示に使用する
  static List<int> addvalue = [];//とあるユーザが登録したaddidのリスト
  static List<String> userAddList = [];//とあるユーザが登録したhiraganaのリスト

  Future<List<String>> selectUserADD(int userid) async {
    debugPrint("selectUserADDにきました");
    final db = await instance.database;

    addvalue.clear();//前回データのクリア処理
    userAddList.clear();

    //とあるユーザがリスト表に登録した全てのaddid
    final addidlist = await db.rawQuery('select addid from list where userid = ?', [userid]);
    debugPrint('addidlistの内容：$addidlist');

    for (Map<String, dynamic?> add in addidlist) {
      add.forEach((key, value) {
        addvalue.add(value as int); // 登録されたaddidを1件ずつ格納
        debugPrint('addvalueの内容：$addvalue');
      });
    }
    debugPrint('最終的にaddvalueに入れた内容：$addvalue');



    for (int x = 0; x < addvalue.length; x++) {
      if(addvalue[x] <= 1) { //addidが1以上なら、個人追加表に登録されているaddidと一致するhiraganaをもってくる
        final hiragana = await db.rawQuery('SELECT hiragana FROM k_add where addid = ?', [addvalue[x]]); //addidと一致するhiraganaを参照
        debugPrint('addidと一致したhiraganaの内容：$hiragana');
        for (Map<String, dynamic?> Hlist in hiragana) {//hiraganaの参照情報をMap<String, dynamic?>にいれる
          Hlist.forEach((key, value) {
            userAddList.add(value); //userAddListにhiraganaの情報をいれる
          });
        }
      }
    }
    debugPrint('最終的にuserAddListに入れた内容：$userAddList');
    return userAddList;
  }
}

class dblist{
  dblist(){
    fetchDataFromDatabase();
  }
  List<Map<String, dynamic>> databaseContent = []; // データベースの中身を格納するリスト

  // データベースの中身を取得する処理
  Future<void> fetchDataFromDatabase() async {
    databaseContent = await DBProvider.instance.getAllData();
    //setState(() {}); // データが取得されたことを反映
    debugPrint("DBくん:$databaseContent");
  }

  Future<List<Map<String, dynamic>>> getData() async{
    databaseContent = await DBProvider.instance.getAllData();
    return databaseContent;
  }
}