import 'package:flutter/material.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:flutter_switch/flutter_switch.dart';


class SwitchGroup extends StatefulWidget
{

  late String ? label;
  late String ? lableColor;
  late bool isOn;
  late FontWeight lableFontWeight;
  Function callback;

  SwitchGroup({
    this.label,
    this.lableColor,
    this.isOn = false,
    this.lableFontWeight=FontWeight.w500,
    required this.callback
  });

  @override
  State<SwitchGroup> createState() {
    return _SwitchGroup();
  }
}

class _SwitchGroup extends State<SwitchGroup>
{

  final double _sizeText    = 16.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Row(
        children: [
          Expanded(
            child: MyText(
              text: "${this.widget.label}",
              fontSize: this._sizeText,
              align: TextAlign.start,
              fontWeight: this.widget.lableFontWeight,
              color: (this.widget.lableColor != null) ? this.widget.lableColor! : '',
            ),
          ),
          switchButton()
        ],
      ),
    );
  }

  Widget switchButton()
  {
    return FlutterSwitch(
      width: 50.0,
      height: 25.0,
      valueFontSize: 13.0,
      toggleSize: 15.0,
      value: this.widget.isOn,
      borderRadius: 30.0,
      padding: 5.0,
      activeColor: Colors.green,
      onToggle: (val) {
        setState(() {
          this.widget.isOn = val;
          this.widget.callback(val);
        });
      },
    );
  }
}