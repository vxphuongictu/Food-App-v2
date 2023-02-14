import 'package:food_e/core/GraphQLConfig.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/functions/queries.dart' as queries;
import 'package:food_e/models/Products.dart';
import 'package:food_e/core/DatabaseManager.dart';


Future<List<Products>> fetch_products() async
{

  List<Products> allProducts = [];

  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.query(
      QueryOptions(
        document: gql(queries.query_fetchProducts()),
      )
  );

  if (result.data != null) { // if connected to server
    await DatabaseManager().deleteProducts();
    final dynamic data = Map<String, dynamic>.from(result.data!);
    for (var item in data['products']['edges']) {
      final data = Products.formJson(item['node']);
      await DatabaseManager().insertProducts(data);
      allProducts.add(data);
    }
  } else { // else fetch data from database
    List<dynamic> fetchData = await DatabaseManager().fetchProducts();
    for (var product in fetchData) {
      final data = Products.fromMap(product);
      allProducts.add(data);
    }
  }
  return allProducts;
}