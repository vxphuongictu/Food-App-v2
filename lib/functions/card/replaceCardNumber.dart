
replaceChar(String oldString, int index, String newChar) {
  return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
}

carNumber(String ? number) {
  String newNumber=number!;
  for(int i=4; i< number.length;i++){
    newNumber = replaceChar(newNumber, i, "*");
  }

  return newNumber;
}