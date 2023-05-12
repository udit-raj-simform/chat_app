import 'package:flutter/material.dart';

class MyWidgets {
  final width =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  List<Widget>? actions = [
    const Icon(Icons.camera),
    const SizedBox(
      width: 15.0,
    ),
    const Icon(Icons.search_sharp),
    const SizedBox(
      width: 15.0,
    ),
    const Icon(Icons.more_vert_rounded),
    const SizedBox(
      width: 15.0,
    ),
  ];
  List<Widget>? chatActions = [
    const Icon(Icons.video_call_sharp),
    const SizedBox(
      width: 15.0,
    ),
    const Icon(Icons.phone),
    const SizedBox(
      width: 15.0,
    ),
    const Icon(Icons.more_vert_rounded),
    const SizedBox(
      width: 15.0,
    ),
  ];

  List<Widget> tabs = [
    const Text("Chats"),
    const Text("Status"),
    const Text("Calls"),
  ];

  Widget profileHeader() => Container(
        padding: const EdgeInsets.only(bottom: 30.0),
        height: 180,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.lightGreen,
                          radius: 40.0,
                          child: ClipOval(
                            child: Image.network(
                              "https://picsum.photos/id/136/200/300",
                              fit: BoxFit.cover,
                              height: 80.0,
                              width: 80.0,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("127K"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blueGrey.shade100,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("1K"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blueGrey.shade100,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("1200"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Posts",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blueGrey.shade100,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 25.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white30),
                                borderRadius: BorderRadius.circular(20.0)),
                            padding: const EdgeInsets.all(2.0),
                            child: const Text("@uditrajmr3"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
