import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  Position? currentLocation;
  bool mapsLoaded = false;

  @override
  void initState() {
    super.initState();

    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (value) => setState(() {
        currentLocation = value;
      }),
    );
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back!',
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          apiKey: "YOUR_API_KEY",
                          onPlacePicked: (result) {
                            Get.to(
                              () => FindMechanicView(
                                pickedLocation: result,
                                category: category,
                              ),
                            );
                            setState(() {
                              mapsLoaded = false;
                            });
                          },
                          initialPosition: LatLng(
                            currentLocation!.latitude,
                            currentLocation!.longitude,
                          ),
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
                          resizeToAvoidBottomInset: false,
                          initialMapType: MapType.normal,
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.08),
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
