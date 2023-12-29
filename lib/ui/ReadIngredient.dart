import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Api/api.dart';
import 'ImageLoaderSelect.dart';

class ReadIngredient extends StatefulWidget {
  const ReadIngredient(this.image, {Key? key}) : super(key: key);
  final XFile? image;

  @override
  _ReadIngredientState createState() => _ReadIngredientState();
}

class _ReadIngredientState extends State<ReadIngredient> {
  List<String> vals = ["読み込み中"];
  XFile get _image => widget.image!;

  void postData() async {
    await Api.instance.postData(_image);
    List<String> contentList = await Api.instance.getContentList();
    setState(() {
      print("セットステートするで");
      vals = contentList;
      print("vals$vals");
    });
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      postData();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('成分チェッカー'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigoAccent)),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigoAccent)),
                  child: const FittedBox(
                    child: Text(
                      '読み込み結果',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 7),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigoAccent, width: 1)),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.indigoAccent, width: 1)),
                    margin: const EdgeInsets.all(5),
                    width: 300,
                    height: 320,
                    //多分↓ここのconst邪魔になる
                    child: ListView.builder(
                      itemCount: vals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0)
                              .copyWith(left: 5.0),
                          child: Text(vals[index]),
                        );
                      },
                    ),
                  )),
              Container(
                height: 60,
                width: 300,
                margin: const EdgeInsets.all(5),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.deepOrange,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                          return const ImageLoderSelect();
                        })
                    );
                  },
                  child: const FittedBox(
                    child: Text(
                      '他の商品をスキャンする',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 300,
                margin: const EdgeInsets.all(5),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('ChooseUser_page'));
                  },
                  child: const FittedBox(
                    child: Text(
                      '他のユーザーを選択する',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
