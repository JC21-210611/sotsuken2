import 'package:flutter/material.dart';

import '../component/AppbarComp.dart';

class StateIngredientDetails extends StatefulWidget{
  const StateIngredientDetails({super.key});

  @override
  State<StateIngredientDetails> createState(){
    return IngredientDetails();
  }
}

class IngredientDetails extends State<StateIngredientDetails>{

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:[Colors.white,Color(0xFF90D4FA)],
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:AppbarComp(),
        body: Center(
          child:SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color:Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(4,4)
                      )
                    ],
                  ),
                  child:Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    padding: const EdgeInsets.fromLTRB(10, 7, 0, 7),
                    child:  FittedBox(
                      child:RichText(
                        text:const TextSpan(
                            children: [
                              TextSpan(
                                text:'| ',
                                style: TextStyle(
                                    fontSize: 35,
                                    color:Colors.indigo,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              TextSpan(
                                text:'追加成分詳細',
                                style: TextStyle(
                                    fontSize: 27,
                                    color:Colors.indigo,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color:Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(7,7)
                      )
                    ],
                  ),
                  child:Container(
                    margin:EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:EdgeInsets.fromLTRB(7, 0, 7, 0),
                                  padding:EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:Colors.white,
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: const Text('成分名\n(必須)',
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding:EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1.5,
                                    ),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  width: 180,
                                  child: Text('成分名',style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:90,
                                  padding:EdgeInsets.fromLTRB(7, 3, 7, 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:Colors.white,
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Text('漢字\n(任意)',
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding:EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1,
                                    ),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  width: 180,
                                  child: Text('漢字',style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:90,
                                  padding:EdgeInsets.fromLTRB(7, 3, 7, 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:Colors.white,
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Text('英語\n(任意)',
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding:EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1,
                                    ),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  width: 180,
                                  child:Text('英語',style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:90,
                                  padding:EdgeInsets.fromLTRB(7, 3, 7, 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:Colors.white,
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Text('別名\n(任意)',
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding:EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1,
                                    ),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  width: 180,
                                  child: Text('別名',style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}