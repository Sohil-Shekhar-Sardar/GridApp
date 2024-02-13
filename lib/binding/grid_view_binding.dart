import 'package:get/get.dart';

import '../controller/grid_view_controller.dart';


class GridViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GridViewController>(() => GridViewController());

  }
}
