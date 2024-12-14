import 'package:e_commerce/views/pages/checkout/add_new_card_bottom_sheet.dart';
import 'package:e_commerce/views/widgets/main_botton.dart';
import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pyament Methods'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your payment cards',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, indxe) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.credit_card),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text('**** **** **** 3253'),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // child: ListTile(
                      //     leading: Icon(Icons.credit_card),
                      //     title: const Text('**** **** **** 3241'),
                      //     trailing: IconButton(
                      //         onPressed: () {},
                      //         icon: const Icon(Icons.delete))),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              MainBotton(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return AddNewCardBottomSheet();
                        });
                  },
                  text: 'Add New Card')
            ],
          ),
        ),
      ),
    );
  }
}
