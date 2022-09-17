import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../../providers/cart_provider.dart';
import '../../../ui/text_styles.dart';
import '../../../widgets/loading.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.product
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: buttonColorDefault,//(cart.isLoading) ? Colors.grey : buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
        ),
        onPressed: (cart.isLoading) ? null : () async {
          final success = await cart.add(product);
          if (success) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.grey.shade100,
              content: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.check, size: 42, color: Colors.green.shade500),
                  SizedBox(width: 8),
                  ColoredText(
                    'Producto agregado',
                    fontSize: 18
                  )
                ]
              )
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            children: [
              Expanded(child: Container()),
              (cart.isLoading) ?
                LoadingIndicator(size: 25)
                :
                SvgPicture.asset(
                  "assets/icons/add_to_cart.svg",
                  color: kTextColor,
                ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DefaultText('Agregar al carrito', color: buttonTextColorDefault),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
