class ValidationFunctions {
  static bool isEmpty(String? input){
   return input == null ? false : true ;
  }
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^([\w\.]+)@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
    );

    if (!emailRegex.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool isValidPhoneNumber(String input) {
    RegExp regex = RegExp(
      r'^\d{11}$',
    );
    if (!regex.hasMatch(input)) {
      return false;
    }
    RegExp commonPhoneRegex = RegExp(
      r'^(\+?)([0-9]{1,4})?[ -]?\(?(0?[0-9]{2,4})\)?[-. ]?([0-9]{2,4})[-. ]?([0-9]{2,4})[-. ]?([0-9]{2,4})$',
    );

    return commonPhoneRegex.hasMatch(input);
  }

  static bool isString(String input) {
    RegExp regex = RegExp(
      r'^[a-zA-Z]+$',
    );
    return regex.hasMatch(input);
  }

  static bool isDigit(String input) {
    RegExp regex = RegExp(
      r'^[0-9]+$',
    );
    return regex.hasMatch(input);
  }

}
