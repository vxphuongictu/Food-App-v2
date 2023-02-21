/// The widget used to list of foods screen


import 'package:flutter/material.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/models/Favourites.dart';
import 'package:food_e/provider/LikedProvider.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/widgets/ButtonContainer.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';


class ProductBox extends StatefulWidget
{

  String ? productID;
  String ? thumbnails;
  String title;
  String price;
  GestureTapCallback ? cartCallback;
  double boxWidth;
  double boxHeight;
  int ? productQuantity;
  GestureTapCallback ? onTap;


  ProductBox({
    this.productID,
    this.productQuantity,
    this.thumbnails,
    this.title="default title",
    this.price="5.00",
    this.cartCallback,
    this.boxWidth=cnf.boxItemMaxSize,
    this.boxHeight=250.0,
    this.onTap=null,
  });

  @override
  State<ProductBox> createState() {
    return _ProductBox();
  }
}


class _ProductBox extends State<ProductBox>
{

  final double spaceBetween = 10.0;
  double _itemScale = 1.0;
  bool isFavourite = false;

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    Provider.of<LikedProvider>(context, listen: false).like(
      item: Favourites(
          idFavourite: this.widget.productID!,
          nameFavourite: this.widget.title,
          priceFavourite: this.widget.price,
          thumbnailFavourite: this.widget.thumbnails!
      ),
    );
    setState(() {
      this.isFavourite = !this.isFavourite;
    });
    return this.isFavourite;
  }

  @override
  void initState() {
    super.initState();
    DatabaseManager().checkFavourite(id: this.widget.productID).then((value){
      setState(() {
        this.isFavourite = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _itemBox();
  }

  Widget _itemBox()
  {
    return GestureDetector(
      onLongPressStart: (details) => setState(() {
        this._itemScale = 1.05;
      }),
      onLongPressEnd: (details) => setState(() {
        this._itemScale = 1.0;
      }),
      child: AnimatedScale(
        scale: this._itemScale,
        duration: const Duration(milliseconds: 500),
        child: Container(
          width: this.widget.boxWidth,
          height: this.widget.boxHeight,
          decoration: BoxDecoration(
              color: cnf.colorWhite.toColor(),
              borderRadius: const BorderRadius.all(
                  Radius.circular(cnf.boxItemMRadius)
              ),
              boxShadow: [
                BoxShadow(
                  color: (cnf.colorLightBlack.toColor()).withOpacity(.2),
                  blurRadius: 10.0,
                )
              ]
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: this.widget.onTap,
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(cnf.boxItemMRadius),
                            topRight: Radius.circular(cnf.boxItemMRadius)
                        ),
                      ),
                      // width: this.widget.boxWidth,
                      height: cnf.boxItemThumbnailSize,
                      child: OverflowBox(
                        child: Image.network(this.widget.thumbnails!, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonContainer(
                          childWidget: LikeButton(
                              size: 20.0,
                              circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  (this.isFavourite == false) ? Icons.favorite_outline : Icons.favorite_outlined,
                                  color: (this.isFavourite == false) ? cnf.colorWhite.toColor() : cnf.colorLightRed.toColor(),
                                  size: 20.0,
                                );
                              },
                              onTap: onLikeButtonTapped
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: this.widget.onTap,
                child: Padding(
                  padding: EdgeInsets.only(top: this.spaceBetween, bottom: this.spaceBetween, right: this.spaceBetween, left: this.spaceBetween),
                  child: MyTitle(
                    align: TextAlign.center,
                    maxLines: 1,
                    label: this.widget.title,
                    textOverflow: true,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: this.spaceBetween, right: this.spaceBetween, bottom: this.spaceBetween),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: this.widget.onTap,
                      child: MyText(
                        align: TextAlign.left,
                        text: "${this.widget.price}",
                        fontFamily: "Bebas Neue",
                        fontSize: 18.0,
                        color: cnf.colorMainStreamBlue,
                      ),
                    ),
                    GestureDetector(
                      onTap: this.widget.cartCallback,
                      child: Container(
                          decoration: BoxDecoration(
                              color: cnf.colorMainStreamBlue.toColor(),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              width: 25.0,
                              height: 25.0,
                              child: Image.asset("assets/images/Basket.png", fit: BoxFit.cover,),
                            ),
                          )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}