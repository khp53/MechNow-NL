import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hackathon_user_app/common/custom_bottomsheet.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/common/custom_text_field.dart';
import 'package:hackathon_user_app/model/category.dart';
import 'package:hackathon_user_app/modules/find_mechanic/find_mechanic_viewmodel.dart';

class FindMechanicBody extends StatelessWidget {
  const FindMechanicBody(
      {super.key,
      required this.viewmodel,
      this.pickedLocation,
      required this.category});
  final FindMechanicViewmodel viewmodel;
  final PickResult? pickedLocation;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-33.8567844, 151.213108),
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
                      'Enter what kind of ${category.name} assist do you need?',
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
                      controller: viewmodel.noteController,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        buttonText: 'Find Mechanic',
                        buttonColor: theme.colorScheme.primary,
                        textColor: theme.colorScheme.onPrimary,
                        onPressed: () async {
                          if (viewmodel.problemType.isEmpty) {
                            customSnackBar(
                              title: "Alert!",
                              message: "Please choose a problem type!",
                              bgColor: Colors.red,
                            );
                          } else if (viewmodel.problemType.toLowerCase() ==
                                  'others' &&
                              viewmodel.noteController.text.isEmpty) {
                            customSnackBar(
                              title: "Alert!",
                              message: "Please enter a note!",
                              bgColor: Colors.red,
                            );
                          } else {
                            await viewmodel.sendMechanicRequest(
                              latLang:
                                  '${pickedLocation!.geometry!.location.lat},${pickedLocation!.geometry!.location.lng}',
                              requestType: category.type!,
                            );
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
                viewmodel.setProblemType('Flat tire');
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
                viewmodel.setProblemType('Jump start');
                // Get.back();
              },
            ),
            ListTile(
              title: Text(
                'Out of fuel',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                viewmodel.setProblemType('Out of fuel');
                // Get.back();
              },
            ),
            ListTile(
              title: Text(
                'Locked out',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                viewmodel.setProblemType('Locked out');
                // Get.back();
              },
            ),
            ListTile(
              title: Text(
                'Others',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                viewmodel.setProblemType('Others');
                // Get.back();
              },
            ),
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
              viewmodel.problemType.isEmpty
                  ? 'Select a problem *'
                  : viewmodel.problemType,
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
