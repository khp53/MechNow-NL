import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/common/custom_bottomsheet.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/common/custom_text_field.dart';
import 'package:hackathon_user_app/modules/home/home_viewmodel.dart';
import 'package:hackathon_user_app/modules/user_location/user_location.dart';

class MechanicHomeBody extends StatefulWidget {
  const MechanicHomeBody({super.key, required this.viewmodel});
  final HomeViewmodel viewmodel;

  @override
  State<MechanicHomeBody> createState() => _MechanicHomeBodyState();
}

class _MechanicHomeBodyState extends State<MechanicHomeBody> {
  @override
  void initState() {
    super.initState();
    //widget.viewmodel.getAllOpenRequests();
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
                      leading: Icon(
                        Icons.logout,
                        color: theme.colorScheme.primary,
                      ),
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
                "Welcome back!",
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Here are the latest requests",
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('requests')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
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
                                  style:
                                      theme.textTheme.headlineMedium!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                subtitle: Text(
                                  doc['problemType'],
                                  style:
                                      theme.textTheme.headlineMedium!.copyWith(
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
                                        long: double.parse(doc['userLatLang']
                                            .toString()
                                            .split(',')[1]),
                                        jobArea: '',
                                      ),
                                      transition: Transition.downToUp,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                hintText: "Type in your bid price *",
                                isObscured: false,
                                isDigit: false,
                                isRequired: true,
                                controller: widget.viewmodel.bidController,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                  child: CustomButton(
                                buttonText: "Submit Bid",
                                buttonColor: theme.colorScheme.primary,
                                textColor: theme.colorScheme.onPrimary,
                                onPressed: () async {
                                  await widget.viewmodel.submitBid(doc.id);
                                },
                              )),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No requests found'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
