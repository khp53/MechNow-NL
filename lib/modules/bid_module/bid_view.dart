import 'package:flutter/material.dart';
import 'package:hackathon_user_app/modules/bid_module/bid_viewmodel.dart';
import 'package:hackathon_user_app/modules/bid_module/widgets/bid_body.dart';
import 'package:hackathon_user_app/modules/view.dart';

class BidView extends StatelessWidget {
  const BidView({super.key, required this.docId});
  final String docId;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      builder: (_, viewmodel, __) {
        return BidBody(
          viewmodel: viewmodel,
          docId: docId,
        );
      },
      viewmodel: BidViewmodel(),
    );
  }
}
