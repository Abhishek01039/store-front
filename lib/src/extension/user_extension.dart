extension UserExtension on String {
  String fullName(String? firstName, String? lastName) {
    var fullName = '';

    // check the first name is empty or not
    if (firstName?.isNotEmpty == true) {
      fullName += firstName!;
    }

    // check the last name is empty or not
    if (lastName?.isNotEmpty == true) {
      fullName += ' ${lastName!}';
    }

    // check the full name is empty or not
    if (fullName == '') {
      fullName = 'Unknown';
    }

    return fullName.trim();
  }
}
