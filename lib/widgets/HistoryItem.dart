import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/core/SharedPreferencesClass.dart';


class HistoryItem extends StatefulWidget
{

  String? searchText;
  GestureTapCallback ? deleteItem;
  GestureTapCallback? onTap;


  HistoryItem({
    this.searchText,
    this.deleteItem = null,
    this.onTap,
  });

  @override
  State<HistoryItem> createState() {
    return _HistoryItem();
  }
}


class _HistoryItem extends State<HistoryItem>
{

  @override
  Widget build(BuildContext context) {
    return _line();
  }

  Widget _line()
  {
    return GestureDetector(
      onTap: this.widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Icon(
              Icons.history,
              color: cnf.colorGray.toColor(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: MyText(
                text: "${this.widget.searchText}",
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: cnf.colorGray,
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: this.widget.deleteItem,
              child: Icon(
                Icons.close,
                color: cnf.colorGray.toColor(),
              ),
            )
          ],
        ),
      ),
    );
  }

}