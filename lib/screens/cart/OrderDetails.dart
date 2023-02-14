import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';


class OrderDetails extends StatefulWidget
{
  @override
  State<OrderDetails> createState() {
    return _OrderDetails();
  }
}

class _OrderDetails extends State<OrderDetails>
{

  final List<dynamic> list_details = [
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover,), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover,), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover,), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00},
  ];

  double boxProductHeight = 85.0; // height of product item
  ScrollPhysics physics = NeverScrollableScrollPhysics(); // scroll your product details list
  double _widthLineTopBar = 0;

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () => setState((){
        this._widthLineTopBar = 70.0;
      }),
    );

    setState(() {
      if (this.list_details.length < 3) {
        this.boxProductHeight = this.list_details.length.toDouble() * 85.0; // change size of overflow box
      } else {
        this.physics = ScrollPhysics();
        this.boxProductHeight = 2 * 85.0;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _screen();
  }

  Widget _screen()
  {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
      decoration: BoxDecoration(
        color: cnf.colorMainStreamBlue.toColor(),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(50.0),
          topLeft: Radius.circular(50.0),
        )
      ),
      child: mainModal(),
    );
  }

  Widget mainModal()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: this._widthLineTopBar,
            height: 7.0,
            margin: const EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                color: cnf.colorLightGrayShadow.toColor(),
              borderRadius: const BorderRadius.all(Radius.circular(20.0))
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: MyTitle(
                label: "Your order details",
                color: cnf.wcWhiteText,
                fontSize: 30.0,
              ),
            ),
            this.information_title(title: "Your product details { order ID }"),
            this.overflowBox(myWidget: this.listProductDetails(), height: this.boxProductHeight),
            this.requestCancel(),
          ],
        ),
      ],
    );
  }

  Widget overflowBox({required Widget myWidget, required double height})
  {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: cnf.colorBlack.toColor(),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0))
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(cnf.marginScreen),
            child: myWidget,
          )
        ],
      ),
    );
  }

  Widget listProductDetails()
  {
    return ListView.builder(
      shrinkWrap: true,
      physics: this.physics,
      itemCount: this.list_details.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: this.productItem(
            thumbnails: this.list_details[index]['thumbnails'],
            title: this.list_details[index]['title'],
            totalPrice: this.list_details[index]['totalPrice'],
            totalItem: this.list_details[index]['totalItem']
        ),
      ),
    );
  }

  Widget productItem({required Image thumbnails, required String title, required double totalPrice, required int totalItem})
  {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            margin: const EdgeInsets.only(right: 10.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: thumbnails,
          ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: MyText(
                  text: title,
                  color: cnf.wcWhiteText,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              MyText(
                text: "\$${totalPrice}",
                color: cnf.wcWhiteText,
                fontSize: 15.0,
              )
            ],
          )),
          MyText(
            text: "x${totalItem}",
            color: cnf.wcWhiteText,
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
          ),
        ],
      ),
    );
  }

  Widget requestCancel()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: () {
          print("cancel");
        },
        child: this.overflowBox(
          height: 60.0,
          myWidget: Center(
            child: MyText(
              text: "Request Cancellation",
              align: TextAlign.center,
              color: cnf.wcWhiteText,
              fontWeight: FontWeight.w900,
              fontSize: 15.0,
            ),
          )
        ),
      ),
    );
  }

  Widget information_title({required String title})
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: MyText(
        text: "${title}",
        color: cnf.colorGrayInputBg,
        fontWeight: FontWeight.w900,
      ),
    );
  }

}