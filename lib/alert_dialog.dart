import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbort(BuildContext context, String title,
      String content, String yesText, String noText) async {
    final Future<DialogAction> action = showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(
              title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            content: Text(
              content,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: Text(noText),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.yes),
                child: Text(yesText),
              )
            ],
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }
}
