int parseIntFromString(String s) =>
    int.parse(s.replaceAll(new RegExp(r'[^0-9]'), ''));

emailValidator(String? val) {
  String value = val ?? 'test';
  if (value.isEmpty || value == 'test') {
    return 'Please input email';
  } else if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return null;
  } else {
    return 'Invalid email-address';
  }
}

bool isActive(DateTime date) {
  DateTime today = DateTime.now();
  if (today.year == date.year &&
      today.day == date.day &&
      today.month == date.month) return true;
  return false;
}
