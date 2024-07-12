import 'package:explore_indonesia/app/env/colors.dart';
import 'package:explore_indonesia/app/modules/detail/views/detail_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_places_controller.dart';

class ListPlacesView extends GetView<ListPlacesController> {
  ListPlacesView({Key? key}) : super(key: key);
  ListPlacesController listPlacesController = Get.put(ListPlacesController());
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
            child: Image.asset(
              "assets/bg.png",
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 28,
                    height: MediaQuery.of(context).size.height - 120,
                    child: ListView.builder(
                      itemCount: listPlacesController.places.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => DetailView(),
                                arguments: listPlacesController.places[index]);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16),
                            height: 250,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(listPlacesController
                                          .places[index]["foto"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  right: 16,
                                  left: 16,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${listPlacesController.places[index]["nama"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_filled,
                                              size: 14,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "${listPlacesController.formatTime(listPlacesController.places[index]["jam_buka"])} - ${listPlacesController.formatTime(listPlacesController.places[index]["jam_tutup"])}",
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              size: 14,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            SizedBox(
                                              width: 170,
                                              child: Text(
                                                "${listPlacesController.places[index]["alamat"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
