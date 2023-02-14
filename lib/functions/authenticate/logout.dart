import 'package:food_e/core/SharedPreferencesClass.dart';


Future<void> logout() async
{
  SharedPreferencesClass _share = SharedPreferencesClass();
  await _share.remove_user_info();
}