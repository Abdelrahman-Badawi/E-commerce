
import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utilities/assets.dart';
import 'package:e_commerce/views/pages/list_item_home.dart';
import 'package:e_commerce/views/widgets/header_of_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  AppAssets.topBannerHomePage,
                  height: size.height * 0.28,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.28,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  child: Text(
                    'Street Clothes',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  HeaderOfList(
                    title: 'Sale',
                    descraption: 'Super Summer Sale! ',
                    onTap: () {},
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 330,
                    child: StreamBuilder<List<Product>>(
                        stream: database.salesProductsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            final products = snapshot.data;
                            if (products == null || products.isEmpty) {
                              return const Center(
                                  child: Text('No Data Avilable'));
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItemHome(
                                  isNew: true,
                                  product: products[index],
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                  HeaderOfList(
                    title: 'New',
                    descraption: 'Super New Products!',
                    onTap: () {},
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 330,
                    child: StreamBuilder<List<Product>>(
                        stream: database.newProductsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            final products = snapshot.data;
                            if (products == null || products.isEmpty) {
                              return const Center(
                                child: Text('No Data Available'),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItemHome(
                                  isNew: true,
                                  product: products[index],
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
