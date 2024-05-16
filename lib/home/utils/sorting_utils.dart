mixin SortingList{

  int sortStringWithNumeric(String name1,String name2){
    int extractNumber(String name) {
      final regex = RegExp(r'\d+');
      final match = regex.firstMatch(name);
      if (match != null) {
        return int.parse(match.group(0)!);
      } else {
        return 0;
      }
    }
    int numA = extractNumber(name1);
    int numB = extractNumber(name2);

    return numA.compareTo(numB);
  }

  String normalizePhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  }

}