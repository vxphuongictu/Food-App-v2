import 'package:flutter/material.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/cart/OrderDetails.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/widgets/OrderItem.dart';
import 'package:provider/provider.dart';


class OrderHistory extends StatefulWidget
{
  @override
  State<OrderHistory> createState() {
    return _OrderHistory();
  }
}


class _OrderHistory extends State<OrderHistory>
{
  final List<dynamic> list_order = [
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover,), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00, 'orderDate': 'May 23, 2023'},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00, 'orderDate': 'May 23, 2023'},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00, 'orderDate': 'May 23, 2023'},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00, 'orderDate': 'May 23, 2023'},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00, 'orderDate': 'May 23, 2023'},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00, 'orderDate': 'May 23, 2023'},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00, 'orderDate': 'May 23, 2023'},
    {'thumbnails': Image.asset('assets/images/prd2.png', fit: BoxFit.cover), 'title': 'Grilled Salmon', 'totalItem': 5, 'totalPrice': 20.00, 'orderDate': 'May 23, 2023'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return BaseScreen(
          appbar: true,
          appbarBgColor: (value.darkmode == true) ? cnf.darkModeColorbg.toColor() : Colors.white,
          screenBgColor: cnf.colorWhite,
          extendBodyBehindAppBar: false,
          disabledBodyHeight: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
              size: cnf.leadingIconSize,
            ),
          ),
          margin: true,
          body: _screen(),
        );
      },
    );
  }

  Widget _screen()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
                child: MyTitle(
                  label: "ORDER HISTORY",
                  color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                ),
              ),
              this.list_order_item()
            ],
          ),
        );
      },
    );
  }

  Widget list_order_item()
  {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: this.list_order.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: cnf.marginScreen),
        child: OrderItem(
            onTap: () => {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                barrierColor: Colors.transparent,
                enableDrag: true,
                isDismissible: true,
                isScrollControlled: true,
                context: context,
                builder: (context){
                  return StatefulBuilder(builder: (context, newState){
                    return OrderDetails();
                  });
                },
              ),
            },
            thumbnails: this.list_order[index]['thumbnails'],
            title: this.list_order[index]['title'],
            totalItem: this.list_order[index]['totalItem'],
            totalPrice: this.list_order[index]['totalPrice'],
            orderDate: this.list_order[index]['orderDate']
        ),
      ),
    );
  }

}