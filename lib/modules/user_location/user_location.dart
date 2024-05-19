import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class NavigationPage extends StatefulWidget {
//   final double lat;
//   final double long;
//   const NavigationPage({super.key, required this.lat, required this.long});

//   @override
//   State<NavigationPage> createState() => _NavigationPageState();
// }

// class _NavigationPageState extends State<NavigationPage> {
//   String url = '';

//   _launchURL(String url) async {
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   var controller = WebViewController()
//     ..enableZoom(true)
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(const Color(0x00000000));

//   urlCreator() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     String navigationUrl =
//         "https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=${widget.lat},${widget.long}&travelmode=driving&dir_action=navigate";
//     return navigationUrl;
//   }

//   @override
//   void initState() {
//     super.initState();
//     urlCreator().then((val) {
//       setState(() {
//         url = val;

//         controller.setNavigationDelegate(
//           NavigationDelegate(
//             onProgress: (int progress) {
//               // Update loading bar.
//             },
//             onPageStarted: (String url) {},
//             onPageFinished: (String url) {},
//             onWebResourceError: (WebResourceError error) {},
//             onNavigationRequest: (NavigationRequest request) {
//               if (request.url.startsWith('intent://')) {
//                 _launchURL(
//                     'google.navigation:q=${widget.lat}, ${widget.long}&key=${AppConstants.google_api_key}');
//                 return NavigationDecision.prevent;
//               }
//               return NavigationDecision.navigate;
//             },
//           ),
//         );
//         controller.loadRequest(Uri.parse(url));
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Client Information",
//           textAlign: TextAlign.center,
//           style: categoryAppBarTitleStyle,
//         ),
//         backgroundColor: AppColors.colorWhite,
//         elevation: 1,
//         leading: Ripple(
//           child: const Icon(Icons.close, color: AppColors.photoIdTextColor),
//           onTap: () {
//             Navigator.of(context).pop(true);
//           },
//         ),
//       ),
//       body: WebViewWidget(controller: controller),
//     );
//   }
// }

class NavigationPage extends StatefulWidget {
  final double lat;
  final double long;
  final String jobArea;
  const NavigationPage(
      {super.key,
      required this.lat,
      required this.long,
      required this.jobArea});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final Set<Marker> markers = {};

  //BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  Position? currentLocation;

  @override
  void initState() {
    super.initState();
    //setCustomMarkerIcons();
    addMarkers();
  }

  addMarkers() async {
    // const LocationSettings locationSettings =
    //     LocationSettings(accuracy: LocationAccuracy.best);
    // this is just to get a static location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = position;
    });
    // Geolocator.getPositionStream(locationSettings: locationSettings)
    //     .listen((Position position) async {
    //   markers.removeWhere((element) => element.markerId.value == "source");
    //   markers.add(
    //     Marker(
    //       markerId: const MarkerId("source"),
    //       position: LatLng(position.latitude, position.longitude),
    //       icon: sourceIcon,
    //       infoWindow: const InfoWindow(
    //         title: "Current Location",
    //         snippet: "This is your current location.",
    //       ),
    //     ),
    //   );
    // });
    markers.add(
      Marker(
        markerId: const MarkerId("destination"),
        position: LatLng(widget.lat, widget.long),
        icon: destinationIcon,
        infoWindow: InfoWindow(
          title: "Job Location",
          snippet: "This is the job location. ${widget.jobArea}.",
        ),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId("fixed_start_point"),
        position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
        infoWindow: const InfoWindow(
          title: "Start Location",
          snippet: "This is where you started from.",
        ),
      ),
    );
    setState(() {});
  }

  // setCustomMarkerIcons() {
  //   BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(
  //       devicePixelRatio: 10.0,
  //       size: Size(
  //         200,
  //         200,
  //       ),
  //     ),
  //     'assets/images/current_location.png',
  //   ).then((onValue) {
  //     sourceIcon = onValue;
  //   });
  //   BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(
  //       devicePixelRatio: 10.0,
  //       size: Size(
  //         300,
  //         300,
  //       ),
  //     ),
  //     'assets/images/destination_location.png',
  //   ).then((onValue) {
  //     destinationIcon = onValue;
  //   });
  // }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = position;
    });
    getPolyPoints(
      position,
      travelMode: TravelMode.driving,
    );
  }

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints(
    Position position, {
    required TravelMode travelMode,
  }) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBqnVfSizkjnUTbX-VKIDQrkmLR0DKxwrQ",
      PointLatLng(position.latitude, position.longitude),
      PointLatLng(
        widget.lat,
        widget.long,
      ),
      optimizeWaypoints: true,
      travelMode: travelMode,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Navigate to Job Location",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: markers.isEmpty || markers.length == 1
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.long),
                    zoom: 14,
                  ),
                  markers: markers,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: true,
                  mapToolbarEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    locatePosition();
                    // _controller.complete(controller);
                    // newGoogleMapController = controller;
                    //addMarkers();
                  },
                  polylines: {
                    Polyline(
                      color: const Color(0xFF20609A),
                      jointType: JointType.round,
                      startCap: Cap.roundCap,
                      endCap: Cap.roundCap,
                      polylineId: const PolylineId("route"),
                      points: polylineCoordinates,
                      width: 5,
                    )
                  },
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        elevation: 2,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        onPressed: () {
                          polylineCoordinates.clear();
                          getPolyPoints(
                            currentLocation!,
                            travelMode: TravelMode.driving,
                          );
                          setState(() {});
                        },
                        child: Icon(
                          Icons.directions_car,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 8,
                      ),
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        elevation: 2,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        onPressed: () {
                          polylineCoordinates.clear();
                          getPolyPoints(
                            currentLocation!,
                            travelMode: TravelMode.walking,
                          );
                          setState(() {});
                        },
                        child: Icon(
                          Icons.directions_walk,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 8,
                      ),
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        elevation: 2,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        onPressed: () {
                          polylineCoordinates.clear();
                          getPolyPoints(
                            currentLocation!,
                            travelMode: TravelMode.transit,
                          );
                          setState(() {});
                        },
                        child: Icon(
                          Icons.directions_transit,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   onPressed: () async {
      //     callGetCurrentLocation();
      //     // getLocation();
      //   },
      //   child: const Icon(
      //     Icons.near_me,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
