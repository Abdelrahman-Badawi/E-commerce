import 'package:e_commerce/views/widgets/order_summary_component.dart';
import 'package:flutter/material.dart';

class CheckoutOrderDetails extends StatelessWidget {
  const CheckoutOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OrderSummaryComponent(title: 'Order', vlaue: '125'),
        SizedBox(height: 8.0,),
        OrderSummaryComponent(title: 'Delivery', vlaue: '15'),
        SizedBox(height: 8.0,),
        OrderSummaryComponent(title: 'Summary', vlaue: '140'),
      ],
    );
  }
}