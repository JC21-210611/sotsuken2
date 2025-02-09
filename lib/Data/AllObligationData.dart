import 'package:flutter/material.dart';
import 'AllUserData.dart';
import '../DB/Database.dart';

class AllObligationData{

  static List<bool> boolList = List.filled(8, false);
  static List<String> valueList = ["えび","かに","くるみ","小麦","そば","卵","乳","落花生",];
  static List<String> valueCheck = [];  //trueの名前

  //みちるちゃんの
  static Map<String, String> Gimu = {"HG1":"えび", "HG2":"かに", "HG3":"くるみ", "HG4":"小麦", "HG5":"そば", "HG6":"卵", "HG7":"乳", "HG8":"落花生",};
  static List<String> CheckValue = []; // チェックされた食品名を格納
  static List<String> foodid = [];    // foodidをリストに格納

  //追加
  String getValueString(){
    debugPrint(valueList.length.toString());
    return valueList.toString();
  }

  List<String> getValue(){
    return valueList;
  }

  List<bool> getBool(){
    return boolList;
  }



  void setObligationBool(List<bool> box){
    boolList.clear();
    boolList.addAll(box);
  }

  void HanteiObligation(){
    valueCheck.clear();
    for(int x = 0;x < boolList.length; x++){
      if(boolList[x] == true){
        valueCheck.add(valueList[x]);
      }
    }
    debugPrint(valueCheck.toString());
  }

  List<String> getValueCheck(){
    debugPrint("valueCheckのなかみ$valueCheck");
    return valueCheck;
  }

  void setValueCheck(List<String> dbValue){
    debugPrint("setvalueCheckのなかみ$dbValue");
   valueCheck =  dbValue;
  }

  void AllResetObligation(){
    boolList = List.filled(8, false);
    valueCheck = [];
  }

  void valueChangeBool1(){
    int count = 0;
    for(String value in DBProvider.Gimulist){
      while(true){
        if(valueList[count] == value){
          boolList[count] = true;
          count++;
          break;
        }else{
          boolList[count] = false;
        }
        count++;
      }
    }
  }


  //追加した処理12/21
  //みちるちゃんの
  void insertHanteiObligation() async {
    debugPrint('insertHanteiObligationに来ました');
    final dbProvider = DBProvider.instance;
    CheckValue.clear();//foodidのクリア
    CheckValue = getValueCheck();
    foodid.clear();//追加した処理12/21
    for (int x = 0; x < CheckValue.length; x++) {
      Gimu.forEach((key, value) { //foodidのみを出力
        if (value == CheckValue[x]) { //もしGimuリストのfoodNameとCheckValueのfoodNameが一致したら
          foodid.add(key as String); // foodidリストにGimuリストのfoodidを格納
        }
      });
    }
    debugPrint('最終的なfoodidの内容:$foodid');
    final int userid = await dbProvider.selectUserId(AllUserData.sUserName);// ユーザーIDを非同期で取得
    debugPrint('useridの内容:$userid');
    for (int x = 0; x < foodid.length; x++) {
      final result2 = await dbProvider.insertfood(userid, foodid[x]);// ここでDBにuseridとCheckKeyを渡す（insert）
      debugPrint('foodidの内容だよ:$foodid');
    }
    debugPrint(CheckValue.toString());
  }
}