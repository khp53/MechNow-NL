import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hackathon_user_app/common/custom_bottomsheet.dart';
import 'package:hackathon_user_app/modules/find_mechanic/find_mechanic_view.dart';
import 'package:hackathon_user_app/modules/home/home_viewmodel.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key, required this.viewmodel});
  final HomeViewmodel viewmodel;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    widget.viewmodel.isLoading = true;
    widget.viewmodel.getUserData().then((value) {
      widget.viewmodel.isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        title: Text(
          'MechNow NL',
          style: theme.textTheme.headlineMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 15, bottom: 10),
            child: InkWell(
              onTap: () => bottomSheet(
                theme,
                Column(
                  children: [
                    // ListTile(
                    //   title: Text('Profile'),
                    //   leading: Icon(Icons.person),
                    //   onTap: () {
                    //     Get.back();
                    //     Get.toNamed('/profile');
                    //   },
                    // ),
                    ListTile(
                      title: const Text('Logout'),
                      leading: const Icon(Icons.logout),
                      onTap: () {
                        Get.back();
                        widget.viewmodel.logout();
                      },
                    ),
                  ],
                ),
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/44136592?v=4',
                ),
              ),
            ),
          ),
        ],
      ),
      body: widget.viewmodel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${widget.viewmodel.username}!',
                      style: theme.textTheme.headlineMedium!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Select which type\nof mechanic you need.',
                      style: theme.textTheme.headlineMedium!.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 35),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: widget.viewmodel.categories.length,
                      itemBuilder: (context, index) {
                        var category = widget.viewmodel.categories[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => PlacePicker(
                                apiKey:
                                    "AIzaSyBqnVfSizkjnUTbX-VKIDQrkmLR0DKxwrQ",
                                onPlacePicked: (result) {
                                  Get.to(
                                    () => FindMechanicView(
                                      pickedLocation: result,
                                      category: category,
                                    ),
                                  );
                                },
                                initialPosition:
                                    const LatLng(-33.8567844, 151.213108),
                                hintText: "Find a place ...",
                                searchingText: "Please wait ...",
                                selectText: "Select place",
                                outsideOfPickAreaText: "Place not in area",
                                useCurrentLocation: true,
                                selectInitialPosition: true,
                                usePinPointingSearch: true,
                                usePlaceDetailSearch: true,
                                zoomGesturesEnabled: true,
                                zoomControlsEnabled: true,
                                resizeToAvoidBottomInset:
                                    false, // only works in page mode, less flickery, remove if wrong offsets
                              ),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  category.image!,
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  category.name!,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
