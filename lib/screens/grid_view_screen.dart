import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
        ),
        body:   Form(
          key: gridFormKey,
          child: Obx(()=> Column(
                children: [
                  Visibility(
                    visible: gridController.isSearchBarVisible.value,
                    child: Card(
                      color: ColorsForApp.whiteColor,
                      elevation: 5,
                      margin: EdgeInsets.only(top: 2.h, right: 15, left: 15),
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
                        textInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')),
                        ],
                        hintTextColor: ColorsForApp.blackColor.withOpacity(0.6),
                        focusedBorderColor: ColorsForApp.grayScale500,
                        keyboardType: TextInputType.text,
                        maxLength: 1,
                        textInputAction: TextInputAction.search,
                        onChange: (value) {
                          // searchFromList(value);
                          if(gridController.characterList.contains(value.toLowerCase())){
                            gridController.matchAlphabet.value = 1;
                            FocusScope.of(context).unfocus();
                          }else{
                            gridController.matchAlphabet.value = 0;
                          }
                        },
                        validator: (value){
                          if(value!.trim().isEmpty){
                            return "Please enter alphabets";
                          }else if(!GetUtils.isAlphabetOnly(value)){
                            return "PLease enter Only Characters";
                          } else {
                            return null;
                          }
                        },

                      ),
                    ),
                  ),
                  height(3.h),
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
                      maxLength: column*row,
                      labelStyle: TextHelper.size14.copyWith(
                        fontFamily: boldFont,
                        color: ColorsForApp.blackColor,),
                      onChange: (value){
                        gridController.isGridViewVisible.value=false;
                        gridController.isSearchBarVisible.value=false;
                      },
                      validator: (value){
                        if(value!.trim().isEmpty){
                          return "Please enter Character";
                        } else if(value.trim().length < (row*column)){
                          return "Please enter ${row*column} Characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  height(4.h),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CommonButton(
                          width: 30.w,
                          onPressed: () {
                            gridController.characterList.clear();
                            if(gridFormKey.currentState!.validate()){
                              FocusScope.of(context).unfocus();
                             for(int i = 0;i < gridController.alphabetInputController.text.trim().length;i++){
                               gridController.characterList.add(gridController.alphabetInputController.text[i].toLowerCase());
                             }
                             print(gridController.characterList);
                             if( gridController.alphabetInputController.text.trim().length==(row*column)){
                               gridController.isSearchBarVisible.value=true;
                               gridController.isGridViewVisible.value=true;
                             }
                            }
                          },
                          label: 'Submit',
                        ),
                        CommonButton(
                          width: 30.w,
                          onPressed: () {
                              gridController.mInputController.clear();
                              gridController.nInputController.clear();
                              gridController.alphabetInputController.clear();
                              gridController.characterList.clear();
                              Get.offAllNamed(Routes.HOME_SCREEN);
                          },
                          label: 'Reset',
                        ),
                        CommonButton(
                          width: 30.w,
                          onPressed: () {
                            gridController.characterList.clear();
                            setState(() {
                              int temp = 0;
                              temp = column;
                              column = row;
                              row = temp;
                            });
                            if(gridFormKey.currentState!.validate()){
                              FocusScope.of(context).unfocus();
                              for(int i = 0;i < gridController.alphabetInputController.text.trim().length;i++){
                                gridController.characterList.add(gridController.alphabetInputController.text[i]);
                              }
                              if( gridController.alphabetInputController.text.trim().length==(row*column)){
                                gridController.isSearchBarVisible.value=true;
                                gridController.isGridViewVisible.value=true;
                              }
                            }

                          },
                          label: 'Interchange',
                        ),

                      ],
                    ),
                  ),

                  height(4.h),
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
                              return Obx(()=>
                                 Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridTile(
                                    child: AnimatedContainer(
                                      decoration: BoxDecoration(
                                        color: gridController.matchAlphabet.value == 1 && gridController.characterList[index].toLowerCase() == gridController.searchCharacterController.text.toLowerCase() ? Colors.orangeAccent : Colors.blue,
                                      ),
                                    // Example background color
                                      duration: const Duration(seconds: 1),
                                      child: Center(
                                        child: Text(
                                          gridController.characterList[index],
                                          style: TextHelper.size14.copyWith(
                                            fontFamily: gridController.matchAlphabet.value == 1 && gridController.characterList[index].toLowerCase() == gridController.searchCharacterController.text.toLowerCase() ? boldFont:regularFont,
                                            color: ColorsForApp.whiteColor,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: gridController.characterList.length
                          ),
                      ),
                  ),

                ],
              ),
          ),
        ),

    );
  }
}
