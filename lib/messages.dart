import 'package:chat_app/message_model.dart';
import 'package:intl/intl.dart';

class Messages {
  Messages._();

  static List<Message> messages = <Message>[];

  static void templateMessage() {
    messages.addAll([
      Message(
        message: "Hello There",
        id: DateFormat("HH mm ss yy/MM/dd").format(DateTime.now()).toString(),
        hasReply: false,
        isReply: false,
        replies: null,
      )
    ]);
  }
}
