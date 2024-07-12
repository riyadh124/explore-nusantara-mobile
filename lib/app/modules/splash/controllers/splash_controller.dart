import 'package:explore_indonesia/app/modules/home/views/home_view.dart';
import 'package:explore_indonesia/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        var token = GetStorage().read("token");

        if (token == null) {
          Get.off(HomeView());
        } else {
          Get.off(HomeView());
        }
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
