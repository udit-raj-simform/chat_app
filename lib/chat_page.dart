import 'package:chat_app/app_bar.dart';
import 'package:chat_app/message_model.dart';
import 'package:chat_app/messages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  final width =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  final height =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  bool isReplying = false;
  Message? replyMessage;

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    Messages.templateMessage();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        index: widget.index,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: messagesList(),
          ),
          sendMessageWidget(),
        ],
      ),
    );
  }

  Widget sendMessageWidget() => Container(
        width: width,
        height: isReplying ? kToolbarHeight * 2.2 : kToolbarHeight,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: isReplying
            ? Column(
                children: [
                  IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: [
                          Container(
                            width: 5.0,
                            color: Colors.red,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Udit Raj",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => isReplying = false),
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    replyMessage != null
                                        ? replyMessage!.message.toString()
                                        : "",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        const TextStyle(color: Colors.black45),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  textFieldRow(),
                ],
              )
            : textFieldRow(),
      );

  Widget textFieldRow() => Row(
        children: [
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                border: InputBorder.none,
              ),
              onFieldSubmitted: (value) => sendMessage(value),
            ),
          ),
          IconButton(
            onPressed: () => sendMessage(_controller.text.toString()),
            icon: const Icon(
              Icons.send_rounded,
              color: Colors.cyan,
              size: 25.0,
            ),
          ),
        ],
      );

  void sendMessage(String message) {
    setState(
      () => Messages.messages.add(
        Message(
          message: message,
          id: DateFormat("HH mm ss yy/MM/dd").format(DateTime.now()).toString(),
          hasReply: false,
          isReply: isReplying,
        ),
      ),
    );
    _controller.text = "";
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear);
  }

  Widget messagesList() => ListView.builder(
        controller: _scrollController,
        itemCount: Messages.messages.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Messages.messages[index].isReply
            ? replyMessageItem(index)
            : messageItem(index),
      );

  Widget replyMessageItem(int index) => GestureDetector(
        onTap: () {
          setState(() {
            isReplying = true;
            replyMessage = Messages.messages[index];
          });
          _focusNode.requestFocus();
        },
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 0) {}

          // Swiping in left direction.
          if (details.delta.dx <= 0) {
            try {
              Messages.messages.removeAt(index);
              setState(() {});
              showSnackBar("Message deleted");
            } catch (e) {
              showSnackBar("Something went wrong!");
            }
          }
        },
        child: Container(
            width: width,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        Container(
                          width: 5.0,
                          color: Colors.red,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Udit Raj",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  replyMessage != null
                                      ? replyMessage!.message.toString()
                                      : "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      Messages.messages[index].message.toString(),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ],
            )),
      );

  Widget messageItem(int index) => GestureDetector(
        onTap: () {
          setState(() {
            isReplying = true;
            replyMessage = Messages.messages[index];
          });
          _focusNode.requestFocus();
        },
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 0) {}

          // Swiping in left direction.
          if (details.delta.dx <= 0) {
            try {
              Messages.messages.removeAt(index);
              setState(() {});
              showSnackBar("Message deleted");
            } catch (e) {
              showSnackBar("Something went wrong!");
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10.0, bottom: 5.0, top: 5.0),
          child: Row(
            children: [
              const Spacer(),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      Messages.messages[index].message.toString(),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void showSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey.withOpacity(0.6),
          showCloseIcon: true,
          closeIconColor: Colors.white,
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
