import 'package:e_card/utils/input_mask.dart';
import 'package:e_card/utils/validators.dart';
import 'package:e_card/widgets/keyboardDismissContainer.dart';
import 'package:flutter/material.dart';

const forms = ['name', 'email', 'telefone', 'empresa', 'endereço', 'site'];

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

  String Function(String) t;

  _handleSavePress() {
    // TODO: implement
  }

  String Function(String) _getValidator(String label) {
    if (label == 'email')
      return Validators.validateEmail;
    else
      return Validators.require;
  }

  TextInputType _getKeyboardType(String label) {
    switch (label) {
      case 'nome':
        return TextInputType.name;
      case 'email':
        return TextInputType.emailAddress;
      case 'telefone':
        return TextInputType.phone;
      case 'site':
        return TextInputType.url;
      case 'endereço':
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
        inputFormatters: label == 'telefone' ? [InputMasks.phoneMask()] : null,
        decoration: InputDecoration(
          filled: true,
          labelText: "${label[0].toUpperCase()}${label.substring(1)}",
          hintText: "Digite ${label.endsWith('a') ? 'sua' : 'seu'} $label...",
        ),
      ),
      const SizedBox(height: 40)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Cartão'),
      ),
      body: KeyboardDismissContainer(
        child: IgnorePointer(
          ignoring: _isLoading,
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    ..._controllerList.entries
                        .map((e) =>
                            _buildForm(e.key, e.value.first, e.value.last))
                        .expand((e) => e),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSavePress,
                        child: Text(
                          "confirmar".toUpperCase(),
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

/**
  nome 
  email
  telefone
  empresa
  endereco
  site 
  */
