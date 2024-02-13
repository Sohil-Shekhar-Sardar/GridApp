import 'package:get/get.dart';
import '../binding/grid_view_binding.dart';
import '../screens/grid_view_screen.dart';
import '../screens/home_screen.dart';
import 'routes.dart';

const Transition transition = Transition.fadeIn;

class AppPages {
  static const INITIAL_ROUTE = Routes.HOME_SCREEN;

  static final routes = [

    GetPage(
      name: Routes.HOME_SCREEN,
      page: () =>  HomeScreen(),
      transition: transition,
      binding: GridViewBinding()
    ),

    GetPage(
        name: Routes.GRID_VIEW_SCREEN,
        page: () =>  GridViewScreen(),
        transition: transition,
        binding: GridViewBinding()
    ),
  ];
}
