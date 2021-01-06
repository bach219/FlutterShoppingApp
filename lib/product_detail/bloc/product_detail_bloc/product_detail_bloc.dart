import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(const ProductDetailState());

  @override
  Stream<Transition<ProductDetailEvent, ProductDetailState>> transformEvents(
    Stream<ProductDetailEvent> events,
    TransitionFunction<ProductDetailEvent, ProductDetailState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is DataFetched) {
      // print(event.id.toString() + "mapEventToState");
      yield await _mapProductDetailFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<ProductDetailState> _mapProductDetailFetchedToState(
      ProductDetailState state) async {
    try {
      if (state.status == ProductDetailStatus.initial) {
        await Hive.openBox('Box');
        var box = Hive.box('Box');
        String id = box.get('idDetail');
        String company = box.get('companyDetail');

        final listImage = await _fetchListImage(id);
        final listComment = await _fetchListComment(id);
        final listMore = await _fetchListMore(company);
        final product = await _fetchDetailProduct(id);
        return state.copyWith(
          status: ProductDetailStatus.success,
          listImages: listImage,
          listComment: listComment,
          listMore: listMore,
          product: product,
        );
      }
      // state.copyWith(status: ProductDetailStatus.failure);
    } on Exception {
      return state.copyWith(status: ProductDetailStatus.failure);
    }
  }

  Future<List<Images>> _fetchListImage(String id) async {
    print("_fetchListImage");
    var data = await UserRepository().getToken();
    // print(id.toString() + "sfasfsafsdafsafsaf");
    Map<String, String> map = {"id": id};
    map.addAll(data);
    final response = await CallApi().postData(map, "getImage");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      // print("body: $body");
      Images img;
      return body.map((dynamic json) {
        img = Images(
          id: json['product_id'].toString(),
          image: json['image'] as String,
        );
        // print(img);
        return img;
      }).toList();
    }
    throw Exception('error _fetchListImage');
  }

  Future<List<Comment>> _fetchListComment(String id) async {
    print("_fetchListComment");
    var data = await UserRepository().getToken();
    Map<String, String> map = {"id": id};
    map.addAll(data);
    final response = await CallApi().postData(map, "getComment");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Comment(
          id: json['com_id'].toString(),
          name: json['com_name'].toString(),
          email: json['com_email'].toString(),
          content: json['com_content'].toString(),
          image: json['com_image'].toString(),
          productId: json['com_product'].toString(),
          createdAt: json['created_at'].toString(),
        );
      }).toList();
    }
    throw Exception('error _fetchListComment');
  }

  Future<List<Product>> _fetchListMore(String company) async {
    print("_fetchListMore");
    var data = await UserRepository().getToken();
    Map<String, String> map = {"company": company};
    map.addAll(data);
    final response = await CallApi().postData(map, "getMore");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Product(
          id: json['prod_id'].toString(),
          company: json['cate_name'] as String,
          name: json['prod_name'] as String,
          icon: json['prod_img'] as String,
          rating: 5.0,
          price: double.parse(json['prod_price'].toString()),
          remainingQuantity: json['prod_qty'] as int,
          description: json['prod_name'] as String,
          sale: double.parse(json['prod_sale'].toString()),
        );
      }).toList();
    }
    throw Exception('error _fetchListMore');
  }

  Future<Product> _fetchDetailProduct(String id) async {
    print("_fetchDetailProduct");
    // print(
    //     "id: $id             sdffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    var data = await UserRepository().getToken();
    Map<String, String> map = {"id": id};
    map.addAll(data);

    final response = await CallApi().postData(map, "getDetailProduct");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      // print("body_fetchDetailProduct: $body");
      Product product = Product.empty;
      product = Product(
          id: body[0]['prod_id'].toString(),
          company: body[0]['cate_name'] as String,
          name: body[0]['prod_name'] as String,
          icon: body[0]['prod_img'] as String,
          rating: 5.0,
          price: double.parse(body[0]['prod_price'].toString()),
          remainingQuantity: body[0]['prod_qty'] as int,
          description: body[0]['prod_description'] as String,
          sale: double.parse(body[0]['prod_sale'].toString()),
          ram: body[0]['prod_ram'].toString(),
          hardDrive: body[0]['prod_hardDrive'].toString(),
          accessories: body[0]['prod_accessories'].toString(),
          warranty: body[0]['prod_warranty'].toString(),
          promotion: body[0]['prod_promotion'].toString(),
          );
      return product;
    }
    throw Exception('error fetching _fetchDetailProduct');
  }
  // Future<List<Product>> _fetchListImage() async {
  //   print("productList");
  //   var data = await UserRepository().getToken();
  //   final response = await CallApi().postData(data, "productList");
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body) as List;
  //     return body.map((dynamic json) {
  //       return Product(
  //         id: json['prod_id'].toString(),
  //         company: json['cate_name'] as String,
  //         name: json['prod_name'] as String,
  //         icon: json['prod_img'] as String,
  //         rating: 5.0,
  //         price: double.parse(json['prod_price'].toString()),
  //         remainingQuantity: json['prod_qty'] as int,
  //         description: json['prod_name'] as String,
  //         sale: double.parse(json['prod_sale'].toString()),
  //       );
  //     }).toList();
  //   }
  //   throw Exception('error fetching List Product');
  // }
}
