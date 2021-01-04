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

part 'image_detail_event.dart';
part 'image_detail_state.dart';

class ImageDetailBloc extends Bloc<ImageDetailEvent, ImageDetailState> {
  ImageDetailBloc() : super(const ImageDetailState());

  @override
  Stream<Transition<ImageDetailEvent, ImageDetailState>> transformEvents(
    Stream<ImageDetailEvent> events,
    TransitionFunction<ImageDetailEvent, ImageDetailState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ImageDetailState> mapEventToState(ImageDetailEvent event) async* {
    if (event is DataFetched) {
      // print(event.id.toString() + "mapEventToState");
      yield await _mapImageDetailFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<ImageDetailState> _mapImageDetailFetchedToState(
      ImageDetailState state) async {
    try {
      if (state.status == ImageDetailStatus.initial) {
        await Hive.openBox('Box');
        var box = Hive.box('Box');
        String id = box.get('idDetail');
        final listImages = await _fetchListImage(id);
        return state.copyWith(
          status: ImageDetailStatus.initial,
          listImages: listImages,
        );
      }
      // state.copyWith(status: ImageDetailStatus.failure);
    } on Exception {
      return state.copyWith(status: ImageDetailStatus.failure);
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

}
