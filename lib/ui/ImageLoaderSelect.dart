import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ImageCheck.dart';
import '../component/AppbarComp.dart';

class StateImageLoderSelect extends StatefulWidget{
  const StateImageLoderSelect({super.key});

  @override
  State<StateImageLoderSelect> createState(){
    return ImageLoderSelect();
  }
}

class ImageLoderSelect extends State<StateImageLoderSelect> {

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:[Colors.white,Color(0xFF90D4FA)],
          )
        ),
      child:Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppbarComp(),
        body: Center(
          child:Center(
            child:SingleChildScrollView(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    margin: const EdgeInsets.fromLTRB(10, 30, 10, 40),
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.blue),
                    ),
                    child:Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color:Colors.blue),
                      ),
                      child:const Text('写真のスキャン',
                        style:TextStyle(
                            color: Colors.indigo,
                            fontSize: 27,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 25, 10, 25),
                    width: 230,
                    height: 70,
                    child:ElevatedButton(
                      style:ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo
                      ),
                      child: const FittedBox(
                        child:Text('デバイスの\nライブラリから取得',
                          style:TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () async {
                        var imageSource = ImageSource.gallery;
                        final XFile? image = await _picker.pickImage(
                            source: imageSource
                        );
                        if (image != null){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageCheck(image),),);
                        }else{
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.yellow,
                                  ),
                                  Text('エラー'),
                                ],
                              ),
                              content: const Text('読み込みができませんでした。\n他の画像を選択してください'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('OK')),
                              ],
                            );
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 25, 10, 25),
                    width: 230,
                    height: 70,
                    child:ElevatedButton(
                      style:ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo
                      ),
                      child: const Text('カメラで撮影する',
                        style:TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        final XFile? image = await _picker.pickImage(
                          source: ImageSource.camera,
                        );
                        if (image != null)
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageCheck(image),),);
                      },
                    ),
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}