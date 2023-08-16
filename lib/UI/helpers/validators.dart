String? emailValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter username';
  }
  if (!value.contains('@gmail.com') && !value.contains('@email.com')) {
    return 'Invalid email';
  }
  return null;
}

String? passValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 8) {
    return 'Password must be 8 characters or more';
  }
  return null;
}
