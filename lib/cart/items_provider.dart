import 'package:flutter/material.dart';
import 'package:tagify/models/item_model.dart';
import '../../firebase_functions.dart';

class ItemsProvider with ChangeNotifier{
  List<ItemModel> items = [];
  DateTime selectedDate = DateTime.now();
  ItemModel? selectedTask;

  Future<void> getItems(String userId) async {
    List<ItemModel> allItems = await FirebaseFunctions.getAllItemsFromFirestore(userId);
    items = allItems.where((item) =>
    item.date.year == selectedDate.year &&
        item.date.month == selectedDate.month &&
        item.date.day == selectedDate.day,
    ).toList();
    notifyListeners();
  }

  void getSelectedDateTasks(DateTime date, String userId){
    selectedDate = date;
    getItems(userId);
  }

  void resetData(){
    items = [];
    selectedDate = DateTime.now();
  }

  void setSelectedTask(ItemModel task){
    selectedTask = task;
    notifyListeners();
  }
}
