import 'package:e_card/models/business_card.dart';
import 'package:e_card/pages/Code/code_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard/vcard.dart';

class CustomCard extends StatelessWidget {
  final BusinessCard card;
  final void Function(BusinessCard card) onPress;
  final BuildContext context;

  const CustomCard({Key key, this.card, this.onPress, this.context})
      : super(key: key);

  _onQrCodeTap() {
    Navigator.pushNamed(context, CodePage.routeName,
        arguments: CodePageArgs(data: _buildCodeData(card)));
  }

  String _buildCodeData(BusinessCard card) {
    final vCard = VCard();
    vCard.firstName = card.name;
    vCard.email = card.email;
    vCard.workPhone = card.phone;
    vCard.organization = card.company;
    vCard.workAddress = MailingAddress(card.address);
    vCard.url = card.site;

    return vCard.getFormattedString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () => onPress(card),
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          constraints: BoxConstraints.tight(Size(340, 220)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DefaultTextStyle(
                style: TextStyle(color: Colors.white, fontSize: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Theme.of(context).accentColor,
                      constraints: BoxConstraints.expand(width: 120),
                      child: Center(
                        child: InkWell(
                          onTap: _onQrCodeTap,
                          splashColor: Theme.of(context).accentColor,
                          child: Hero(
                            tag: "qrCode",
                            child: QrImage(
                              data: _buildCodeData(card),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(card.name, style: TextStyle(fontSize: 22)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(card.company),
                            const SizedBox(height: 10),
                            Text(card.email),
                            const SizedBox(height: 10),
                            Text(card.phone)
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
