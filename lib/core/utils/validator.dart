const String _emailPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
final RegExp _emailRegExp = RegExp(_emailPattern);

const String _phoneNumberPattern = r'(^[0]\d{10}$)|(^[\+]?[234]\d{12}$)';
final RegExp _phoneNumberRegExp = RegExp(_phoneNumberPattern);

class Validator {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    if (!_emailRegExp.hasMatch(email.trim())) return 'Email is not valid.';
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty == true) {
      return 'Phone number is required';
    }
    if (_phoneNumberRegExp.hasMatch(value.trim())) return null;
    return 'Phone number is not valid';
  }


  static String? phoneEmailValidator(String? value) {
    if (emailValidator(value) == null || validateMobile(value) == null) {
      return null;
    }
    return 'Phone Number / Email Address is not valid';
  }

  static String? requiredValidator(String? value) {
    if (value != null && value.trim().isNotEmpty) return null;
    return 'This field is required';
  }
}
