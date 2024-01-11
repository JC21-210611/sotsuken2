import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sotsuken2/Api/api.dart';
import 'package:sotsuken2/ui/AllergyNotDetection.dart';
import 'dart:io';
import 'AllergyDetection.dart';

class ImageCheck extends StatefulWidget {
  const ImageCheck(this.image, {Key? key}) : super(key: key);
  final XFile image;

  @override
  _ImageCheckState createState() => _ImageCheckState();
}

class _ImageCheckState extends State<ImageCheck> {
  bool isLoading = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    margin: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Text(
                        '写真のスキャン',
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  Container(
                    width: 250,
                    child: Image.file(File(widget.image.path)),
                  ),

                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'この画像でよろしいですか？',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(7, 5, 20, 15),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
                          child: const Text(
                            'いいえ',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(context, '/');
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(7, 5, 20, 15),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.indigo,
                              )),
                          child: const Text(
                            'はい',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await Api.instance.postData(widget.image);
                            List<String> content = await Api.instance.result();
                            setState(() {
                              isLoading = false;
                            });

                            if (!content.contains("No")) {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return StateAllergyDetection();
                                }),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return StateAllergyNotDetection();
                                }),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.crop,
                        color: Colors.white,
                      ),
                      label: const Text("トリミング"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        
                      },
                    ),
                  ),
                ],
              ),
            ),

            // プログレスバーの表示
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
