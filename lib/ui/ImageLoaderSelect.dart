import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ImageCheck.dart';

class ImageLoderSelect extends StatelessWidget{
  const ImageLoderSelect({super.key}); //無くても動く(上とセット)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title:'タイトル',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: const Home_Page_State()
                    // ↑名前変えたいかも
    );
  }
}
    // ↓ここらへんも全部
class Home_Page_State extends StatefulWidget{
  const Home_Page_State({super.key});

  @override
  State<Home_Page_State> createState(){
    return Home_Page();
  }
}

class Home_Page extends State<Home_Page_State> {

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Scaffold(
      body: Center(
        child:Center(
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
                  child: const Text('デバイスの\nライブラリから取得',
                    style:TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () async {
                    final XFile? image = await _picker.pickImage(
                        source: ImageSource.gallery
                    );
                    if (image != null)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ImageCheck(image),),);
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
                        fontSize: 21,
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
    );
  }
}