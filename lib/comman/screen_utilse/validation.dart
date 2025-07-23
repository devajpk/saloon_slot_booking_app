class Validations {
  static String? emailOrNumberValidation(String? value) {
    
    RegExp numberRegExp = RegExp(r'^\d{10}$'); // Ensures exactly 10 digits
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (value == null || value.isEmpty) {
      return 'Please enter an email or a phone number';
    }
    if (!emailRegExp.hasMatch(value) && !numberRegExp.hasMatch(value)) {
      return 'Enter a valid email address or a 10-digit phone number';
    }
    return null;
  }
  String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }

  // Allowing numbers only and checking for length (10 digits typically)
  final RegExp phoneExp = RegExp(r'^[0-9]{10}$');

  if (!phoneExp.hasMatch(value)) {
    return 'Enter a valid 10-digit phone number';
  }

  return null; // Valid
}

  static String? emailValidation(String? value) {
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (value == null || value.isEmpty) {
      return null;
    }
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a correct email address or phone number';
    }
    return null;
  }

  static String? emailOnlyValidation(String? value) {
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (value == null || value.isEmpty) {
      return 'Enter an Email';
    }
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a correct email';
    }
    return null;
  }

  static String? isPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is Required';
    if (value.length < 6) return 'Password must be greater than 6 characters';
    return null;
  }

  static String? noSpaceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty or contain only spaces';
    }
    return null;
  }

  static String? emtyValidation(String? value) {
    if (value == null || value.trim() == '') {
      return 'fill the feild ';
    } else {
      return null;
    }
  }

  static String? priceValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }

    final double? price = double.tryParse(value);
    if (price == null || price <= 0) {
      return 'Please enter a valid price';
    }

    return null;
  }

  static String? conformPasswordValidation(
      String password, String conPassword) {
    if (password != conPassword || password == '') {
      return 'Password is mismatched';
    } else {
      return null;
    }
  }
  
  static String? conformNumberValidation(
      String password, String conPassword) {
    if (password != conPassword || password == '') {
      return 'Number is mismatched';
    } else {
      return null;
    }
  }

  static String? numberValidation(String? value) {
    // only match exactly 10 digits
    final numberRegExp = RegExp(r'^\d{10}$');
    if (value == null || !numberRegExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit number';
    }
    return null;
  }
}
