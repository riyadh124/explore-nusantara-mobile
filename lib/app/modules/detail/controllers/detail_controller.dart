import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailController extends GetxController {
  //TODO: Implement DetailController

  var dataArguments;

  String formatTime(String time) {
    final inputFormat = DateFormat('HH:mm:ss');
    final outputFormat = DateFormat('HH:mm');
    final dateTime = inputFormat.parse(time);
    return outputFormat.format(dateTime);
  }

  var distanceToPlace = ''.obs; // Variable to hold the distance

  Future<void> checkLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
    }

    if (await Permission.location.isGranted) {
      calculateDistance();
    } else {
      // Handle the case where the user does not grant permission
      Get.snackbar("Permission Required",
          "Location permission is required to calculate the distance.");
    }
  }

  Future<void> calculateDistance() async {
    distanceToPlace.value = 'Memuat..';

    double targetLat = double.parse(dataArguments['lat']) ?? 0.0;
    double targetLng = double.parse(dataArguments['lng']) ?? 0.0;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      targetLat,
      targetLng,
    );

    // Convert meters to kilometers
    double distanceInKm = distanceInMeters / 1000;

    // Update the distance variable
    distanceToPlace.value = '${distanceInKm.toStringAsFixed(2)} KM';
    print(distanceToPlace.value);
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void onInit() {
    super.onInit();
    dataArguments = Get.arguments;
    checkLocationPermission();
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
