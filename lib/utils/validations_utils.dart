class FormValidator {
  static String? validateTextForm(String text) {
    if (text == null || text.isEmpty) {
      return '*This field is required';
    } else if (!RegExp(r'^[A-Za-z.-]+(\s*[A-Za-z.-]+)*$').hasMatch(text)) {
      return "Type a valid name";
    }
    return null;
  }

  static String? validateEmailForm(String text) {
    if (text == null || text.isEmpty) {
      return '*This field is required';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(text)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? validatePhoneForm(String text) {
    if (text == null || text.isEmpty) {
      return '*This field is required';
    } else if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(text)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static String? validateAgeForm(String text) {
    if (text == null || text.isEmpty) {
      return '*This field is required';
    } else if (int.tryParse(text)! > 200) {
      return "Age between 0 to 200 ";
    }
    return null;
  }

}
