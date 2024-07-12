import 'package:explore_indonesia/app/env/colors.dart';
import 'package:explore_indonesia/app/modules/detail/views/detail_view.dart';
import 'package:explore_indonesia/app/modules/listPlaces/views/list_places_view.dart';
import 'package:explore_indonesia/app/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
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
                  Obx(
                    () => TextField(
                      focusNode: homeController.focusNode,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Cari Tempat Wisata',
                        filled: true,
                        hintStyle: TextStyle(
                          color: Color(0xFF758673),
                        ),
                        fillColor: homeController.isFocused.value
                            ? Colors.white
                            : Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Color(0xFFBBCDD5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Color(0xFFBBCDD5)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 28,
                    height: 50,
                    child: Obx(
                      () => ListView(
                        scrollDirection: Axis.horizontal,
                        children: homeController.cities.map((city) {
                          final bool isActive =
                              homeController.activeCity == city;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(canvasColor: Colors.transparent),
                              child: ChoiceChip(
                                showCheckmark: false, // Add this Code
                                label: Text(
                                  city,
                                  style: TextStyle(
                                    color: isActive
                                        ? Colors.white
                                        : Color(0xFF758673),
                                    fontWeight: isActive
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                selected: isActive,
                                onSelected: (bool selected) {
                                  homeController.activeCity.value =
                                      (selected ? city : city)!;
                                },
                                selectedColor: Color(0xFF96BB13),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Color(0xFFBBCDD5)),
                                ),
                                side: BorderSide(color: Color(0xFFBBCDD5)),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Tempat Terdekat",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      GestureDetector(
                        child: Icon(Icons.arrow_forward_ios),
                        onTap: () => Get.to(() => ListPlacesView()),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width - 28,
                    child: ListView.builder(
                      controller: homeController.scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.places.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => DetailView(),
                                  arguments: homeController.places[index]);
                            },
                            child: SizedBox(
                              width: 270,
                              height: 350,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                        image: NetworkImage(homeController
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
                                            "${homeController.places[index]["nama"]}",
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
                                                "${homeController.formatTime(homeController.places[index]["jam_buka"])} - ${homeController.formatTime(homeController.places[index]["jam_tutup"])}",
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
                                                  "${homeController.places[index]["alamat"]}",
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
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            
                  SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 80,
                            child: CText(
                              "${homeController.places[homeController.centerIndex.value]["deskripsi"]}",
                              color: Colors.white,
                              fontSize: 14,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.forest,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CText(
                                "Wisata ${homeController.places[homeController.centerIndex.value]["kategori"]}",
                                color: Colors.white,
                              ),
                              Spacer(),
                              Obx(
                                () => CText(
                                  homeController.distanceToPlace.value,  // Update the text to show distance
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
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