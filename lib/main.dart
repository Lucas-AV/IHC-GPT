import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// LeftSide Colors
Color leftSideBarColor = const Color.fromRGBO(32,33,35,1);
Color leftSideBarHistoryItemHoverColor = const Color.fromRGBO(42,43,50,1);

// RightSide Colors
Color rightSideContainerColor = const Color.fromRGBO(52,53,65,1);
Color messageBoxInputColor = const Color.fromRGBO(64,65,79,1);
Color secondaryFloatingButtonColor = const Color.fromRGBO(62,63,75,1);
Color secondaryFloatingButtonHoverColor = const Color.fromRGBO(32,33,35,1);


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  Widget leftSideButton({String title = "New chat", IconData leading = Icons.add,bool isNewChatButton = false, double verticalPadding = 8, int index = 0}){
    BoxDecoration newChatBoxDecoration = BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 0.5,color: Colors.white54)
    );

    BoxDecoration chatHistoryBoxDecoration = BoxDecoration(
      color: currentIndex == index && leading == Icons.chat_bubble_outline? leftSideBarHistoryItemHoverColor : Colors.transparent,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Container(
        width: 250,
        height: 47,
        decoration: isNewChatButton? newChatBoxDecoration : chatHistoryBoxDecoration,
        child: RawMaterialButton(
            onPressed: (){
              if(isNewChatButton){

              } else {
                setState(() {
                  currentIndex = index;
                });
              }
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(leading,color: Colors.white,size: 16,),
                ),
                Expanded(child: Text(title,style: const TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis),maxLines: 1))
              ],
            )
        ),
      ),
    );
  }

  Widget rightSide({int index = 0}){
    return Expanded(
      child: Container(
        color: rightSideContainerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 768,
              decoration: BoxDecoration(
                color: messageBoxInputColor,
                borderRadius: BorderRadius.circular(3)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: TextField(
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Send a message...",
                              hintStyle: TextStyle(color: Colors.white38)
                          ),
                          onChanged: (e){
                            setState(() {
                              msg = textEditingController.text;
                            });
                          },
                          controller: textEditingController,
                          cursorColor: Colors.white,
                          cursorWidth: 2,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Transform.rotate(
                          angle: -7,
                          child: const Icon(MdiIcons.send,color: Colors.white70)
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4,bottom: 28),
              child: SizedBox(
                width: 768,
                height: 20,
                child: Center(child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: FittedBox(child: Text("IHC ChatGPT Version 1.0.0 - Alpha without API integration",style: TextStyle(color: Colors.white38),)),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  String generateRandomMessage(Random random) {
    final numWords = random.nextInt(8) + 1; // Random number of words between 1 and 8
    final words = generateRandomWords(numWords, random);
    return words.join(' '); // Join the words with a space to form a message
  }

  List<String> generateRandomWords(int numWords, Random random) {
    final wordList = nouns.take(500).toList(); // Take the first 500 nouns from the word list
    return List.generate(numWords, (_) => wordList[random.nextInt(wordList.length)]);
  }

  Random random = Random();
  TextEditingController textEditingController = TextEditingController();
  String msg = '';
  List<Widget> leftSideTemplate = [];
  List<String> leftSideTextTemplate = [];
  List<Widget> chats = [];

  @override
  void initState(){
    super.initState();
    setState(() {
      leftSideTextTemplate = List.generate(20, (index) => generateRandomMessage(random));
      chats = List.generate(20, (index) => rightSide(index: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    leftSideTemplate = [
      const SizedBox(
        height: 4,
      ),
      for(int i = 0; i < 20; i++)
        leftSideButton(
          title: leftSideTextTemplate[i],
          leading: Icons.chat_bubble_outline,
          verticalPadding: 0.9,
          index: i
        ),
    ];

    Widget leftMenu(){
      return Container(
        height: MediaQuery.of(context).size.height,
        width: 260,
        color: const Color.fromRGBO(32,33,35,1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: leftSideButton(isNewChatButton: true,verticalPadding: 0),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: leftSideTemplate,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 1,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    leftSideButton(
                        title: "Clear conversations",
                        leading: Icons.delete_outline,
                        verticalPadding: 0
                    ),
                    leftSideButton(
                        title: "Upgrade to Plus",
                        leading: Icons.person_outline,
                        verticalPadding: 0
                    ),
                    leftSideButton(
                        title: "Light Mode",
                        leading: Icons.light_mode_outlined,
                        verticalPadding: 0
                    ),
                    leftSideButton(
                        title: "Get Help",
                        leading: MdiIcons.exportVariant,
                        verticalPadding: 0
                    ),
                    leftSideButton(
                      title: "Log out",
                      leading: Icons.exit_to_app,
                      verticalPadding: 4,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            if(MediaQuery.of(context).size.width > 605)
              leftMenu(),

            Expanded(
              child: Container(
                color: rightSideContainerColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for(int i = 0; i < 3; i++)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: i == 1? 20:0),
                                  child: Column(
                                    children: [
                                      Icon([Icons.light_mode_outlined,MdiIcons.flashOutline,Icons.warning_amber_outlined][i],color: Colors.white,size: 24),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5,bottom: 15),
                                        child: Text(["Examples","Capabilities","Limitations"][i],style: const TextStyle(color: Colors.white,fontSize: 16)),
                                      ),
                                      for(int j = 0; j < 3; j++)
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: j == 1? 20:0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: secondaryFloatingButtonColor,
                                              borderRadius: BorderRadius.circular(3)
                                            ),
                                            child: RawMaterialButton(
                                              onPressed: (){},
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                                child: Center(
                                                  child: FittedBox(
                                                    child: Text(
                                                      "Example text of this button\nSecond Line Example",
                                                      style: TextStyle(color: Colors.white),
                                                      textAlign: TextAlign.center,
                                                    )
                                                  )
                                                ),
                                              )
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     SizedBox(
                              //       height: 60,
                              //       width: 240,
                              //       child: Column(
                              //         children: const [
                              //           Icon(Icons.light_mode_outlined,color: Colors.white,size: 24),
                              //           SizedBox(height: 5),
                              //           Text("Examples",style: TextStyle(color: Colors.white,fontSize: 16)),
                              //         ],
                              //       ),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 20),
                              //       child: SizedBox(
                              //         height: 60,
                              //         width: 240,
                              //         child: Column(
                              //           children: const [
                              //             Icon(MdiIcons.flashOutline,color: Colors.white,size: 24),
                              //             SizedBox(height: 5),
                              //             Text("Capabilities",style: TextStyle(color: Colors.white,fontSize: 16)),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       height: 60,
                              //       width: 240,
                              //       child: Column(
                              //         children: const [
                              //           Icon(Icons.warning_amber_outlined,color: Colors.white,size: 24),
                              //           SizedBox(height: 5),
                              //           Text("Limitations",style: TextStyle(color: Colors.white,fontSize: 16)),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // for(int i = 0; i < 3; i++)
                              //   Padding(
                              //     padding: EdgeInsets.symmetric(vertical: i == 1? 20:0),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         for(int j = 0; j < 3; j++)
                              //           Padding(
                              //             padding: EdgeInsets.symmetric(horizontal: j == 1? 20:0),
                              //             child: Container(
                              //               height: 80,
                              //               width: 240,
                              //               decoration: BoxDecoration(
                              //                 color: secondaryFloatingButtonColor,
                              //                 borderRadius: BorderRadius.circular(3)
                              //               ),
                              //               child: const Center(child: FittedBox(child: Text(textAlign: TextAlign.center,"Example text of this button\nSecond Line Example",style: TextStyle(color: Colors.white)))),
                              //             ),
                              //           ),
                              //       ],
                              //     ),
                              //   ),
                            ],
                          ),
                        ],
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Container(
                            width: 768,
                            decoration: BoxDecoration(
                                color: messageBoxInputColor,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: TextField(
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Send a message...",
                                            hintStyle: TextStyle(color: Colors.white38)
                                        ),
                                        onChanged: (e){
                                          setState(() {
                                            msg = textEditingController.text;
                                          });
                                        },
                                        controller: textEditingController,
                                        cursorColor: Colors.white,
                                        cursorWidth: 2,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                    child: Transform.rotate(
                                        angle: -7,
                                        child: const Icon(MdiIcons.send,color: Colors.white70)
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 4,bottom: 28),
                            child: SizedBox(
                              width: 768,
                              height: 20,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  child: FittedBox(child: Text("IHC ChatGPT Version 1.0.0 - Alpha without API integration",style: TextStyle(color: Colors.white38),)),
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
