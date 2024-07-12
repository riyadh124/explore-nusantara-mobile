import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  FocusNode focusNode = FocusNode();
  RxBool isFocused = false.obs;

  List<String> cities = [
    'Balikpapan',
    'Jakarta',
    'Surabaya',
    'Bandung',
    'Yogyakarta',
    'Bali'
  ];
  RxString activeCity = "Balikpapan".obs;

  final ScrollController scrollController = ScrollController();
  RxInt centerIndex = 0.obs;

  void onScroll() {
    double position = scrollController.position.pixels +
        MediaQuery.of(Get.context!).size.width / 2;
    centerIndex.value = (position / 286).floor(); // 270 + 2*8 padding = 286
    print(position);
  }

  final List places = [
    {
      "nama": "Mangrove Center",
      "jam_buka": "07:00:00",
      "jam_tutup": "22:00:00",
      "alamat":
          "Graha Indah, PGRI, Gg. Mangrove VI Graha Indah No.RT. 14, Balikpapan Utara, Kota Balikpapan, Kalimantan Timur 76129",
      "lat": "-1.214626",
      "lng": "116.879517",
      "kota": "Balikpapan",
      "kategori": "Alam",
      "deskripsi":
          "Mangrove Center Balikpapan, sebuah pengalaman yang unik bisa menyusuri sungai yang ada di teluk Balikpapan ini, tempat yang indah dan sejuk di tengah panasnya Kota Balikpapan, semoga mangrove di tempat ini terus lestari!",
      "foto":
          "https://images.unsplash.com/photo-1520333764090-778d6dc95ec3?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "nama": "Pantai Kemala",
      "jam_buka": "06:00:00",
      "jam_tutup": "18:00:00",
      "alamat":
          "Jl. Jenderal Sudirman No.43, Prapatan, Kec. Balikpapan Kota, Kota Balikpapan, Kalimantan Timur 76112",
      "lat": "-1.279453",
      "lng": "116.829731",
      "kota": "Balikpapan",
      "kategori": "Pantai",
      "deskripsi":
          "Pantai Kemala adalah salah satu destinasi pantai populer di Balikpapan dengan pasir putih dan ombak yang tenang, ideal untuk rekreasi keluarga.",
      "foto":
          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "nama": "Hutan Lindung Sungai Wain",
      "jam_buka": "08:00:00",
      "jam_tutup": "17:00:00",
      "alamat":
          "Karang Joang, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur",
      "lat": "-1.132859",
      "lng": "116.868515",
      "kota": "Balikpapan",
      "kategori": "Hutan",
      "deskripsi":
          "Hutan Lindung Sungai Wain menawarkan petualangan eksotis dengan berbagai flora dan fauna yang terjaga, sempurna untuk pecinta alam dan peneliti.",
      "foto":
          "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "nama": "Pantai Melawai",
      "jam_buka": "05:00:00",
      "jam_tutup": "19:00:00",
      "alamat":
          "Jl. Jenderal Sudirman, Prapatan, Kec. Balikpapan Kota, Kota Balikpapan, Kalimantan Timur 76112",
      "lat": "-1.269317",
      "lng": "116.825544",
      "kota": "Balikpapan",
      "kategori": "Pantai",
      "deskripsi":
          "Pantai Melawai terkenal dengan pemandangan matahari terbenam yang indah dan banyak warung makan yang menyajikan seafood segar.",
      "foto":
          "https://images.unsplash.com/photo-1473186505569-9c61870c11f9?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "nama": "Taman Bekapai",
      "jam_buka": "06:00:00",
      "jam_tutup": "23:00:00",
      "alamat":
          "Jl. Jenderal Sudirman No.1, Klandasan Ulu, Kec. Balikpapan Kota, Kota Balikpapan, Kalimantan Timur 76113",
      "lat": "-1.267947",
      "lng": "116.829741",
      "kota": "Balikpapan",
      "kategori": "Taman",
      "deskripsi":
          "Taman Bekapai adalah tempat favorit bagi warga Balikpapan untuk bersantai dengan air mancur dan pencahayaan yang indah di malam hari.",
      "foto":
          "https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    }
  ];

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

    if (places.isNotEmpty) {
      double targetLat = double.parse(places[centerIndex.value]['lat']) ?? 0.0;
      double targetLng = double.parse(places[centerIndex.value]['lng']) ?? 0.0;

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
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    // // Call the function to calculate the distance
    checkLocationPermission();

    // Add listener for centerIndex changes
    ever(centerIndex, (_) => calculateDistance());
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
