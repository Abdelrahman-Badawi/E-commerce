import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/delivery_method.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/utilities/args_models/add_shipping_address_args.dart';
import 'package:e_commerce/utilities/routes.dart';
import 'package:e_commerce/views/pages/checkout/checkout_order_details.dart';
import 'package:e_commerce/views/widgets/checkout/delivery_method_item.dart';
import 'package:e_commerce/views/widgets/main_botton.dart';
import 'package:e_commerce/views/widgets/checkout/payment_component.dart';
import 'package:e_commerce/views/widgets/checkout/shipping_addres_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckOut'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping address',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 8.0,
              ),
              StreamBuilder<List<ShippingAddress>>(
                  stream: database.getShippingAddresses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final shippingAddress = snapshot.data;
                      if (shippingAddress == null || shippingAddress.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const Text('No Shipping Address'),
                              const SizedBox(
                                height: 6.0,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.shippingAddressesRoute,
                                    arguments: AddShippingAddressArgs(
                                        database: database),
                                  );
                                },
                                child: Text(
                                  'Add new one',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.redAccent,
                                      ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      final shippingAddres = shippingAddress.first;
                      return ShippingAddresComponent(
                        shippingAddress: shippingAddres,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'payment',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.paymentMethodsRoute);
                    },
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
              const PaymentComponent(),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Delivary method',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 24.0,
              ),
              StreamBuilder<List<DeliveryMethod>>(
                  stream: database.deliveryMethodStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final deliveryMethods = snapshot.data?.reversed.toList();
                      if (deliveryMethods == null || deliveryMethods.isEmpty) {
                        return const Center(
                          child: Text('No delivery method Available'),
                        );
                      }
                      return SizedBox(
                        height: size.height * 0.14,
                        child: ListView.builder(
                          itemCount: deliveryMethods.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DeliveryMethodItem(
                              deliveryMethod: deliveryMethods[i],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  }),
              const SizedBox(
                height: 32.0,
              ),
              const CheckoutOrderDetails(),
              const SizedBox(
                height: 64.0,
              ),
              MainBotton(onTap: () {}, text: 'Check Order'),
            ],
          ),
        ),
      ),
    );
  }
}
