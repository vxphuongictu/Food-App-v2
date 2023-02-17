import 'package:flutter/material.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/widgets/HistoryItem.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:provider/provider.dart';


class SearchHistory extends StatefulWidget
{

  bool isBlankScreen;
  Function onTapRecentCallBack;

  SearchHistory({
    this.isBlankScreen = false,
    required this.onTapRecentCallBack
  });

  @override
  State<SearchHistory> createState() {
    return _SearchHistory();
  }
}


class _SearchHistory extends State<SearchHistory>
{

  // history search data
  late List<String> search_history = [];

  // Shared Preferences Class
  final _shared = SharedPreferencesClass();

  // fetch search history
  Future<dynamic> fetch_search() async {
    return await this._shared.get_search();
  }

  // font size of title
  final double fontSizeTitle = 14.0;


  /* functions */
  // clear recent key search
  Future<void> delete({String ? textSearch}) async
  {
    if (textSearch != null) await this._shared.remove_search(searchText: textSearch);
    this.fetch_search().then((value) => {
      if (value != null) setState(() {
        this.search_history = value;
      })
    });
  }

  // clear all recent key search
  clear_all() async {
    await this._shared.clear_all_search();
    fetch_search().then((value){
      setState(() {
        this.search_history = value;
      });
    });
  }
  /* end functions */

  @override
  void initState() {
    super.initState();
    // fetch search history
    this.fetch_search().then((value) => {
      if (value != null) setState(() {
        this.search_history = value;
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    return _widgetSearchHistory();
  }


  Widget _widgetSearchHistory()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            if (this.widget.isBlankScreen == true) Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
              child: Row(
                children: [
                  MyTitle(
                    label: "RECENT",
                    fontSize: this.fontSizeTitle,
                    color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      this.clear_all();
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
                    onTap: () => this.widget.onTapRecentCallBack("${this.search_history[index]}"),
                    searchText: this.search_history[index],
                    deleteItem: () => delete(textSearch: "${this.search_history[index]}"),
                  );
                }
                return SizedBox();
              },
            )
          ],
        );
      },
    );
  }
}