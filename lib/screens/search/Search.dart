/*
 * Screen search
 * Screen will show when client clicked to search button
 * Handle search screen if client touch to search input
 */

import 'package:flutter/material.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/models/Categories.dart';
import 'package:food_e/requests/fetchCategories.dart';
import 'package:food_e/screens/search/SearchHandle.dart';
import 'package:food_e/screens/search/SearchBlank.dart';
import 'package:food_e/screens/search/SearchHistory.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/MyInput.dart';


class Search extends StatefulWidget
{

  @override
  State<Search> createState() {
    return _Search();
  }
}


class _Search extends State<Search>
{

  // dark mode
  bool isDarkMode = false;

  // search input controller
  TextEditingController searchText = TextEditingController();

  // categories data
  late Future<List<Categories>> listCategories;

  // show or hidden clear button
  bool clearButton = false;

  // Shared Preferences Class
  final _shared = SharedPreferencesClass();

  // border input will change when enter the text
  String searchBorderColor = cnf.colorGray;

  // space between
  final double spaceBetweenFromTitleToContent = 40.0;

  // check search action
  bool searchWasClicked = false;

  // focus input
  FocusNode _focus = FocusNode();

  // focus status
  bool isTapped = false;

  /* functions */

  // log search histories
  Future<void> search({String? textSearch}) async {
    if (textSearch != null) await this._shared.search(searchText: textSearch);
  }

  // remove search key
  Future<void> delete({String ? textSearch}) async
  {
    if (textSearch != null) await this._shared.remove_search(searchText: textSearch);
  }

  Future<dynamic> fetch_search() async {
    return await this._shared.get_search();
  }

  Future<void> clear_all() async {
    await this._shared.clear_all_search();
  }

  _searchHandle() async {
    if ((this.searchText.text).length > 0) {

      // update status
      setState(() {
        this.searchWasClicked = true;
      });

      // log search
      search(textSearch: this.searchText.text);
    }
  }

  void handleRecentClickCallback(String ? recentText) {
    if (recentText != null) {
      setState(() {
        this.searchText.text = recentText;
        this.searchWasClicked = false;
        this.clearButton = true;
      });
    }
  }
  /* end functions */


  @override
  void initState() {
    this.listCategories = fetch_categories();

    _focus.addListener(_onFocusChange);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  _onFocusChange() {
    setState(() {
      this.isTapped = !this.isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      screenBgColor: cnf.colorWhite,
      disabledBodyHeight: true,
      body: _main(),
    );
  }

  // main widget of this class
  Widget _main()
  {
    return Padding(
      padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop, left: cnf.marginScreen, right: cnf.marginScreen),
      child: Column(
        children: [
          MyInput(
            focusNode: _focus,
            textController: this.searchText,
            title: "SEARCH",
            placeholder: "Cuisine / Dish",
            sufix: (this.clearButton == true) ? Icons.backspace_outlined : null,

            /*
             If click to suffix:
             - text will be clear
             - hidden suffix icon
             */
            suffixOnTap:() {
              setState(() {
                this.searchText.text = "";
                this.clearButton = false;
                this.searchWasClicked = false;
              });
              // _checkCharInInput();
            },

            /*
             If click to input form:
             - change border color of input
             - hidden suffix icon
             */
            onTap: () {
              setState(() {
                this.searchBorderColor = cnf.colorMainStreamBlue;
              });
            },

            onChanged: (value) {
              setState(() {
                this.searchWasClicked = false;
                if (this.searchText.text.length > 0) {
                  this.clearButton = true;
                } else {
                  this.clearButton = false;
                }
              });
            },
            onEditingComplete: _searchHandle,
            suffixColor: cnf.colorMainStreamBlue,
            borderColor: this.searchBorderColor,
            textInputAction: TextInputAction.search,
          ),
          Padding(
            padding: EdgeInsets.only(top: this.spaceBetweenFromTitleToContent),
            child: _childScreen()
          )
        ],
      ),
    );
  }

  Widget _childScreen()
  {
    if (this.isTapped == true && this.searchWasClicked == false) {
      return SearchHistory(onTapRecentCallBack: this.handleRecentClickCallback);
    } else if (this.searchWasClicked == true && this.clearButton == true) {
      return SearchHandle(searchText: "${this.searchText.text}");
    } else {
      return SearchBlank(recentSearchCallBack: this.handleRecentClickCallback);
    }
  }
}