import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/provider/BasketProvider.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyReadMoreText.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/functions/products/quantity.dart';
import 'package:food_e/widgets/ButtonContainer.dart';
import 'package:food_e/requests/getProductDetail.dart';
import 'package:food_e/models/ProductDetails.dart';
import 'package:food_e/widgets/Loading.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:food_e/models/Cart.dart';


class ProductDetail extends StatefulWidget
{

  String id;
  ProductDetail({required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();

}


class _ProductDetailState extends State<ProductDetail>
{
  // screen config
  final spaceFromTitleToBanner = 20.0;
  final spaceFromDescToTitle = 30.0;
  final spaceFromDescToContent = 10.0;
  final spaceFromContentToQuantity = 40.0;
  final spaceFromQuantityToMargin = 20.0;
  final spaceFromQuantityTitleToInput = 5.0;
  final appbarIconSize = 18.0;

  // define _productDetails as Future
  late Future<ProductDetails> _productDetails;

  // define quantity input
  TextEditingController quantityController = TextEditingController();

  // define list of banner
  List<BannerModel> listBanner = [];

  // define title to share
  String ? _titleOfShare = 'Share Me';
  String ? _contentOfShare = 'Vu Xuan Phuong';


  @override
  void initState() {
    this._productDetails = product_detail(id: this.widget.id);
    this._productDetails.then((value) => setState((){
      this._titleOfShare = value.title;
      this._contentOfShare = value.content;
    }));
    setState(() {
      this.quantityController.text = "1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appbar: true,
      appbarBgColor: Colors.transparent,
      screenBgColor: cnf.colorWhite,
      disabledBodyHeight: true,
      scroll: true,
      leading: ButtonContainer(childWidget: Icon(Icons.keyboard_arrow_left, size: this.appbarIconSize, color: cnf.colorWhite.toColor()), onTap: () => Navigator.pop(context)),
      actions: ButtonContainer(
        onTap: () async {
          await Share.share(this._contentOfShare!, subject: this._titleOfShare);
        },
        childWidget: FaIcon(
            FontAwesomeIcons.list,
            size: this.appbarIconSize,
            color: cnf.colorWhite.toColor())
      ),
      body: _details(),
    );
  }

  Widget _details()
  {
    return FutureBuilder(
      future: this._productDetails,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (snapshot.hasData) {
          if (this.listBanner.isEmpty) {
            for (var i = 0; i < data!.galleryImages!.length; i ++) {
              this.listBanner.add(
                  BannerModel(
                      imagePath: data.galleryImages![i]['sourceUrl'],
                      id: (i + 1).toString(),
                      boxFit: BoxFit.cover)
              );
            }
          }
          return Column(
            children: [
              BannerCarousel.fullScreen(
                banners: listBanner,
                customizedIndicators: const IndicatorModel.animation(
                    width: 10,
                    height: 5,
                    spaceBetween: 2,
                    widthAnimation: 20,
                ),
                height: 300.0,
                activeColor: Colors.amberAccent,
                disableColor: Colors.white,
                animation: true,
                indicatorBottom: false,
              ),
              Container(
                margin: EdgeInsets.only(left: cnf.wcLogoMarginLeft, right: cnf.wcLogoMarginLeft, top: this.spaceFromTitleToBanner),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: MyTitle(
                                maxLines: 1,
                                textOverflow: true,
                                align: TextAlign.left,
                                color: cnf.colorLightBlack,
                                label: "${data?.title}",
                                fontSize: 36,
                              ),
                            ),
                            MyText(
                              color: cnf.colorOrange,
                              fontSize: 14,
                              text: "The Nautilus",
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: cnf.colorOrange.toColor(),
                            ),
                            MyText(
                              color: cnf.colorOrange,
                              fontSize: 14,
                              text: "34 mins",
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: this.spaceFromDescToTitle,
                          bottom: this.spaceFromDescToContent),
                      child: MyTitle(
                        fontSize: 18,
                        label: 'DESCRIPTION',
                        color: cnf.colorLightGrayShadow,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: this.spaceFromContentToQuantity),
                      child: MyReadMoreText(
                          showMore: "Read more",
                          showLess: "Read less",
                          textColor: cnf.colorLightBlack,
                          trimLines: 10,
                          fontSize: 14,
                          text: '${data?.content}'
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: this.spaceFromQuantityToMargin,
                                  bottom: this.spaceFromQuantityTitleToInput),
                              child: MyTitle(
                                fontSize: 18,
                                label: 'QUANTITY',
                                color: cnf.colorMainStreamBlue,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                right: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    cnf.input_radius),
                                color: cnf.colorGrayInputBg.toColor(),
                              ),
                              child: Row(
                                children: [
                                  MyInput(
                                    textController: this.quantityController,
                                    width: 100.0,
                                    isNumber: true,
                                    boder: false,
                                    textColor: cnf.colorGray,
                                  ),
                                  SizedBox(
                                    width: 25.0,
                                    child: IconButton(
                                      iconSize: 15.0,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          this.quantityController.text = remove(currentNumber: int.parse(this.quantityController.text)).toString();
                                        });
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.minus,
                                        color: cnf.colorMainStreamBlue
                                            .toColor(),
                                      )
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.0 ,
                                    child: IconButton(
                                      iconSize: 15.0,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          this.quantityController.text =
                                              add(currentNumber: int.parse(
                                                  this.quantityController
                                                      .text)).toString();
                                        });
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: cnf.colorMainStreamBlue
                                            .toColor(),
                                      )
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MyTitle(
                              fontSize: 18,
                              label: 'SUB TOTAL',
                              color: cnf.colorLightBlack,
                            ),
                            MyTitle(
                              fontSize: 24,
                              label: '${data?.price}',
                              color: cnf.colorMainStreamBlue,
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: cnf.large_button_h,
                      margin: const EdgeInsets.only(top: cnf.wcLogoMarginTop, bottom: cnf.wcLogoMarginTop),
                      alignment: Alignment.bottomCenter,
                      child: LargeButton(
                        onTap: () async {
                          EasyLoading.show(status: "Wating ...");
                          Provider.of<BasketProvider>(context, listen: false).addCart(
                            Cart(
                              productID: this.widget.id,
                              productName: "${data?.title}",
                              productQuantity: int.parse(this.quantityController.text),
                              productPrice: "${data?.price}",
                              productThumbnails: "${data?.galleryImages![0]['sourceUrl']}",
                            ),
                          );
                          EasyLoading.showSuccess("Added to cart");
                        },
                        label: "ADD TO BASKET",
                      )
                    )
                  ],
                ),
              )
            ],
          );
        } else {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Loading(),
            ),
          );
        }
      },
    );
  }
}
