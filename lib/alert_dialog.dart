import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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
              FlatButton.icon(
                icon: Icon(
                  EvaIcons.closeOutline,
                  color: Color(0xff950F0F),
                ),
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                label: Text(
                  noText,
                  style: TextStyle(
                    color: Color(0xff950F0F),
                  ),
                ),
                height: 30.0,
                color: Color(0xffEDA9A9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              FlatButton.icon(
                icon: Icon(
                  EvaIcons.checkmarkOutline,
                  color: Color(0xff08913F),
                ),
                onPressed: () => Navigator.of(context).pop(DialogAction.yes),
                label: Text(
                  yesText,
                  style: TextStyle(
                    color: Color(0xff08913F),
                  ),
                ),
                height: 30.0,
                color: Color(0xffA9EDC4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }
}
