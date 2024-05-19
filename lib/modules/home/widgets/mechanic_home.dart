import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/common/custom_bottomsheet.dart';
import 'package:hackathon_user_app/modules/home/home_viewmodel.dart';

class MechanicHomeBody extends StatelessWidget {
  const MechanicHomeBody({super.key, required this.viewmodel});
  final HomeViewmodel viewmodel;

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
                        viewmodel.logout();
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
    );
  }
}
