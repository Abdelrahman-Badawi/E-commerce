import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddresComponent extends StatelessWidget {
  const ShippingAddresComponent({
    super.key,
    required this.shippingAddress,
  });
  final ShippingAddress shippingAddress;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.shippingAddressesRoute, arguments: database,),
                  child: Text(
                    'Change',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              shippingAddress.address,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${shippingAddress.city}, ${shippingAddress.state}, ${shippingAddress.country}',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
