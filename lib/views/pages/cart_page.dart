import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/utilities/routes.dart';
import 'package:e_commerce/views/widgets/cart_list_item.dart';
import 'package:e_commerce/views/widgets/main_botton.dart';
import 'package:e_commerce/views/widgets/order_summary_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalAmount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTotalAmount();
  }

  Future<void> _updateTotalAmount() async {
    final myProducts = await Provider.of<Database>(context, listen: false)
        .myProductsCart()
        .first;

    setState(() {
      totalAmount = myProducts.fold(0, (sum, item) => sum + item.price);
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
        stream: database.myProductsCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final cartItems = snapshot.data;

            // Update total amount whenever the cart items change
            if (cartItems != null) {
              totalAmount = cartItems.fold(0, (sum, item) => sum + item.price);
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'My Cart',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 16.0),
                    if (cartItems == null || cartItems.isEmpty)
                      Center(
                        child: Text(
                          'No Data Available!',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    if (cartItems != null && cartItems.isNotEmpty)
                      ListView.builder(
                        itemCount: cartItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          final cartItem = cartItems[i];
                          return CartListItem(
                            cartItem: cartItem,
                          );
                        },
                      ),
                    const SizedBox(height: 24.0),
                    OrderSummaryComponent(
                      title: 'Total Amount',
                      vlaue: totalAmount.toString(),
                    ),
                    const SizedBox(height: 32.0),
                    MainBotton(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                            AppRoutes.checkoutPageRoute,
                            arguments: database);
                      },
                      text: 'Checkout',
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
