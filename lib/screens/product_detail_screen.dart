import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/ProductDetailScreen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final selectedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(selectedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300, 
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(selectedProduct.title,),
              background: Hero(
                tag: selectedProduct.id,
                child: Image.network(
                  selectedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
              height: 20,
            ),
            Text(
              selectedProduct.description,
              style: TextStyle(fontSize: 40, color: Colors.grey),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text('\$${selectedProduct.price}', textAlign: TextAlign.center,),
            SizedBox(height: 800,)
            ]),
          )
        ],
        
      ),
    );
  }
}
