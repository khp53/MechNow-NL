import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/modules/bid_module/bid_viewmodel.dart';
import 'package:hackathon_user_app/modules/home/home_view.dart';
import 'package:lottie/lottie.dart';

class BidBody extends StatelessWidget {
  const BidBody({super.key, required this.viewmodel, required this.docId});
  final BidViewmodel viewmodel;
  final String docId;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
          ),
          Positioned(
            bottom: 0,
            child: StreamBuilder<QuerySnapshot>(
              stream: viewmodel.fetchBidsSnapshot(docId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingBids(context, theme);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return snapshot.data!.docs.isEmpty
                      ? loadingBids(context, theme)
                      : hireCard(context, theme, snapshot);
                } else {
                  return loadingBids(context, theme);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container hireCard(BuildContext context, ThemeData theme,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return Container(
      height: 450,
      width: MediaQuery.of(context).size.width - 40,
      //padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hire a mechanic from the following bids',
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot bid = snapshot.data!.docs[index];
                return mechanicCard(bid, theme);
              },
            ),
            const Spacer(),
            CustomButton(
              buttonColor: theme.colorScheme.primary,
              textColor: theme.colorScheme.onPrimary,
              buttonText: 'Cancle',
              onPressed: () {
                Get.offAll(() => const HomeView());
              },
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<DocumentSnapshot<Object?>> mechanicCard(
      DocumentSnapshot<Object?> bid, ThemeData theme) {
    return StreamBuilder<DocumentSnapshot>(
        stream: viewmodel.getSpecificUser(bid['userId']),
        builder: (context, snapshot1) {
          if (snapshot1.hasData) {
            Map<String, dynamic> data =
                snapshot1.data!.data() as Map<String, dynamic>;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${data['name'][0]}',
                        style: theme.textTheme.headlineLarge!.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          '${data['name']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Biding Amount",
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          '${bid['amount']} CAD',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 40,
                        child: CustomButton(
                          buttonColor: theme.colorScheme.onPrimary,
                          textColor: theme.colorScheme.surface,
                          buttonText: 'Hire',
                          onPressed: () async {
                            await viewmodel.hireMechanic(
                              docId,
                              bid['userId'],
                              bid['amount'],
                              data['name'],
                              data['area'],
                              data['phone'],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['area'],
                        textAlign: TextAlign.end,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Container loadingBids(BuildContext context, ThemeData theme) {
    return Container(
      height: 370,
      width: MediaQuery.of(context).size.width - 40,
      //padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            minHeight: 10,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Searching for nearby mechanics...',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Center(
              child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Lottie.asset(
                'assets/lottie/shimmer.json',
                fit: BoxFit.cover,
              ),
            ),
          )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              buttonColor: theme.colorScheme.primary,
              textColor: theme.colorScheme.onPrimary,
              buttonText: 'Cancel',
              onPressed: () {
                Get.offAll(() => const HomeView());
              },
            ),
          ),
        ],
      ),
    );
  }
}
