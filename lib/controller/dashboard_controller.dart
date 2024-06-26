import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/service/database_service.dart';
import 'package:myhb_app/widgets/buttom_bar.dart';

class DashboardController extends GetxController {
  late DatabaseService _databaseService;
  var choosenType = Type.All.obs;
  RxBool loadingFavorite = false.obs;
  RxBool search = false.obs;
  RxBool notifier = false.obs;
  var pageType = PageType.home.obs;

  RxList<Item> globalItems = <Item>[].obs;
  RxList<Item> filteredItems = <Item>[].obs;
  RxList<Item> favoriteItems = <Item>[].obs;
  final StreamController<List<Item>> _filteredItemsController =
  StreamController<List<Item>>.broadcast();
  Stream<List<Item>> get filteredItemsStream =>
      _filteredItemsController.stream;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _databaseService = DatabaseService();
    fetchItems();
    choosenType.listen((_) {
      updateFilteredItems();
      fetchFavoriteItems();
    });
  }

  void fetchItems() {
    _databaseService.getItems().listen((items) {
      globalItems.assignAll(items);
      updateFilteredItems();
    });
  }
  void updateFilteredItems() {
    filteredItems.assignAll(globalItems.where((item) {
      if (choosenType.value == Type.All) {
        return true;
      } else {
        return item.type == choosenType.value;
      }
    }).toList());
    String query = searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      for (var item in filteredItems) {
        print(item.name);
      }
      filteredItems.assignAll(globalItems.where((item) =>
          item.name!.toLowerCase().contains(query))

      );
      print(filteredItems.length);
      for (var item in filteredItems) {
        print(item.name);
      }

    }
    _filteredItemsController.add(filteredItems);
  }

  // void updateFilteredItems() {
  //   filteredItems.assignAll(globalItems.where((item) {
  //     if (choosenType.value == Type.All) {
  //       return true;
  //     } else {
  //       return item.type ==
  //           choosenType.value;
  //     }
  //   }).toList());
  //   _filteredItemsController.add(filteredItems);
  // }
  void fetchFavoriteItems() {

    favoriteItems.assignAll(globalItems.where((item) {
      return item.isfavorite == true;
    }).toList());
    loadingFavorite.value=false;
  }


}




