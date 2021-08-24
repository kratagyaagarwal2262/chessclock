import 'package:chessclock/dialogs/exit_conformation.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static exit(context) =>
      showDialog(context: context, builder: (context) => ExitConfirmation());
}
