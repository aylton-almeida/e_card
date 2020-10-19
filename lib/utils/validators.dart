//Class containing text input validation functions

abstract class Validators {
  static String validateEmail(String value) {
    if (value.isEmpty) return 'Digite seu email.';
    final RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!emailExp.hasMatch(value)) return 'Endereço de email invalido.';
    return null;
  }

  static String require(String value) {
    if (value == null) return 'Selecione uma opção';
    if (value.isEmpty) return 'Preencha o campo';
    return null;
  }
}
