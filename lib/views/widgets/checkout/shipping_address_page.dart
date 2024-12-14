import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/utilities/args_models/add_shipping_address_args.dart';
import 'package:e_commerce/utilities/routes.dart';
import 'package:e_commerce/views/widgets/checkout/shipping_addres_component.dart';
import 'package:e_commerce/views/widgets/checkout/shipping_address_state_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Addresses',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 8.0,
          ),
          child: StreamBuilder<List<ShippingAddress>>(
              stream: database.getShippingAddresses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final shippingAddress = snapshot.data;

                  return Column(
                    children: shippingAddress!
                        .map((shippingAddress) => ShippingAddressStateItem(
                              shippingAddress: shippingAddress,
                            ))
                        .toList(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AppRoutes.addShippingAddressRoute,
          arguments: AddShippingAddressArgs(database: database),
        ),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
