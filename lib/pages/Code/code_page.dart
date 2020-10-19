import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CodePageArgs {
  final String data;
  final int id;

  CodePageArgs({this.data, this.id});
}

class CodePage extends StatefulWidget {
  static final routeName = "/code";

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  _onClosePress() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final CodePageArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: InkWell(
        onTap: _onClosePress,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).accentColor,
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Hero(
              tag: "qrCode${args.id}",
              child: QrImage(
                data: args.data,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
