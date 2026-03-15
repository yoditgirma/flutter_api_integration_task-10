import 'package:flutter/material.dart';
import 'package:flutter_api_integration/models/product_model.dart';
import 'package:flutter_api_integration/services/api_integration.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<void> refreshData() async {
    await fetchProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withValues(alpha: 0.2),
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      leading: Icon(Icons.window_sharp, color: Colors.blue),
      title: Text('Product Catalog'),
      actions: [
        IconButton(onPressed: () => refreshData(), icon: Icon(Icons.refresh)),
      ],
    );
  }

  Widget getBody() {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('PULL TO UPDATE CATALOG'),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshData,
              child: FutureBuilder<List<Product>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error Occured');
                  }

                  final products = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),

                          child: Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            mainAxisSize: .min,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 170,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                    ),

                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.6,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite, size: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  product.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),

                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),

                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  product.category,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
