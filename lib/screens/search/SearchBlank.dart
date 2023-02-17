/*
 - Widget will be show when clients doesn't input form
 - the screen include recent search keywords
 */

import 'package:flutter/material.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/models/Categories.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/requests/fetchCategories.dart';
import 'package:food_e/screens/search/SearchHistory.dart';
import 'package:food_e/widgets/CategoryBox.dart';
import 'package:food_e/widgets/Loading.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:provider/provider.dart';


class SearchBlank extends StatefulWidget
{

  Function recentSearchCallBack;

  SearchBlank({
    required this.recentSearchCallBack
  });

  @override
  State<SearchBlank> createState() {
    return _SearchBlank();
  }
}


class _SearchBlank extends State<SearchBlank>
{

  // font size of title
  final double fontSizeTitle = 14.0;

  // categories data
  late Future<List<Categories>> listCategories;

  // Shared Preferences Class
  final _shared = SharedPreferencesClass();

  // history search data
  late List<String> search_history = [];

  /* functions */
  _clickToCategory()
  {
    print('mew');
  }

  // fetch search history
  Future<dynamic> fetch_search() async {
    return await this._shared.get_search();
  }

  /* end functions */

  @override
  void initState() {
    super.initState();
    this.listCategories = fetch_categories();
  }

  @override
  Widget build(BuildContext context) {
    return _blankWidget();
  }


  Widget _blankWidget()
  {
    return Column(
      children: [
        this.categories(),
        SearchHistory(isBlankScreen: true, onTapRecentCallBack: this.widget.recentSearchCallBack)
      ],
    );
  }

  // suggests categories
  Widget categories()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  MyTitle(
                    label: "CATEGORIES",
                    fontSize: this.fontSizeTitle,
                    color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
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
                  return Loading();
                }
              },
            )
          ],
        );
      },
    );
  }
}