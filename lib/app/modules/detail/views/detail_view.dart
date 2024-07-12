import 'package:explore_indonesia/app/env/colors.dart';
import 'package:explore_indonesia/app/widgets/button.dart';
import 'package:explore_indonesia/app/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  DetailView({Key? key}) : super(key: key);
  DetailController detailController = Get.put(DetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.network(
              detailController.dataArguments["foto"],
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        child: Center(
                            child: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                          size: 30,
                        ))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          "${detailController.dataArguments["nama"]}",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_filled,
                              size: 14,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${detailController.formatTime(detailController.dataArguments["jam_buka"])} - ${detailController.formatTime(detailController.dataArguments["jam_tutup"])}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.forest,
                              size: 14,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Wisata ${detailController.dataArguments["kategori"]}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 14,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Obx(
                              () => Text(
                                "${detailController.distanceToPlace} Dari posisi kamu saat ini. ",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 14,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                "${detailController.dataArguments["alamat"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CText(
                          "Deskripsi",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        CText(
                          "${detailController.dataArguments["deskripsi"]}",
                          fontSize: 14,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        PrimaryButton(
                            text: "Lihat Di Google Maps",
                            onTap: () {
                              detailController.launchInBrowser(Uri.parse(
                                  "http://maps.google.com/maps?z=12&t=m&q=loc:${detailController.dataArguments["lat"]}+${detailController.dataArguments["lng"]}"));
                            })
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
