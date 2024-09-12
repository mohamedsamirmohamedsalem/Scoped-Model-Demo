import 'package:flutter/material.dart';

class EasyLoading extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;

  const EasyLoading({
    super.key,
    required this.child,
    required this.show,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Material(
        color: Colors.transparent,
        child: Stack(children: <Widget>[
          child,
          IgnorePointer(
            child: Opacity(
                opacity: show ? 1.0 : 0.0,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  alignment: Alignment.center,
                  color: const Color.fromARGB(100, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const CircularProgressIndicator(),
                      Text(title,
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                )),
          ),
        ]));
  }
}
