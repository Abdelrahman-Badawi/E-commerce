import 'package:e_commerce/models/delivery_method.dart';
import 'package:flutter/material.dart';

class DeliveryMethodItem extends StatelessWidget {
  const DeliveryMethodItem({super.key, required this.deliveryMethod});
  final DeliveryMethod deliveryMethod;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              deliveryMethod.imageUrl,
              fit: BoxFit.cover,
              height: 30,
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              '${deliveryMethod.days} days',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
