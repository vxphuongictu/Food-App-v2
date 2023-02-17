/*
 * Dependencies:
 * - shared_preferences: ^2.0.15
 *
 * This file will storage all session of the app
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_e/models/Address.dart';
import 'package:food_e/screens/authenticate/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_e/models/Login.dart' as login_model;
import 'package:food_e/models/Account.dart' as account_model;
import 'package:food_e/models/Payment.dart';


class SharedPreferencesClass
{
  // Obtain shared preferences.
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  search({String ? searchText}) async
  {
    List<String> temp = [];
    final SharedPreferences prefs = await _prefs;

    try {
      final List<String> currentHistories = await this.get_search(); // if available history
      for (var item in currentHistories) temp.add(item);
    } catch (e) {
      // if unavailable history
    }

    temp.add(searchText.toString());
    prefs.setStringList('search', temp);
  }

  get_search() async
  {
    final SharedPreferences prefs = await _prefs;
    late List<String> ? data;
    try {
      data = await prefs.getStringList('search');
      return data?.reversed.toList();
    } catch (e) {
      // unavailable history
    }
    return data;
  }

  remove_search({required String searchText}) async {
    final SharedPreferences prefs = await _prefs;
    List<String> ? data =  await prefs.getStringList('search');
    data?.removeWhere((item) => item == searchText);
    await prefs.setStringList('search', data!);
  }

  clear_all_search() async {
    List<String> temp = [];
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList('search', temp);
  }

  set_user_info({String ? userID, String ? email, String ? firstname, String ? displayname, String ? authToken}) async {
    final SharedPreferences prefs = await _prefs;
    dynamic data = {
      'userID' : userID,
      'email' : email,
      'firstname' : firstname,
      'displayname' : displayname,
      'authToken' : authToken
    };
    await prefs.setString('account', jsonEncode(data));
  }

  get_user_info() async {
    final SharedPreferences prefs = await _prefs;
    try {
      final user = await prefs.getString('account');
      final data = account_model.Account.formJson(json.decode(user!));
      return data;
    } catch (e) {
      return null;
    }
  }

  remove_user_info() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('account', '');
  }

  // dark mode config
  set_dark_mode({required bool option}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('dark_mode', option);
  }

  get_dark_mode_options() async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.getBool('dark_mode');
  }
}