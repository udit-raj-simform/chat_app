import 'package:chat_app/chat_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key, required this.isVisible}) : super(key: key);
  final bool isVisible;

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return ListView.builder(
      itemCount: 20,
      dragStartBehavior: DragStartBehavior.down,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => (widget.isVisible)
          ? GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    index: index,
                  ),
                ),
              ),
              child: SizedBox(
                width: width,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    child: ClipOval(
                      child: Image.network(
                        (index != 15 && index != 16)
                            ? "https://picsum.photos/id/${230 + index}/200/300"
                            : "https://picsum.photos/id/${219 + index}/200/300",
                        fit: BoxFit.cover,
                        height: 40.0,
                        width: 40.0,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Hello World"),
                      Text(
                        DateFormat("dd//MM/yy")
                            .format(DateTime.now())
                            .toString(),
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "You did a good job. Keep it up.",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
