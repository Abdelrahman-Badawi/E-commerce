class ApiPath {
  static String products() => 'products/';
  static String deliveryMethods() => 'deliveryMethods/';
  static String user(String uid) => 'users/$uid';
  static String userShippingAddress(String uid) =>
      'users/$uid/shippingAddresses/';
  static String newAddress(String uid, String addressId) =>
      'users/$uid/shippingAddresses/$addressId';
  static String addToCart(String uid, String addToCartId) =>
      'addToCart/$uid/cart/$addToCartId';
  static String myProductsCart(String uid) => 'addToCart/$uid/cart';

  static String addCard(String uid, String cardId) =>
      'users/$uid/cards/$cardId';
}
