
import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utilities/constans.dart';
import 'package:e_commerce/views/widgets/drop_down_menu.dart';
import 'package:e_commerce/views/widgets/main_botton.dart';
import 'package:e_commerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorit = false;
  late String dropdownValue;
  Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        productId: widget.product.id,
        title: widget.product.title,
        price: widget.product.price,
        imageUrl: widget.product.imageUrl,
        size: dropdownValue,
      );
      await database.addToCart(addToCartProduct);
    } catch (e) {
      MainDialog(
        // ignore: use_build_context_synchronously
        context: context,
        title: 'Error',
        content: 'Couldn\'t adding to the cart, Please try again!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imageUrl,
              width: double.infinity,
              height: size.height * 0.5,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropDownMenuComponent(
                          onSelected: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          dropdownMenuEntries: const [
                            'S',
                            'M',
                            'L',
                            'XL',
                            'XXL'
                          ],
                          hintText: 'size'),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isFavorit = !isFavorit;
                            });
                          },
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: DecoratedBox(
                              decoration:const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:const EdgeInsets.all(8.0),
                                child: Icon(
                                  isFavorit
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: isFavorit
                                      ? Colors.redAccent
                                      : Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    widget.product.category,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'This is a dummy descraption for this product! I think we will add it in the future! I need to add more lines,so I add these words just to have more than two lines!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  MainBotton(
                    onTap: () => (_addToCart(database)),
                    text: 'Add to cart',
                  ),
                  const SizedBox(
                    height: 32.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
