import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utilities/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ListItemHome extends StatelessWidget {
  ListItemHome({
    super.key,
    required this.product,
    required this.isNew,
    this.addToFavorit,
    this.isFavorit = false,
  });

  final Product product;
  final bool isNew;
  final VoidCallback? addToFavorit;
  bool isFavorit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.productDetailsRoute,
        arguments: {
          'product': product,
          'database':database,
        },
      ),
      child: Stack(children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                product.imageUrl,
                height: 180,
                width: 155,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: isNew ? Colors.black : Colors.red),
                  child: Center(
                    child: Text(
                      isNew ? 'NEW' : '${product.discountValue}%',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: isNew ? Colors.black : Colors.red,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      isNew ? 'NEW' : '${product.discountValue}%',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: size.width * 0.28,
          bottom: size.height * 0.19,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18.0,
              child: InkWell(
                onTap: addToFavorit,
                child: Icon(
                  isFavorit ? Icons.favorite : Icons.favorite_outline,
                  size: 18.0,
                  color: isFavorit ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RatingBarIndicator(
                    itemCount: 5,
                    itemSize: 20.0,
                    rating: 4.0,
                    direction: Axis.horizontal,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    ('(100)'),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                product.category,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                product.title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              isNew
                  ? Text(
                      '${product.price}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.grey,
                          ),
                    )
                  : Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${product.price}\$ ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                          TextSpan(
                            text:
                                ' ${product.price * (product.discountValue) / 100}\$',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.red,
                                ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        )
        //  Text.rich(
        //    TextSpan(
        //      children: [
        //        TextSpan(
        //          text: '${product.price}\$',
        //          style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //                color: Colors.grey,
        //               decoration: TextDecoration.lineThrough,
        //              ),
        //        ),
        //        TextSpan(
        //            text: ' ${product.price * (product.discountValue) / 100}\$',
        //           style: Theme.of(context).textTheme.titleMedium),
        //     ],
        //   ),
        // ),
      ]),
    );
  }
}
