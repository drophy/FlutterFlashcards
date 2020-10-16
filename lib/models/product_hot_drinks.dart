import 'dart:math';
import 'package:flutter/foundation.dart';

enum ProductSize { CH, M, G }

class ProductHotDrinks {
  final String productTitle; // nombre del producto
  final String productDescription; // descripcion del producto
  final String productImage; // url de imagen del producto
  ProductSize productSize; // tamano del producto
  double productPrice; // precio del producto autocalculado
  final int productAmount; // cantidad de producto por comprar
  final bool liked;

  ProductHotDrinks({
    @required this.productTitle,
    @required this.productDescription,
    @required this.productImage,
    @required this.productSize,
    @required this.productAmount,
    this.liked = false,
  }) {
    // inicializa el precio de acuerdo a la size del producto
    productPrice = productPriceCalculator();
  }

  // Mandar llamar este metodo cuando se cambie el tamanio del producto
  // De esta manera el precio del nuevo tamanio del producto se autocalcula
  // Por ejemplo cuando se cambie a M
  //
  // FlatButton(
  //   child: Text("M"),
  //   onPressed: () {
  //     setState(() {
  //       prod.productSize = ProductSize.M;
  //       prod.productPrice = prods.productPriceCalculator();
  //     });
  //   },
  // ),
  //
  //
  double productPriceCalculator() {
    if (this.productSize == ProductSize.CH)
      return (20 + Random().nextInt(40)).toDouble();
    if (this.productSize == ProductSize.M)
      return (40 + Random().nextInt(60)).toDouble();
    if (this.productSize == ProductSize.G)
      return (60 + Random().nextInt(80)).toDouble();
    return 999.0;
  }
}
