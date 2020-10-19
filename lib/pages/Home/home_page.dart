import 'dart:ui';

import 'package:e_card/models/business_card.dart';
import 'package:e_card/pages/AddCard/add_card_page.dart';
import 'package:e_card/pages/Home/widgets/CustomCard/custom_card_widget.dart';
import 'package:e_card/providers/business_card_provider.dart';
import 'package:e_card/utils/slide_route_transition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _cardIndex = 0;

  @override
  void initState() {
    super.initState();

    _connectDb();
  }

  _connectDb() async {
    final cardProvider =
        Provider.of<BusinessCardProvider>(context, listen: false);
    await cardProvider.open();
    cardProvider.getCards();
  }

  _onAddPress() {
    Navigator.of(context).push(createSlideRouteTransition(
        Offset(1.0, 0), Offset.zero, Curves.ease, AddCardPage()));
  }

  _onCardTap(BusinessCard card) {
    // TODO: implement
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<BusinessCardProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('E-Card')),
      body: Stack(
        children: [
          Center(
            child: cardProvider.cardList.length > 0
                ? Container(
                    constraints: BoxConstraints.expand(),
                    child: PageView.builder(
                      itemCount: cardProvider.cardList.length,
                      controller: PageController(viewportFraction: 0.9),
                      onPageChanged: (index) =>
                          setState(() => _cardIndex = index),
                      itemBuilder: (context, i) => Transform.scale(
                        scale: i == _cardIndex ? 1 : 0.9,
                        child: Center(
                          child: CustomCard(
                            card: cardProvider.cardList[i],
                            onPress: _onCardTap,
                            context: context,
                          ),
                        ),
                      ),
                    ),
                  )
                : Text(
                    'No card registered',
                    style: TextStyle(fontSize: 18),
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
