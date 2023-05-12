import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage(
      {Key? key, required this.hasCacheExtent, required this.controller})
      : super(key: key);
  final bool hasCacheExtent;
  final ScrollController controller;

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final width =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.controller,
      shrinkWrap: true,
      cacheExtent: (widget.hasCacheExtent) ? 50000.0 : null,
      physics: const NeverScrollableScrollPhysics(),
      dragStartBehavior: DragStartBehavior.down,
      itemCount: 200,
      itemBuilder: (context, index) => Container(
        height: 220,
        width: width,
        padding: const EdgeInsets.all(10.0),
        color: Colors.blueGrey,
        margin: const EdgeInsets.all(10.0),
        child: Image.network("https://picsum.photos/id/$index/200/300",
            fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.amber,
            alignment: Alignment.center,
            child: const Text(
              'Whoops!',
              style: TextStyle(fontSize: 30),
            ),
          );
        }),
      ),
    );
  }
}
