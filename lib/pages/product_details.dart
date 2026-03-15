import 'package:flutter/material.dart';
import 'package:flutter_api_integration/models/product_model.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(), body: getBody(context));
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      title: Text(
        'Product Details',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
    );
  }

  Widget? getBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.45,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              image: DecorationImage(
                image: NetworkImage(product.image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          // SizedBox(height: 30),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    product.title,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite, color: Colors.blue),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '\$${product.price}',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Description',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              product.description,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
