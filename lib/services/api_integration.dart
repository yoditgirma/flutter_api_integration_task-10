import 'package:dio/dio.dart';
import '../models/product_model.dart';

final dio = Dio();

Future<List<Product>> fetchProducts() async {
  final response = await dio.get("https://fakestoreapi.com/products");

  final List data = response.data;
  final List<Product> products = [];

  for (var item in data) {
    products.add(Product.fromJson(item));
  }

  return products;
}

Future<void> fetchData() async {
  try {
    final response = await dio.get("https://fakestoreapi.com/products");
    print(response);
  } catch (e) {
    print('Something is wrong');
  }
}
