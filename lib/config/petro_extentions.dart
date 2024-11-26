extension StringExtensions on String {
  // Extension to show at least two characters
  String showAtLeastTwoCharacters() {
    int index = indexOf(":");
    // Check if the string has less than 2 characters
    if (index == 2 && length < 5) {
      return replaceAll(RegExp(r':'), ":0"); // Return the string as it is
    } else if (index == 1 && length == 3) {
      String firstLetter = substring(0, 1);
      return replaceFirst(RegExp(r':'), ":0").replaceFirst(
          RegExp(firstLetter),
          "0$firstLetter"); // Return the first 2 characters
    } else {
      String firstLetter = substring(0, 1);
      return this..replaceFirst(RegExp(firstLetter), "0$firstLetter");
    }
  }
}
