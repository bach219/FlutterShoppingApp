import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:fluttercommerce/product_list/bloc/list_product_bloc/list_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/product_list/models/filter.dart';

class FilterView extends StatefulWidget {
  @override
  _FiltreState createState() => _FiltreState();
}

class _FiltreState extends State<FilterView> {
  double _lowerValue = 1000000;
  double _upperValue = 30000000;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListProductBloc, ListProductState>(
        // ignore: missing_return
        builder: (context, state) {
      if (state is ListProductLoading)
        return Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 11,
            child: Center(child: Image.asset("assets/Spinner.gif")));
      if (state is ListProductLoaded) {
        return Container(
          height: 500,
          padding: EdgeInsets.all(12.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Lọc"),
                  Text("Danh mục"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  color: Colors.black26,
                  height: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Hãng sản xuất"),
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listCategory.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          child: buildChip(state.listCategory[index].name,
                              Colors.grey.shade400, "A", Colors.grey.shade600),
                          onTap: () {
                            // context.read<ListProductBloc>().add(ListProductChosen(Filter(li)));
                            
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Loại sản phẩm"),
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listFunctionality.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          child: buildChip(state.listFunctionality[index].name,
                              Colors.grey.shade400, "A", Colors.grey.shade600),
                          onTap: () {

                          },
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Sắp xếp"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Mới nhất",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Divider(
                  color: Colors.black26,
                  height: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Giá cao đến thấp"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Divider(
                  color: Colors.black26,
                  height: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Giá thấp đến cao"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Divider(
                  color: Colors.black26,
                  height: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 8.0, left: 8.0, right: 8.0),
                child: Text("Giá sản phẩm"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("\$ " + '$_lowerValue'),
                    Text("\$ " + '$_upperValue'),
                  ],
                ),
              ),
              FlutterSlider(
                tooltip: FlutterSliderTooltip(
                  leftPrefix: Icon(
                    Icons.attach_money,
                    size: 19,
                    color: Colors.black45,
                  ),
                  rightSuffix: Icon(
                    Icons.attach_money,
                    size: 19,
                    color: Colors.black45,
                  ),
                ),
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                    border: Border.all(width: 3, color: Colors.blue),
                  ),
                  activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.red.withOpacity(0.5)),
                ),
                values: [1000000, 30000000],
                rangeSlider: true,
                max: state.price[0],
                min: state.price[1],
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  _lowerValue = lowerValue;
                  _upperValue = upperValue;
                  setState(() {});
                },
              )
            ],
          ),
        );
      }
    });
  }

  Padding buildChip(
      String label, Color color, String avatarTitle, Color textColor) {
    bool onSelected = false;
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 2.0, left: 2.0),
      child: FilterChip(
        padding: EdgeInsets.all(4.0),
        label: Text(
          label,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(color: color),
        ),
        onSelected: (bool value) {
          setState(() {
            onSelected = !onSelected;
            if (onSelected) {
              color = Theme.of(context).primaryColor;
              print("selected");
            }
            if (!onSelected) {
              color = Theme.of(context).primaryColor;
              print("unselected");
            }
          });
          print("selected");
        },
      ),
    );
  }
}
