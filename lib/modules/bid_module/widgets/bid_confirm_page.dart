import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/modules/bid_module/bid_viewmodel.dart';
import 'package:lottie/lottie.dart';

class BidConfirm extends StatelessWidget {
  const BidConfirm(
      {super.key,
      required this.viewmodel,
      required this.hiredName,
      required this.hiredAmount,
      required this.location,
      required this.phone});
  final BidViewmodel viewmodel;
  final String hiredName;
  final String hiredAmount;
  final String location;
  final String phone;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Lottie.asset(
                'assets/lottie/on_the_way2.json',
              ),
            ),
          ),
          hireCard(context, theme),
        ],
      ),
    );
  }

  Container hireCard(
    BuildContext context,
    ThemeData theme,
  ) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width - 40,
      //padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 17,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$hiredName is on his way to your location...',
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            mechanicCard(theme),
          ],
        ),
      ),
    );
  }

  mechanicCard(ThemeData theme) {
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
                hiredName[0],
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
                  hiredName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Hired Amount",
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(
                width: 150,
                child: Text(
                  '$hiredAmount CAD',
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
                  buttonText: 'Call',
                  onPressed: () async {
                    viewmodel.callMechanic(phone);
                  },
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
