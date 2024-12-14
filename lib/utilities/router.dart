import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/utilities/args_models/add_shipping_address_args.dart';
import 'package:e_commerce/utilities/routes.dart';
import 'package:e_commerce/views/pages/bottom_navbar.dart';
import 'package:e_commerce/views/pages/checkout/add_new_card_page.dart';
import 'package:e_commerce/views/pages/checkout/add_shipping%20_address_page.dart';
import 'package:e_commerce/views/pages/checkout/checkout_page.dart';
import 'package:e_commerce/views/pages/checkout/payment_methods_page.dart';
import 'package:e_commerce/views/widgets/checkout/shipping_address_page.dart';
import 'package:e_commerce/views/pages/landing_page.dart';
import 'package:e_commerce/views/pages/auth_page.dart';
import 'package:e_commerce/views/pages/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
        builder: (constext) => const AuthPage(),
        settings: settings,
      );
    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
        builder: (context) => const BottomNavbar(),
        settings: settings,
      );
    case AppRoutes.checkoutPageRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (context) => Provider<Database>.value(
          value: database,
          child: const CheckoutPage(),
        ),
        settings: settings,
      );
    case AppRoutes.productDetailsRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final database = args['database'];
      final product = args['product'];
      return CupertinoPageRoute(
        builder: (context) => Provider<Database>.value(
          value: database,
          child: ProductDetails(
            product: product,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.shippingAddressesRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (context) => Provider<Database>.value(
          value: database,
          child: const ShippingAddressPage(),
        ),
      );
    case AppRoutes.paymentMethodsRoute:
      return CupertinoPageRoute(
        builder: (context) => const PaymentMethodsPage(),
        settings: settings,
      );

    // case AppRoutes.addNewCard:
    //   return CupertinoPageRoute(
    //       builder: (context) => const AddNewCardPage(), settings: settings);

    case AppRoutes.addShippingAddressRoute:
      final args = settings.arguments as AddShippingAddressArgs;
      final database = args.database;
      final shippingnAddress = args.shippingAddress;
      return CupertinoPageRoute(
          builder: (context) => Provider<Database>.value(
                value: database,
                child: AddShippingAddressPage(
                  shippingAddress: shippingnAddress,
                ),
              ));
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (context) => const LandingPage(),
        settings: settings,
      );
  }
}
