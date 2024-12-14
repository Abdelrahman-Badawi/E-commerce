import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/delivery_method.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/models/user_data.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utilities/api_path.dart';

abstract class Database {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();
  Stream<List<AddToCartModel>> myProductsCart();
  Stream<List<DeliveryMethod>> deliveryMethodStream();
  Stream<List<ShippingAddress>> getShippingAddresses();
  Future<void> setUserData(UserData userData);
  Future<void> addToCart(AddToCartModel product);
  Future<void> saveAddress(ShippingAddress address);
}

class FirestoreDatabase implements Database {
  final String uid;
  FirestoreDatabase(this.uid);
  final _services = FirestoreServices.instance;

  @override
  Stream<List<Product>> salesProductsStream() => _services.collectionsStream(
      path: ApiPath.products(),
      builder: (data, documentId) => Product.fromMap(data!, documentId),
      queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0));

  @override
  Stream<List<Product>> newProductsStream() => _services.collectionsStream(
      path: ApiPath.products(),
      builder: (data, documentId) => Product.fromMap(data!, documentId));

  Future<void> setProduct(Product product) async => _services.setData(
        path: 'products/${product.id}',
        data: product.toMap(),
      );

  @override
  Future<void> setUserData(UserData userData) async => await _services.setData(
        path: ApiPath.user(userData.uid),
        data: userData.toMap(),
      );

  @override
  Future<void> addToCart(AddToCartModel product) async =>
      await _services.setData(
        path: ApiPath.addToCart(uid, product.id),
        data: product.toMap(),
      );

  FirestoreDatabase copyWith({
    String? uid,
  }) {
    return FirestoreDatabase(
      uid ?? this.uid,
    );
  }

  @override
  Stream<List<AddToCartModel>> myProductsCart() => _services.collectionsStream(
      path: ApiPath.myProductsCart(uid),
      builder: (data, documentId) => AddToCartModel.fromMap(data!, documentId));

  @override
  Stream<List<DeliveryMethod>> deliveryMethodStream() =>
      _services.collectionsStream(
          path: ApiPath.deliveryMethods(),
          builder: (data, documentId) =>
              DeliveryMethod.fromMap(data!, documentId));

  @override
  Stream<List<ShippingAddress>> getShippingAddresses() =>
      _services.collectionsStream(
          path: ApiPath.userShippingAddress(uid),
          builder: (data, documentId) =>
              ShippingAddress.fromMap(data!, documentId));

  @override
  Future<void> saveAddress(ShippingAddress address) =>
      _services.setData(path: ApiPath.newAddress(uid, address.id,), data: address.toMap());
}
