import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/product_provider.dart';
import '../../providers/search_provider.dart';
import '../../ui/text_styles.dart';
import '../home/components/body.dart';
import '../../widgets/loading.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({ Key? key }) : super(key: key);

  static const routeName = '/search';

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      builder: (context, _) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColorDefault,
          elevation: 1,
          leading: BackButton(
            color: kTextLightColor,
            onPressed: () {
              final productProvider = Provider.of<ProductProvider>(context, listen: false);
              productProvider.getProducts();
              Navigator.of(context).pop();
            },
          ),
          title: TextField(
            textInputAction: TextInputAction.search,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Buscar productos'
            ),
            controller: searchController,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                final search = Provider.of<SearchProvider>(context, listen: false);
                search.searchProducts(value);
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                searchController.clear();
              },
              icon: Icon(Icons.clear_outlined),
              color: kTextLightColor
            )
          ],
        ),
        body: buildBody(context)
      )
    );
  }

  Widget buildBody(BuildContext context) {
    final search = Provider.of<SearchProvider>(context);

    if (search.isLoading) {
      return Center(child: LoadingIndicator(size: 40));
    }
    else {
      if (searchController.text.isEmpty) {
        return Container();
      }
      else if (search.products.isEmpty) {
        return Center(child: DefaultText('No se encontraron productos', fontSize: 18));
      }
      else {
        return Body(search.products);
      }
    }
  }
}