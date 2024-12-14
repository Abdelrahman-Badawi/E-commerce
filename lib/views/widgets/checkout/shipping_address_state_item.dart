import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/utilities/args_models/add_shipping_address_args.dart';
import 'package:e_commerce/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressStateItem extends StatefulWidget {
  const ShippingAddressStateItem({
    super.key,
    required this.shippingAddress,
  });
  final ShippingAddress shippingAddress;

  @override
  State<ShippingAddressStateItem> createState() =>
      _ShippingAddressStateItemState();
}

class _ShippingAddressStateItemState extends State<ShippingAddressStateItem> {
  late bool checkedValue;

  @override
  void initState() {
    super.initState();
    checkedValue = widget.shippingAddress.isDfault;
  }

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
                  widget.shippingAddress.fullName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.addShippingAddressRoute,
                          arguments: AddShippingAddressArgs(
                            database: database,
                            shippingAddress: widget.shippingAddress,
                          )),
                  child: Text(
                    'Edit',
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
              widget.shippingAddress.address,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${widget.shippingAddress.city}, ${widget.shippingAddress.state}, ${widget.shippingAddress.country}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            CheckboxListTile(
              title: const Text('Default shipping adress'),
              value: checkedValue,
              onChanged: (newValue) async {
                setState(() {
                  checkedValue = newValue!;
                });
                final newAddress =
                    widget.shippingAddress.copyWith(isDfault: checkedValue);
                await database.saveAddress(newAddress);
              },
              activeColor: Colors.black,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }
}
