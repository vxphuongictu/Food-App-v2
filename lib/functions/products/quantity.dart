/*
 * This functions will handle action add or remove quantity products
 * It was called in screens/product/product_details.dart
 */

add({required int currentNumber})
{
  int newNumber = currentNumber + 1;
  return newNumber;
}

remove({required int currentNumber})
{
  int ? newNumber;
  if (currentNumber > 1){
    newNumber = currentNumber - 1;
  }
  return (newNumber != null) ? newNumber : currentNumber;
}