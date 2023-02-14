/*
 * Screen search
 * Screen will show when client clicked to search button
 * Handle search screen if client touch to search input
 */

import 'package:flutter/material.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/models/Categories.dart';
import 'package:food_e/requests/fetchCategories.dart';
import 'package:food_e/widgets/HistoryItem.dart';
import 'package:food_e/widgets/CategoryBox.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/requests/fetchCountries.dart';


class Search extends StatefulWidget
{
  @override
  State<Search> createState() {
    return _Search();
  }
}


class _Search extends State<Search>
{

  // font size of title
  final double fontSizeTitle = 14.0;

  // search input controller
  TextEditingController searchText = TextEditingController();

  // categories data
  late Future<List<Categories>> listCategories;

  // show or hidden clear button
  bool clearButton = false;

  // focus node. view details information where https://stackoverflow.com/questions/49341856/how-to-detect-when-a-textfield-is-selected-in-flutter
  FocusNode _focus = FocusNode();

  // Shared Preferences Class
  final _shared = SharedPreferencesClass();

  // border input will change when enter the text
  String searchBorderColor = cnf.colorGray;

  // history search data
  late List<String> search_history = [];


  /* functions */
  Future<void> search({String? textSearch}) async {
    if (textSearch != null) await this._shared.search(searchText: textSearch);
  }

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

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    this.clearButton = !this.clearButton;
    this.searchBorderColor = cnf.colorGray;
  }

  _clickToCategory()
  {
    print('mew');
  }
  /* end functions */


  @override
  void initState() {
    this.listCategories = fetch_categories();

    _focus.addListener(_onFocusChange);
    this.fetch_search().then((value) => {
      if (value != null) setState(() {
        this.search_history = value;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
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
            focusNode: this._focus,
            textController: this.searchText,
            title: "SEARCH",
            placeholder: "Cuisine / Dish",
            sufix: (this.clearButton == true) ? Icons.backspace_outlined : null,
            suffixOnTap: () => setState(() {
              this.searchText.text = "";
            }),
            onChanged: (value) => setState(() {
              this.searchBorderColor = cnf.colorMainStreamBlue;
            }),
            onEditingComplete:() {
              search(textSearch: this.searchText.text);
            },
            suffixColor: cnf.colorMainStreamBlue,
            textInputAction: TextInputAction.search,
            borderColor: this.searchBorderColor,
          ),
          this.screenBeforeEffectInput()
        ],
      ),
    );
  }

  // this widget will show when click search menu
  Widget screenBeforeEffectInput()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          if (this._focus.hasFocus == false) this.searchUnfocus(),
          if (this._focus.hasFocus == true) this.searchFocus()
        ],
      ),
    );
  }


  // this widget will show when focus search input
  Widget searchUnfocus()
  {
    return Column(
      children: [
        this.categories(),
        this.recent()
      ],
    );
  }


  // suggests categories
  Widget categories()
  {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              MyTitle(
                label: "CATEGORIES",
                fontSize: this.fontSizeTitle,
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  print("See all");
                },
                child: MyText(
                  text: "View All",
                  fontFamily: "Bebas Neue",
                  fontSize: this.fontSizeTitle,
                  fontWeight: FontWeight.w400,
                  color: cnf.colorMainStreamBlue,
                ),
              )
            ],
          ),
        ),
        FutureBuilder(
          future: this.listCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Wrap(
                children: [
                  for (var i = 0; i < cnf.searchMaxCatInScreen; i ++)
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: CategoryBox(
                        label: "${snapshot.data![i].name}",
                        onSelected: (value) => _clickToCategory,
                        textColor: cnf.colorBlack,
                      ),
                    ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  // search history
  Widget recent()
  {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
          child: Row(
            children: [
              MyTitle(
                label: "RECENT",
                fontSize: this.fontSizeTitle,
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () async {
                  this.clear_all();
                  this.fetch_search().then((value){
                    setState(() {
                      this.search_history = value;
                    });
                  });
                },
                child: MyText(
                  text: "Clear All",
                  fontFamily: "Bebas Neue",
                  fontSize: this.fontSizeTitle,
                  fontWeight: FontWeight.w400,
                  color: cnf.colorMainStreamBlue,
                ),
              )
            ],
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: this.search_history.length,
          itemBuilder: (context, index) {
            if (index < cnf.searchMaxHistory) {
              return HistoryItem(
                searchText: this.search_history[index],
                deleteItem: () {
                  this.delete(textSearch: this.search_history[index]).then((value){
                    this.fetch_search().then((value){
                      setState(() {
                        this.search_history = value;
                      });
                    });
                  });
                },
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }

  Widget searchFocus()
  {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: this.search_history.length,
      itemBuilder: (context, index) {
        if (index < cnf.searchMaxHistory) {
          return HistoryItem(searchText: this.search_history[index]);
        }
        return SizedBox();
      },
    );
  }
}