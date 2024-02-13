
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridViewController extends GetxController{

  GlobalKey<FormState> inputFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> gridFormKey = GlobalKey<FormState>();

  Color bgColor = Colors.blue;

  RxList<String> characterList = <String>[].obs;
  RxInt row =0.obs;
  RxInt matchAlphabet =0.obs;
  RxBool isGridViewVisible =false.obs;
  RxBool isSearchBarVisible =false.obs;
  RxInt column =0.obs;
  TextEditingController searchCharacterController = TextEditingController();
  TextEditingController mInputController = TextEditingController();
  TextEditingController nInputController = TextEditingController();
  TextEditingController alphabetInputController = TextEditingController();


  RxList<RxList<String>> get transposedCharacterList {
    List<RxList<String>> transposed = List.generate(
      characterList.length,
          (index) => <String>[characterList[index]].obs,
    );
    return transposed.obs;
  }

}