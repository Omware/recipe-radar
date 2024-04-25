String? emailValidator(String? value) {
  if (value == null || value.isEmpty || !value.contains("@")) {
    return 'Please enter your email correctly';
  }
  return null;
}

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
