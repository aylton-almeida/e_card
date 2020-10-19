import 'package:flutter/cupertino.dart';

class KeyboardDismissContainer extends StatelessWidget {
  final Widget child;

  KeyboardDismissContainer({Key key, @required this.child}) : super(key: key);

  void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: child,
    );
  }
}
