/*
 * Use this widget if you want to use light mode or darkmode
 */

import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/core/GraphQLConfig.dart';


class BaseScreen extends StatefulWidget
{

  String title; // title
  Widget? leading; // leading
  Widget? body; // body
  String appbarBgColor; // appbar color
  Widget? actions; // actions
  bool margin; // margin of body with screen. it defined in config file
  bool appbar; // show or hidden appbar
  bool scroll;
  bool extendBodyBehindAppBar;
  bool disabledBodyHeight;
  String ? screenBgColor;

  BaseScreen({
    this.body,
    this.title = "",
    this.leading,
    this.appbarBgColor= "",
    this.actions,
    this.margin=false,
    this.appbar=false,
    this.scroll=true,
    this.extendBodyBehindAppBar=true,
    this.disabledBodyHeight=false,
    this.screenBgColor=cnf.colorWhite
  });

  @override
  State<StatefulWidget> createState() {
    return _BaseScreen();
  }
}


class _BaseScreen extends State<BaseScreen>
{

  final HttpLink httpLink = HttpLink(cnf.httpLink_cnf);

  @override
  Widget build(BuildContext context) {

    final _client = GraphQLConfig.graphInit();

    return GestureDetector(
      // unfocus if tap to outside input. Details: https://stackoverflow.com/questions/51652897/how-to-hide-soft-input-keyboard-on-flutter-after-clicking-outside-textfield-anyw
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GraphQLProvider(
          client: _client,
          child: Scaffold(
            extendBodyBehindAppBar: this.widget.extendBodyBehindAppBar,
            appBar: (this.widget.appbar == true) ? AppBar(
              backgroundColor: (this.widget.appbarBgColor != "") ? this.widget.appbarBgColor.toColor() : Colors.transparent,
              elevation: (this.widget.appbarBgColor == "" || this.widget.appbarBgColor == cnf.colorWhite) ? 0.0 : null,
              title: (this.widget.title != "") ? MyText(
                text: this.widget.title,
              ) : null,
              leading: (this.widget.leading != null) ? Padding(
                padding: EdgeInsets.only(left: cnf.wcLogoMarginLeft),
                child: this.widget.leading,
              ) : null,
              leadingWidth: 80.0,
              actions: [
                if (this.widget.actions != null) Padding(
                  padding: const EdgeInsets.only(right: cnf.wcLogoMarginLeft),
                  child: this.widget.actions,
                )
              ],
            ) : null,
            body: Container(
              decoration: BoxDecoration(
                  color: this.widget.screenBgColor!.toColor()
              ),
              child: (this.widget.scroll == true) ? ListView(
                padding: EdgeInsets.zero,
                // shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [this._mainBody()],
              ) : this._mainBody(),
            )
          )
      ),
    );
  }

  Widget _mainBody()
  {
    return SizedBox(
      width: double.infinity,
      height: (this.widget.disabledBodyHeight == false) ? MediaQuery.of(context).size.height : null,
      child: (this.widget.body != null) ? Padding(
        padding: (this.widget.margin) ? const EdgeInsets.only(left: cnf.wcLogoMarginLeft, right: cnf.wcLogoMarginLeft) : EdgeInsets.zero,
        child: this.widget.body,
      ) : null,
    );
  }
}