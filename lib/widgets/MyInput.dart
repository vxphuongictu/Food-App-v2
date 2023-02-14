import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/MyText.dart';


class MyInput extends StatefulWidget
{
  String title;
  String placeholder;
  String bgColor;
  double radius;
  String titleColor;
  String textColor;
  double fontSize;
  FontWeight titleFontWeight;
  String titleFontFamily;
  TextAlign titleAlign;
  FontStyle titleFontStyle;
  ValueChanged<String>? onChanged;
  String defaultText;
  bool hiddenText;
  bool filled;
  IconData ? sufix;
  String suffixColor;
  IconData ? perfix;
  GestureTapCallback? suffixOnTap;
  TextEditingController ? textController;
  bool isNumber;
  double width;
  bool boder;
  GestureTapCallback? onTap;
  bool autofocus;
  TextInputAction textInputAction;
  FocusNode ? focusNode;
  String borderColor;
  VoidCallback ? onEditingComplete;

  MyInput({
    this.title="",
    this.placeholder="",
    this.bgColor=cnf.colorGrayInputBg,
    this.radius=cnf.input_radius,
    this.titleColor=cnf.colorMainStreamBlue,
    this.textColor=cnf.colorGray,
    this.fontSize = cnf.input_text_fontSize,
    this.titleFontWeight=FontWeight.w400,
    this.titleFontFamily="Bebas Neue",
    this.titleAlign = TextAlign.left,
    this.titleFontStyle = FontStyle.normal,
    this.onChanged,
    this.defaultText="",
    this.hiddenText = false,
    this.filled=true,
    this.sufix=null,
    this.perfix=null,
    this.suffixOnTap=null,
    this.textController,
    this.isNumber=false,
    this.width=double.infinity,
    this.boder = true,
    this.onTap,
    this.autofocus=false,
    this.suffixColor=cnf.colorMainStreamBlue,
    this.textInputAction=TextInputAction.done,
    this.focusNode,
    this.borderColor=cnf.colorGray,
    this.onEditingComplete=null
  });

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  @override
  Widget build(BuildContext context) {
    return _MyInput();
  }

  Widget _MyInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (this.widget.title != "") Container(
          margin: const EdgeInsets.only(left: cnf.input_padding_left_text, bottom: 10.0),
          child: MyText(
            text: "${this.widget.title}",
            fontSize: this.widget.fontSize,
            color: this.widget.titleColor,
            fontWeight: this.widget.titleFontWeight,
            fontFamily: this.widget.titleFontFamily,
            align: this.widget.titleAlign,
            fontStyle: this.widget.titleFontStyle,
          ),
        ),
        SizedBox(
          width: this.widget.width,
          child: TextField(
            textInputAction: this.widget.textInputAction,
            autofocus: this.widget.autofocus,
            focusNode: this.widget.focusNode,
            controller: this.widget.textController,
            onTap: this.widget.onTap,
            onChanged: this.widget.onChanged,
            onEditingComplete: this.widget.onEditingComplete,
            obscureText: this.widget.hiddenText,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: this.widget.placeholder,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(this.widget.radius),
                borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(this.widget.radius),
                  borderSide: BorderSide(
                      color: (this.widget.boder == true) ? this.widget.borderColor.toColor() : Colors.transparent,
                      width: (this.widget.boder == true) ? 1 : 0
                  )
              ),
              filled: this.widget.filled,
              fillColor: this.widget.bgColor.toColor(),
              prefixIcon: (this.widget.perfix != null) ? Icon(this.widget.perfix) : null,
              suffixIcon: (this.widget.sufix != null && this.widget.suffixOnTap == null) ? Icon(this.widget.sufix, color: this.widget.suffixColor.toColor()) : GestureDetector(
                onTap:this.widget.suffixOnTap,
                child: Icon(this.widget.sufix, color: this.widget.suffixColor.toColor()),
              ),
              contentPadding: (this.widget.perfix != null) ? EdgeInsets.zero : EdgeInsets.only(left: cnf.input_padding_left_text),
            ),
            inputFormatters: [
              if (this.widget.isNumber) FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
      ],
    );
  }
}