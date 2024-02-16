import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/button.dart';
import '../common_widgets/constant_widgets.dart';
import '../controller/grid_view_controller.dart';
import '../routes/routes.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => GridViewScreenState();
}

class GridViewScreenState extends State<GridViewScreen> {
  GridViewController gridController = Get.find();
  GlobalKey<FormState> gridFormKey = GlobalKey<FormState>();

  int row = int.parse(Get.arguments[0]);
  int column = int.parse(Get.arguments[1]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid View'),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Form(
        key: gridFormKey,
        child: Obx(
          () => Column(
            children: [
              Visibility(
                visible: gridController.isSearchBarVisible.value,
                child: Card(
                  color: ColorsForApp.whiteColor,
                  elevation: 5,
                  margin: EdgeInsets.only(right: 15, left: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: CustomTextField(
                    controller: gridController.searchCharacterController,
                    style: TextHelper.size14.copyWith(
                      fontFamily: mediumFont,
                      color: ColorsForApp.blackColor,
                    ),
                    hintText: 'Search here...',
                    suffixIcon: Icon(
                      Icons.search,
                      color: ColorsForApp.blackColor,
                    ),
                    hintTextColor: ColorsForApp.blackColor.withOpacity(0.6),
                    focusedBorderColor: ColorsForApp.grayScale500,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter word";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextField(
                  controller: gridController.alphabetInputController,
                  hintText: 'Enter characters',
                  hintTextColor: Colors.black.withOpacity(0.6),
                  focusedBorderColor: Colors.grey.shade200,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  labelText: "Inputs",
                  maxLength: column * row,
                  labelStyle: TextHelper.size14.copyWith(
                    fontFamily: boldFont,
                    color: ColorsForApp.blackColor,
                  ),
                  onChange: (value) {
                    gridController.isGridViewVisible.value = false;
                    gridController.isSearchBarVisible.value = false;
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter Character";
                    } else if (value.trim().length < (row * column)) {
                      return "Please enter ${row * column} Characters";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonButton(
                      onPressed: () {
                        gridController.characterList.clear();
                        gridController.checkList.clear();
                        if (gridFormKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          for (int i = 0; i < row; i++) {
                            gridController.characterList.add([]);
                            for (int j = 0; j < column; j++) {
                              gridController.characterList[i].add(gridController
                                  .alphabetInputController.text[i *
                                      (row == column ? row : 3) +
                                  j]); // Calculate index to access elements from listText
                              gridController.checkList.add(gridController
                                  .characterList[i][j]
                                  .trim()
                                  .toLowerCase());
                            }
                          }
                          if (gridController.alphabetInputController.text
                                  .trim()
                                  .length ==
                              (row * column)) {
                            gridController.isSearchBarVisible.value = true;
                            gridController.isGridViewVisible.value = true;
                          }
                        }
                        wordFound();
                        },
                      label: 'Submit',
                    ),
                    CommonButton(
                      onPressed: () {
                        gridController.mInputController.clear();
                        gridController.nInputController.clear();
                        gridController.alphabetInputController.clear();
                        gridController.characterList.clear();
                        gridController.checkList.clear();
                        Get.offAllNamed(Routes.HOME_SCREEN);
                      },
                      label: 'Reset',
                    ),
                    CommonButton(
                      onPressed: () {
                        gridController.characterList.clear();
                        gridController.checkList.clear();
                        if (gridFormKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          int temp = 0;
                          setState(() {
                            temp = column;
                            column = row;
                            row = temp;
                            if (gridController.isInterChange.isFalse) {
                              for (int i = 0; i < row; i++) {
                                gridController.characterList.add([]);
                                for (int j = 0; j < column; j++) {
                                  gridController.characterList[i].add(gridController
                                      .alphabetInputController.text[i *
                                          (row == column ? row : 3) +
                                      j]); // Calculate index to access elements from listText
                                  gridController.checkList.add(gridController
                                      .characterList[i][j]
                                      .trim()
                                      .toLowerCase());
                                }
                              }
                              gridController.isInterChange.value = true;
                            } else {
                              for (int i = 0; i < row; i++) {
                                gridController.characterList.add([]);
                                for (int j = 0; j < column; j++) {
                                  gridController.characterList[i].add(gridController
                                      .alphabetInputController.text[j *
                                          (row == column ? row : 3) +
                                      i]); // Calculate index to access elements from listText
                                  gridController.checkList.add(gridController
                                      .characterList[i][j]
                                      .trim()
                                      .toLowerCase());
                                }
                              }
                              gridController.isInterChange.value = false;
                            }
                          });
                          if (gridController.alphabetInputController.text
                                  .trim()
                                  .length ==
                              (row * column)) {
                            gridController.isSearchBarVisible.value = true;
                            gridController.isGridViewVisible.value = true;
                          }
                        }
                      },
                      label: 'Interchange',
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: gridController.isGridViewVisible.value,
                child: Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: column,
                      ),
                      itemBuilder: (context, index) {
                        // print("print -->${int.parse(gridController.nInputController.text)}");
                        // You can customize the content of each grid item here
                        return Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridTile(
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: searchWord(gridController.checkList[index])
                                          ? Colors.orangeAccent
                                          : Colors.purple,
                                ),
                                // Example background color
                                duration: const Duration(seconds: 1),
                                child: Center(
                                  child: Text(
                                    gridController.checkList[index],
                                    style: TextHelper.size14.copyWith(
                                      fontFamily: searchWord(gridController.checkList[index])
                                          ? boldFont
                                          : regularFont,
                                      color: ColorsForApp.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: gridController.checkList.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchWord (String word) {
    List<String> wordList = gridController.searchCharacterController.text.split("");
      if(wordList.contains(word) && wordList.length<=gridController.checkList.length){
        return true;
      }else{
        return false;
      }
  }

  wordFound(){
    bool result = gridController.alphabetInputController.text.contains(gridController.searchCharacterController.text);
    if (result == false) {
      errorSnackBar(message: "Word not found in Grid.");
    } else {
      successSnackBar(message: "Word found in Grid.");
    }
  }

}
