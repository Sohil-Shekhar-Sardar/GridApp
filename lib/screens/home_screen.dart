import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../common_widgets/button.dart';
import '../common_widgets/constant_widgets.dart';
import '../controller/grid_view_controller.dart';
import '../generated/assets.dart';
import '../routes/routes.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';


class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final GridViewController gridViewController = GridViewController();


 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gridViewController.mInputController.clear();
    gridViewController.nInputController.clear();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: gridViewController.inputFormKey,
          child: Column(
            children: [
              height(5.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: gridViewController.mInputController,
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
                    height(3.h),
                    CustomTextField(
                      controller: gridViewController.nInputController,
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
              height(4.h),

              LottieBuilder.asset(Assets.animationsGridAnimation,width: 80.w,),

              CommonButton(
                width: 50.w,
                onPressed: () {
                  if(gridViewController.inputFormKey.currentState!.validate()){
                    Get.toNamed(Routes.GRID_VIEW_SCREEN,
                    arguments: [
                      gridViewController.mInputController.text,
                      gridViewController.nInputController.text,
                    ]
                    );
                  }
                },
                label: 'Start',
              ),
              height(4.h),
            ],
          ),
        ),
      )
    );
  }
}
