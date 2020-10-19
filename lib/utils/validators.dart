abstract class Validators {
  static String validateEmail(String value) {
    if (value.isEmpty) return 'Type your email address.';
    final RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!emailExp.hasMatch(value)) return 'Invalid email address.';
    return null;
  }

  static String require(String value) {
    if (value == null) return 'Select an option.';
    if (value.isEmpty) return 'Fill this field.';
    return null;
  }
}
