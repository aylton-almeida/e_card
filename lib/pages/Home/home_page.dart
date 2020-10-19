import 'dart:ui';

import 'package:e_card/pages/AddCard/add_card_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _onAddPress() {
    Navigator.pushNamed(context, AddCardPage.routeName);
  }

  _onCardTap() {
    // TODO: implement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E-Card')),
      body: Stack(
        children: [
          Center(
            child: Card(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: _onCardTap,
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  width: 340,
                  height: 220,
                  child: Text('Text'),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox.fromSize(
              size: Size.fromHeight(48),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: _onAddPress,
                child: Text('adicionar cartão'.toUpperCase()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
