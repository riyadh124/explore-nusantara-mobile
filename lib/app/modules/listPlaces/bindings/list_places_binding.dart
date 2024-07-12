import 'package:get/get.dart';

import '../controllers/list_places_controller.dart';

class ListPlacesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPlacesController>(
      () => ListPlacesController(),
    );
  }
}
