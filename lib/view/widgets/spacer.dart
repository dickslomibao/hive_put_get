import 'package:flutter/cupertino.dart';

class SpacerWidget extends StatelessWidget {
   SpacerWidget({super.key, required this.height});
  double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}