// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hackathon_user_app/common/custom_bottomsheet.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/common/custom_text_field.dart';
import 'package:hackathon_user_app/model/category.dart';
import 'package:hackathon_user_app/modules/bid_module/bid_view.dart';
import 'package:hackathon_user_app/modules/find_mechanic/find_mechanic_viewmodel.dart';

class FindMechanicBody extends StatefulWidget {
  const FindMechanicBody(
      {super.key,
      required this.viewmodel,
      this.pickedLocation,
      required this.category});
  final FindMechanicViewmodel viewmodel;
  final PickResult? pickedLocation;
  final CategoryModel category;

  @override
  State<FindMechanicBody> createState() => _FindMechanicBodyState();
}

class _FindMechanicBodyState extends State<FindMechanicBody> {
  Position? currentLocation;

  @override
  void initState() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (value) => setState(() {
        currentLocation = value;
      }),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude, currentLocation!.longitude),
                zoom: 14.4746,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {},
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 370,
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.all(20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter what kind of ${widget.category.name} assist do you need?',
                      style: theme.textTheme.headlineMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    problemType(theme),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      number: 4,
                      hintText: "Note...",
                      isObscured: false,
                      isDigit: false,
                      isRequired: false,
                      controller: widget.viewmodel.noteController,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        buttonText: 'Find Mechanic',
                        buttonColor: theme.colorScheme.primary,
                        textColor: theme.colorScheme.onPrimary,
                        onPressed: () async {
                          if (widget.viewmodel.problemType.isEmpty) {
                            customSnackBar(
                              title: "Alert!",
                              message: "Please choose a problem type!",
                              bgColor: Colors.red,
                            );
                          } else if (widget.viewmodel.problemType
                                      .toLowerCase() ==
                                  'others' &&
                              widget.viewmodel.noteController.text.isEmpty) {
                            customSnackBar(
                              title: "Alert!",
                              message: "Please enter a note!",
                              bgColor: Colors.red,
                            );
                          } else {
                            var res =
                                await widget.viewmodel.sendMechanicRequest(
                              latLang:
                                  '${widget.pickedLocation!.geometry!.location.lat},${widget.pickedLocation!.geometry!.location.lng}',
                              requestType: widget.category.type!,
                            );
                            if (res.statusCode == 200) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          BidView(
                                    docId: res.body,
                                  ),
                                  opaque: false,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget problemType(ThemeData theme) {
    return InkWell(
      onTap: () => bottomSheet(
        theme,
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Select a problem from below *',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                'Flat tire',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Flat tire');
                // Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Jump start',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Jump start');
                // Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Lost my keys',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Lost my keys');
                // Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Need roof repair',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Need roof repair');
                // Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Heater knob broken',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Heater knob broken');
                // Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Out of fuel',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Out of fuel');
                // Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Locked out',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Locked out');
                // Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Water leakage',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Water leakage');
                // Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Others',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.viewmodel.setProblemType('Others');
                // Get.back();
              },
            ),
            const Divider(),
          ],
        ),
      ),
      child: Container(
        //height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF828282),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              widget.viewmodel.problemType.isEmpty
                  ? 'Select a problem *'
                  : widget.viewmodel.problemType,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: const Color(0xFF828282),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
