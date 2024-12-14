import 'package:flutter/material.dart';

class OrderSummaryComponent extends StatelessWidget {
  const OrderSummaryComponent({
    super.key,
    required this.title,
    required this.vlaue,
  });
  final String title;
  final String vlaue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: const Color.fromARGB(255, 78, 76, 76),
              ),
        ),
        Text(
          '$vlaue\$',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              //color: Colors.black,
              ),
        ),
      ],
    );
  }
}
