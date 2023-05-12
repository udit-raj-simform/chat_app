import 'package:chat_app/app_theme.dart';
import 'package:chat_app/chats.dart';
import 'package:chat_app/my_widgets.dart';
import 'package:chat_app/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final isTitleVisible = false;
  late final ScrollController _chatScrollController;
  late final ScrollController _statusScrollController;
  double opacity = 0.0;
  bool _isVisible = false;
  bool _hasCacheExtent = false;

  // bool? _statusMinExtent = true;
  // bool? _statusMaxExtent = false;

  @override
  void initState() {
    _chatScrollController = ScrollController();
    _statusScrollController = ScrollController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _chatScrollController.addListener(() {
        if (_chatScrollController.offset <= 30) {
          setState(() {
            opacity = (_chatScrollController.offset / 30);
          });
          // debugPrint(opacity.toString());
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _chatScrollController.dispose();
    _statusScrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     setState(() {
          //       if (_statusScrollController.offset !=
          //           _statusScrollController.position.maxScrollExtent) {
          //         _statusScrollController.animateTo(
          //             _statusScrollController.position.maxScrollExtent,
          //             duration: const Duration(milliseconds: 600),
          //             curve: Curves.decelerate);
          //         _statusMinExtent = false;
          //         _statusMaxExtent = true;
          //       } else if (_statusScrollController.offset !=
          //           _statusScrollController.position.minScrollExtent) {
          //         _statusScrollController.animateTo(
          //             _statusScrollController.position.minScrollExtent,
          //             duration: const Duration(milliseconds: 600),
          //             curve: Curves.decelerate);
          //         _statusMinExtent = true;
          //         _statusMaxExtent = false;
          //       }
          //     });
          //   },
          //   child: (_statusMinExtent!)
          //       ? const Icon(Icons.arrow_drop_down_rounded)
          //       : const Icon(Icons.arrow_drop_up_rounded),
          // ),
          appBar: AppBar(
            backgroundColor: Colors.black87.withOpacity(opacity),
            shadowColor: Colors.transparent,
            leading: const Icon(Icons.arrow_back),
            actions: const [Icon(Icons.more_horiz_rounded)],
            toolbarHeight: 45.0,
            title: Text(
              "Chat App",
              style: TextStyle(color: Colors.white.withOpacity(opacity)),
            ),
            centerTitle: false,
          ),
          body: NestedScrollView(
            controller: _chatScrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                title: const Text("Chat App"),
                centerTitle: false,
                actions: MyWidgets().actions,
                toolbarHeight: 45.0,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                MyWidgets().profileHeader(),
                TabBar(
                  labelPadding: const EdgeInsets.only(bottom: 12.0),
                  indicatorColor: Colors.blueGrey,
                  tabs: MyWidgets().tabs,
                ),
              ]))
            ],
            body: TabBarView(
              children: [
                RefreshIndicator(
                  backgroundColor: Colors.blueGrey,
                  color: Colors.black,
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2))
                        .then((value) => setState(() => _isVisible = true));
                  },
                  child: ChatsPage(
                    isVisible: _isVisible,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQueryData.fromWindow(
                                WidgetsBinding.instance.window)
                            .size
                            .width,
                        child: Row(
                          children: [
                            Switch(
                                inactiveTrackColor: Colors.blueGrey,
                                value: _hasCacheExtent,
                                onChanged: (newValue) {
                                  setState(() {
                                    _hasCacheExtent = newValue;
                                  });
                                })
                          ],
                        ),
                      ),
                      StatusPage(
                        controller: _statusScrollController,
                        hasCacheExtent: _hasCacheExtent,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Center(
                    child: Text("Calls"),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
