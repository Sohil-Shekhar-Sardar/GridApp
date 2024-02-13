
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridViewController extends GetxController{

  RxList<List<String>> characterList = <List<String>>[].obs;
  RxList<String> checkList = <String>[].obs;
  RxBool isInterChange = false.obs;
  RxInt matchAlphabet = 0.obs;
  RxBool isGridViewVisible = false.obs;
  RxBool isSearchBarVisible = false.obs;
  TextEditingController searchCharacterController = TextEditingController();
  TextEditingController mInputController = TextEditingController();
  TextEditingController nInputController = TextEditingController();
  TextEditingController alphabetInputController = TextEditingController();

}