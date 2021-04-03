import 'package:flutter/material.dart';

enum DialogAction {  abort }

class Dialogs {
  static Future<DialogAction> errorAbortDialog(
      BuildContext context,
      String title,
      //String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),

          ),

          title: Icon(
          Icons.warning_amber_outlined,
          color: Colors.deepOrange,
          size: 60.0,
        ),

          content:Text(title),

          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('okay',style: TextStyle(fontSize: 20),),
            ),

          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}