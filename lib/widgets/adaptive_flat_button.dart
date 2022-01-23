import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  // const AdaptiveFlatButton({Key? key}) : super(key: key);

  final String text;
  final VoidCallback handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child: Text(text), onPressed: handler)
        : OutlinedButton(
            child: Text(text),
            onPressed: handler,
            style: OutlinedButton.styleFrom(
              primary: Theme.of(context).accentColor,
            ),
          );
  }
}
