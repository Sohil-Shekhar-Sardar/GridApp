import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/button.dart';
import '../common_widgets/constant_widgets.dart';
import '../controller/grid_view_controller.dart';
import '../routes/routes.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';


class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

    final GlobalKey<FormState> inputFormKey = GlobalKey<FormState>();
 final GridViewController gridController = GridViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: inputFormKey,
          child: Column(
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: gridController.mInputController,
                      hintText: 'Enter number of rows',
                      hintTextColor: Colors.black.withOpacity(0.6),
                      focusedBorderColor: Colors.grey.shade200,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      labelText: "Row",
                      labelStyle: TextHelper.size14.copyWith(
                          fontFamily: boldFont,
                          color: ColorsForApp.blackColor,),
                      validator: (value){
                        if(value!.trim().isEmpty){
                          return "Please enter number of rows";
                        }else if(!GetUtils.isNum(value)){
                          return "PLease enter number";
                        } else if(value == "0"){
                          return "Please enter number greater than zero";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height:15),
                    CustomTextField(
                      controller: gridController.nInputController,
                      hintText: 'Enter number of columns',
                      hintTextColor: Colors.black.withOpacity(0.6),
                      focusedBorderColor: Colors.grey.shade200,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      labelText: "Column",
                      labelStyle: TextHelper.size14.copyWith(
                          fontFamily: boldFont,
                          color: ColorsForApp.blackColor,),
                      validator: (value){
                        if(value!.trim().isEmpty){
                          return "Please enter number of columns";
                        }else if(!GetUtils.isNum(value)){
                          return "PLease enter number";
                        } else if(value == "0"){
                          return "Please enter number greater than zero";
                        } else {
                          return null;
                        }
                      },
                    ),

                  ],
                ),
              ),
            SizedBox(height: 15,),
              CommonButton(
                width: 50,
                onPressed: () {
                  if(inputFormKey.currentState!.validate()){
                    Get.toNamed(Routes.GRID_VIEW_SCREEN,
                    arguments: [
                      gridController.mInputController.text,
                      gridController.nInputController.text,
                    ]
                    );
                  }
                },
                label: 'Start',
              ),
              SizedBox(height:100),
            ],
          ),
        ),
      )
    );
  }
}
