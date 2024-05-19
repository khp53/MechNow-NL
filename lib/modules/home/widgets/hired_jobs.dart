import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/modules/home/home_viewmodel.dart';
import 'package:hackathon_user_app/modules/user_location/user_location.dart';
import 'package:lottie/lottie.dart';

class HiredJob extends StatelessWidget {
  const HiredJob({super.key, required this.viewmodel});
  final HomeViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        title: Text(
          'MechNow NL',
          style: theme.textTheme.headlineMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back!",
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Here are all your hired jobs.",
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('requests')
                  .where("status", isEqualTo: "hired")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return snapshot.data!.docs.isEmpty
                      ? Center(
                          child: SizedBox(
                            child: Lottie.asset(
                              'assets/lottie/not_found.json',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      doc['name'],
                                      style: theme.textTheme.headlineMedium!
                                          .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    subtitle: Text(
                                      doc['problemType'],
                                      style: theme.textTheme.headlineMedium!
                                          .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.navigation,
                                        color: theme.colorScheme.primary,
                                      ),
                                      onPressed: () {
                                        Get.to(
                                          () => NavigationPage(
                                            lat: double.parse(doc['userLatLang']
                                                .toString()
                                                .split(',')[0]),
                                            long: double.parse(
                                                doc['userLatLang']
                                                    .toString()
                                                    .split(',')[1]),
                                            jobArea: '',
                                          ),
                                          transition: Transition.downToUp,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                } else {
                  return Center(
                    child: Lottie.asset('assets/lottie/not_found.json'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
