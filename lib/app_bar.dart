import 'package:chat_app/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: -10.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.lightGreen,
            radius: 15.0,
            child: ClipOval(
              child: Image.network(
                (widget.index != 15 && widget.index != 16)
                    ? "https://picsum.photos/id/${230 + widget.index}/200/300"
                    : "https://picsum.photos/id/${219 + widget.index}/200/300",
                fit: BoxFit.cover,
                height: 30.0,
                width: 30.0,
              ),
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello World",
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
                "last seen today at ${DateFormat.Hm().format(DateTime.now()).toString()}",
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          )
        ],
      ),
      actions: MyWidgets().chatActions,
    );
  }
}
