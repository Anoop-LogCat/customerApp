import 'package:flutter/material.dart';

class ScheduledPage extends StatefulWidget {
  @override
  _ScheduledPageState createState() => _ScheduledPageState();
}

class _ScheduledPageState extends State<ScheduledPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Center(
        child: Text("scheduled"),
      ),
    );
  }
}