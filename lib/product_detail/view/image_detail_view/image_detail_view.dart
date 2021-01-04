import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/product_detail/bloc/image_detail_bloc/image_detail_bloc.dart';
import 'package:fluttercommerce/widgets/dotted_slider.dart';

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  // bool isClicked = false;
  double widget1Opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      widget1Opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageDetailBloc, ImageDetailState>(
        // ignore: missing_return
        builder: (context, state) {
      switch (state.status) {
        case ImageDetailStatus.failure:
          return const Center(child: CircularProgressIndicator());
        case ImageDetailStatus.initial:
          List<Images> listImage;
          print("${state.listImages.toString()}     _ImagePageState");
          state.listImages.map((e) {
            listImage.add(e);
          });
          print("${listImage.toString()}     _productSlideImage");

          return DottedSlider(maxHeight: 200, children: 
            listImage.map((e) => Container(
                  height: 200,
                  width: double.infinity,        
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/Spinner.gif",
                    image:
                        "http://192.168.100.18/AppStore/public/layout/images/avatar/${e.image}",
                    fit: BoxFit.contain,
                  ),
                )).toList()
          
              //     <Widget>[
              //   _productSlideImage("widget.product.icon"),
              //   _productSlideImage("widget.product.icon"),
              //   _productSlideImage("widget.product.icon"),
              //   _productSlideImage("widget.product.icon"),
              //   _productSlideImage("widget.product.icon"),
              //   _productSlideImage("widget.product.icon"),
              // ],
              );
      }
    });
  }

  // _productSlideImage(String imageUrl) {
  //   return Container(
  //     height: 200,
  //     width: double.infinity,
  //     child: FadeInImage.assetNetwork(
  //       placeholder: "assets/Spinner.gif",
  //       image:
  //           "http://192.168.100.18/AppStore/public/layout/images/avatar/$imageUrl",
  //       fit: BoxFit.contain,
  //     ),
  //   );
  // }

  // dottedSlider(List<Images> listImage) {
  //   print("dottedSlider: ${listImage.toString()}");
  //   return DottedSlider(
  //     maxHeight: 200,
  //     children:
  //         // listImage.map((e) => _productSlideImage(e.toString()))
  //         <Widget>[
  //       _productSlideImage("widget.product.icon"),
  //       _productSlideImage("widget.product.icon"),
  //       _productSlideImage("widget.product.icon"),
  //       _productSlideImage("widget.product.icon"),
  //       _productSlideImage("widget.product.icon"),
  //       _productSlideImage("widget.product.icon"),
  //     ],
  //   );
  // }
}
