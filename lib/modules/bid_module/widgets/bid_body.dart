import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/modules/bid_module/bid_viewmodel.dart';

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
            child: StreamBuilder(
              stream: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return Container(
                    height: 370,
                    width: MediaQuery.of(context).size.width - 40,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(),
                  );
                } else {
                  return Container(
                    height: 370,
                    width: MediaQuery.of(context).size.width - 40,
                    //padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                          valueColor:
                              AlwaysStoppedAnimation(theme.colorScheme.primary),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Searching for nearby mechanics...',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: CustomButton(
                            buttonColor: theme.colorScheme.primary,
                            textColor: theme.colorScheme.onPrimary,
                            buttonText: 'Cancel',
                            onPressed: () {
                              // Add your cancel code here
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
