import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:fluttercommerce/cart/models/models.dart';

class ItemRepository {
  Future<List<Item>> getListItem() async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    // print("jsonDecode                    " +
    //     jsonDecode(box.get('listItem')).toString());
    List<dynamic> decode = jsonDecode(box.get('listItem')) as List;
    return decode.map((e) {
      return Item(
        id: e['id'],
        company: e['company'],
        name: e['name'],
        icon: e['icon'],
        rating: 4.5,
        remainingQuantity: e['remainingQuantity'],
        price: e['price'],
        sale: e['sale'],
        qty: e['qty'],
      );
    }).toList();
  }

  getListLength() async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    List<Item> listItem = await getListItem();
    var lengthCart = listItem.fold(
      0,
      (total, current) =>
          total + current.qty);
    box.put('lengthCart', lengthCart.toString());
  }

  addItemToList(Item item) async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    List<Item> listItem = await getListItem();
    int index = listItem.indexWhere((element) => element.id == item.id);
    if (index >= 0) {
      int qty = listItem[index].qty;
      if (qty < 5 && qty < item.remainingQuantity) {
        listItem[index] = Item(
            id: item.id,
            company: item.company,
            name: item.name,
            icon: item.icon,
            rating: 4.5,
            remainingQuantity: item.remainingQuantity,
            price: item.price,
            sale: item.sale,
            qty: qty + 1);
      }
    } else
      listItem.add(item);
    box.put('listItem', jsonEncode(listItem).toString());
    // getListLength();
  }

  removeItemFromList(Item item) async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    List<Item> listItem = await getListItem();
    int index = listItem.indexWhere((element) => element.id == item.id);
    listItem.removeAt(index);
    box.put('listItem', jsonEncode(listItem).toString());
    // getListLength();
  }

  updateAddItemToList(Item item) async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    List<Item> listItem = await getListItem();
    int index = listItem.indexWhere((element) => element.id == item.id);
    int qty = listItem[index].qty;
    if (qty < 5 && qty < item.remainingQuantity) {
      listItem[index] = Item(
          id: item.id,
          company: item.company,
          name: item.name,
          icon: item.icon,
          rating: 4.5,
          remainingQuantity: item.remainingQuantity,
          price: item.price,
          sale: item.sale,
          qty: qty + 1);
    }

    box.put('listItem', jsonEncode(listItem).toString());
    // getListLength();
  }

  updateSubItemToList(Item item) async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    List<Item> listItem = await getListItem();
    int index = listItem.indexWhere((element) => element.id == item.id);
    int qty = listItem[index].qty;
    if (qty == 1)
      listItem.removeAt(index);
    else
      listItem[index] = Item(
          id: item.id,
          company: item.company,
          name: item.name,
          icon: item.icon,
          rating: 4.5,
          remainingQuantity: item.remainingQuantity,
          price: item.price,
          sale: item.sale,
          qty: qty - 1);

    box.put('listItem', jsonEncode(listItem).toString());
    // getListLength();
  }
}
