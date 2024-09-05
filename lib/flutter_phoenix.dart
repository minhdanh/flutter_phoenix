library flutter_phoenix;

import 'package:flutter/widgets.dart';

/// Wrap your root App widget in this widget and call [Phoenix.rebirth] to restart your app.
class Phoenix extends StatefulWidget {
  final Widget child;

  Phoenix({Key? key, required this.child}) : super(key: key);

  @override
  _PhoenixState createState() => _PhoenixState();

  static rebirth(BuildContext context,
      {Future<void> Function()? beforeRebirth}) async {
    if (beforeRebirth != null) {
      await beforeRebirth.call();
    }
    context.findAncestorStateOfType<_PhoenixState>()!.restartApp();
  }
}

class _PhoenixState extends State<Phoenix> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}
