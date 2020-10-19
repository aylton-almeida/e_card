import 'package:e_card/models/business_card.dart';
import 'package:e_card/providers/business_card_provider.dart';
import 'package:e_card/utils/alerts.dart';
import 'package:e_card/utils/input_mask.dart';
import 'package:e_card/utils/validators.dart';
import 'package:e_card/widgets/keyboardDismissContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const forms = ['name', 'email', 'phone', 'company', 'address', 'site'];

class AddCardPage extends StatefulWidget {
  static final routeName = '/addCard';

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _controllerList = Map.fromIterable(
    forms,
    key: (label) => label,
    value: (_) => [TextEditingController(), FocusNode()],
  );

  @override
  void dispose() {
    _controllerList.forEach((key, value) {
      (value.first as TextEditingController).dispose();
    });
    super.dispose();
  }

  _handleSavePress(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      dismissKeyboard(context);
      setState(() => _isLoading = true);
      final BusinessCardProvider provider =
          Provider.of<BusinessCardProvider>(context, listen: false);

      try {
        await provider.insert(BusinessCard.fromMap(_controllerList.map(
            (label, value) =>
                MapEntry(label, (value.first as TextEditingController).text))));
        Navigator.of(context).pop();
      } catch (err) {
        print(err);
        Alerts.showSnackBar(
            context: context,
            text: 'We had a problem. Please, try again later.',
            color: Colors.red);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  String Function(String) _getValidator(String label) {
    if (label == 'email') return Validators.validateEmail;
    if (label == 'name' || label == 'phone') return Validators.require;
    return (_) => null;
  }

  TextInputType _getKeyboardType(String label) {
    switch (label) {
      case 'name':
        return TextInputType.name;
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'site':
        return TextInputType.url;
      case 'address':
        return TextInputType.streetAddress;
      default:
        return TextInputType.text;
    }
  }

  List<Widget> _buildForm(
      String label, TextEditingController controller, FocusNode node) {
    final nextField = (int index) => _controllerList[forms[index + 1]].last;

    return [
      TextFormField(
        enabled: !_isLoading,
        keyboardType: _getKeyboardType(label),
        textInputAction:
            forms.last != label ? TextInputAction.next : TextInputAction.done,
        onEditingComplete: forms.last == label
            ? null
            : () => FocusScope.of(context)
                .requestFocus(nextField(forms.indexOf(label))),
        controller: controller,
        autocorrect: true,
        validator: _getValidator(label),
        textCapitalization: TextCapitalization.none,
        focusNode: node,
        inputFormatters: label == 'phone' ? [InputMasks.phoneMask()] : null,
        decoration: InputDecoration(
          filled: true,
          labelText: "${label[0].toUpperCase()}${label.substring(1)}",
          hintText: "Type your $label...",
        ),
      ),
      const SizedBox(height: 40)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Business Card'),
      ),
      body: KeyboardDismissContainer(
        child: IgnorePointer(
          ignoring: _isLoading,
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                child: Column(
                  children: [
                    ..._controllerList.entries
                        .map((e) =>
                            _buildForm(e.key, e.value.first, e.value.last))
                        .expand((e) => e),
                    Builder(
                      builder: (context) => SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _handleSavePress(context),
                          child: Text(
                            "confirm".toUpperCase(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
