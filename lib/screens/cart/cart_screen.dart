import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';
import '../../../../providers/cart_provider.dart';
import '../../dialog/confirmation.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';
import '../../widgets/loading.dart';
import '../../ui/text_styles.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: itemColor,
      appBar: AppBar(
        backgroundColor: appBarColorDefault,
        elevation: 1,
        leading: BackButton(
          color: kTextColor,
          onPressed: () {
            final productProvider = Provider.of<ProductProvider>(context, listen: false);
            productProvider.getProducts();
            Navigator.of(context).maybePop();
          },
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.red.shade300
            ),
            onPressed: (cart.isLoading || cart.productCount == 0) ? null : () async {
              final res = await yesNoDialog(
                context,
                'Desea vaciar el carrito?'
              );
              if (res) {
                cart.empty();
              }
            },
            child: Icon(Icons.delete_outline)
          )
        ],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Mi carrito', style: TextStyles.appBarText),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                "assets/icons/cart.svg",
                color: kTextColor,
              ),
            )
          ]
        ),
      ),
      body: (cart.isLoading) ?
        Center(child: LoadingIndicator(size: 40))
        :
        buildBody(context)
    );
  }

  Widget buildBody(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    if (cart.products.isEmpty) {
      return Center(
        child: ColoredText('El carrito esta vacio!',
          fontSize: 24
        ),
      );
    }
    final size = MediaQuery.of(context).size;
    final checkoutBoxHeight = size.height/5;
    final checkoutBoxBottomMargin = checkoutBoxHeight/2;
    final productSize = size.width/6;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.products.length,
            itemBuilder: (context, index) {
              final product = cart.products[index];
              return Dismissible(
                key: product.key!,
                direction: DismissDirection.endToStart,
                onDismissed: (DismissDirection direction) {
                  cart.delete(product);
                },
                background: Container(
                  color: Colors.red.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.delete_outline, color: Colors.red.shade300, size: 50),
                      )
                    ]
                  ),
                ),
                child: CartProduct(product: product, size: productSize)
              );
            },
          ),
        ),
        Container(
          height: checkoutBoxHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: kTextLightColor,
                blurRadius: 4.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, -1.5), // shadow direction: bottom right
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CheckoutText("${cart.productCount} producto${(cart.productCount > 1) ? 's' : ''}", fontSize: 20),
                        CheckoutText("\$ ${cart.totalAmount} total", fontSize: 26)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO Simular checkout
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CheckoutText('Comprar', fontSize: 22),
                      )
                    ),
                  )
                ]
              ),
              SizedBox(height: checkoutBoxBottomMargin)
            ],
          ),
        )
      ],
    );
  }
}

class CartProduct extends StatelessWidget {
  const CartProduct({
    Key? key,
    required this.product,
    required this.size
  }) : super(key: key);

  final Product product;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16)
      ),
      child: ListTile(
        leading: SizedBox(
          width: size,
          height: size,
          child: Image.asset(
            product.image,
            fit: BoxFit.contain,
          ),
        ),
        title: ColoredText(product.title),
        subtitle: ColoredText("\$ ${product.price}"),
      ),
    );
  }
}