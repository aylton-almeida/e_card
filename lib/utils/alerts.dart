import 'package:flutter/material.dart';

import 'text_scale.dart';

abstract class Alerts {
  static void showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    @required List<AlertAction> actions,
  }) =>
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: actions
                  .map(
                    (item) => FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop('dialog');
                        item.action();
                      },
                      child: Text(
                        item.content,
                        style: TextStyle(color: item.color ?? Colors.black),
                      ),
                    ),
                  )
                  .toList(),
            );
          });

  static void showSnackBar(
      {@required BuildContext context,
      @required String text,
      Color color = Colors.blueGrey,
      SnackBarAction action}) {
    color = color;
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontSize: 6 + 8 * reducedTextScale(context),
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        ),
      ),
      backgroundColor: color,
      action: action,
      behavior: SnackBarBehavior.floating,
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}

class AlertAction {
  String content;
  Function action;
  Color color;

  AlertAction({@required this.content, this.action, this.color});
}
